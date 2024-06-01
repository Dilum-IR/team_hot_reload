import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hot_reload/app/screens/auth/signup_screen.dart';
import 'package:hot_reload/utils/constraints/texts.dart';
import '../../../components/style/app_input_style.dart';
import '../../../components/style/text_styles.dart';
import '../../../utils/helper/device.dart';
import '../../../utils/helper/user_handler.dart';
import '../../controllers/user/user_signup_controller.dart';
import '../welcome_screen.dart';

class UserSignin extends StatefulWidget {
  const UserSignin({super.key});

  @override
  State<UserSignin> createState() => UserSigninState();
}

class UserSigninState extends State<UserSignin> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  // password visibility
  bool _isVisible = false;

  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.grey;
      }
      return Colors.black;
    }

    var height = KDeviceUtils.getHeight(context);
    var width = KDeviceUtils.getWidth(context);

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: const BouncingScrollPhysics(),
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Container(
          height: height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 2,
              ),
              Stack(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 30),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: const DecorationImage(
                        image: AssetImage(
                          KTexts.loginPageImage,
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                    width: width,
                    height: height / 3.5,
                  ),
                  Positioned(
                    top: 40,
                    left: 5,
                    // height: 100,
                    child: IconButton(
                      onPressed: () {
                        Get.to(
                          () => const WelcomeScreen(),
                          transition: Transition.fade,
                          duration: const Duration(milliseconds: 500),
                        );
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios_new_rounded,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                width: width - 50,
                child: const Text(
                  "Welcome Back!",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: height / 20),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 25,
                ),
                child: Column(
                  children: [
                    TextField(
                      controller: emailController,
                      onChanged: (email) => onEmailChanged(email),
                      decoration: InputDecoration(
                        border: AppInputStyle.outlineInputBorder,
                        focusedBorder: AppInputStyle.outlineInputBorder,
                        contentPadding: AppInputStyle.contentPadding,
                        filled: validEmail ? true : false,
                        fillColor: AppInputStyle.validFillColor,
                        hintText: "brandonloise@gmail.com",
                        labelText: "Email",
                        hintStyle: KTextStyles.smallerGText,
                        labelStyle: KTextStyles.smallerBText,
                        floatingLabelStyle: KTextStyles.blackXlText,
                        prefixIcon: AppInputStyle.emailIcon,
                      ),
                    ),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 1000),
                      width: width - 65,
                      child: Text(
                        textAlign: TextAlign.start,
                        _emailError,
                        style: KTextStyles.errorTextStyle,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextField(
                      controller: passwordController,
                      onChanged: (email) => onPasswordChanged(email),
                      obscureText: !_isVisible,
                      obscuringCharacter: AppInputStyle.obscuringCharacter,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          splashRadius: 5,
                          onPressed: () {
                            setState(() {
                              _isVisible = !_isVisible;
                            });
                          },
                          icon: _isVisible
                              ? AppInputStyle.visibleIcon
                              : AppInputStyle.visibilityOffIcon,
                        ),
                        border: AppInputStyle.outlineInputBorder,
                        focusedBorder: AppInputStyle.outlineInputBorder,
                        contentPadding: AppInputStyle.contentPadding,
                        filled: validpassword ? true : false,
                        fillColor: AppInputStyle.validFillColor,
                        hintText: AppInputStyle.hintObsureCharacter,
                        labelText: "Password",
                        hintStyle: KTextStyles.smallerGText,
                        labelStyle: KTextStyles.smallerBText,
                        floatingLabelStyle: KTextStyles.blackXlText,
                        prefixIcon: AppInputStyle.passwordIcon,
                      ),
                    ),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 1000),
                      width: width - 65,
                      child: Text(
                        textAlign: TextAlign.start,
                        _passwordError,
                        style: KTextStyles.errorTextStyle,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Row(
                            children: [
                              Checkbox(
                                checkColor: Colors.white,
                                fillColor:
                                    MaterialStateProperty.resolveWith(getColor),
                                value: isChecked,
                                onChanged: (bool? value) {
                                  setState(() {
                                    isChecked = value!;
                                  });
                                },
                              ),
                              Text(
                                "Remember me",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: isChecked
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          style: TextButton.styleFrom(
                            primary: Colors.black,
                          ),
                          child: const Text(
                            "Forget Password?",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    MaterialButton(
                      animationDuration: const Duration(milliseconds: 10000),
                      height: 40,
                      minWidth: double.infinity,
                      disabledColor: Colors.black54,
                      onPressed: (validEmail && validpassword) && !istap
                          ? () {
                              loginUser();
                              if (mounted) {
                                setState(() {
                                  istap = !istap;
                                });
                              }
                              Future.delayed(const Duration(seconds: 4), () {
                                if (mounted) {
                                  setState(() {
                                    istap = !istap;
                                  });
                                }
                              });
                            }
                          : null,
                      color: Colors.black,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                      child: Container(
                        decoration: BoxDecoration(
                          // color: Colors.orange,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: istap
                              ? const SizedBox(
                                  width: 15,
                                  height: 15,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2,
                                  ),
                                )
                              : const Text(
                                  "Sign In",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text("Or Sign in with",
                  style: TextStyle(color: Colors.grey)),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      height: 60,
                      width: 60,
                      child: Image.asset(KTexts.appleLogo),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: CircleAvatar(
                      radius: 27,
                      backgroundColor: Colors.grey.shade400,
                      child: CircleAvatar(
                        radius: 25,
                        backgroundColor: Colors.white,
                        child: GestureDetector(
                          onTap: () async {
                            if (mounted) {
                              setState(() {
                                istap = !istap;
                              });
                            }
                            if (kDebugMode) {
                              print("facebook taped");
                            }
                            await controller.facebookSignIn();

                            Future.delayed(
                              const Duration(seconds: 4),
                              () {
                                if (mounted) {
                                  setState(() {
                                    istap = !istap;
                                  });
                                }
                              },
                            );
                          },
                          child: Container(
                            height: 45,
                            width: 45,
                            child: Image.asset(KTexts.facebookLogo),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      // KDeviceUtils.launchUrl("https://www.google.com");
                    },
                    child: CircleAvatar(
                      radius: 27,
                      backgroundColor: Colors.grey.shade400,
                      child: CircleAvatar(
                        radius: 25,
                        backgroundColor: Colors.white,
                        child: GestureDetector(
                          onTap: () async {
                            if (mounted) {
                              setState(() {
                                istap = !istap;
                              });
                            }
                            if (kDebugMode) {
                              print("google taped");
                            }
                            await controller.googleSignIn();

                            Future.delayed(
                              const Duration(seconds: 4),
                              () {
                                if (mounted) {
                                  setState(() {
                                    istap = !istap;
                                  });
                                }
                              },
                            );
                          },
                          child: Container(
                            height: 30,
                            width: 30,
                            child: Image.asset(KTexts.googleLogo),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(child: Container()),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account ?"),
                  TextButton(
                    style: TextButton.styleFrom(
                      primary: Colors.black,
                    ),
                    onPressed: (() {
                      print(UserHandler.currentUser);
                      UserHandler.currentUser == null
                          ? Get.back()
                          : UserHandler.currentUser != UserHandler.userType
                              ? Get.offAll(
                                  () => const WelcomeScreen(),
                                  transition: Transition.zoom,
                                  duration: const Duration(milliseconds: 500),
                                )
                              : Get.offAll(
                                  () => const UserSignup(),
                                  transition: Transition.zoom,
                                  duration: const Duration(milliseconds: 500),
                                );
                    }),
                    child: const Text("Sign Up"),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  bool istap = false;

  final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

  bool validInput = false;

  bool validEmail = false;

  String _emailError = '';

  @override
  void dispose() {
    // TODO: implement dispose

    super.dispose();
  }

  onEmailChanged(String email) {
    setState(() {
      _emailError = '';
      validEmail = false;

      if (email.isEmpty)
        _emailError = "* Email is required.";
      else if (!emailRegExp.hasMatch(email))
        _emailError = "* Email is invalid.";
      else {
        _emailError = '';
        validEmail = true;
      }
    });
  }

  bool validpassword = false;
  String _passwordError = '';

  onPasswordChanged(String repassword) {
    setState(() {
      _passwordError = '';
      validpassword = false;

      if (repassword.isEmpty) {
        _passwordError = "* Password is required.";
        return;
      } else {
        _passwordError = "";
        validpassword = true;
      }
    });
  }

  final controller = Get.put(UserSignUpController());

  void loginUser() {
    final email = emailController.text.trim().toString();
    final password = passwordController.text.trim().toString();

    controller.loginAllUsers(email, password);
  }
}
