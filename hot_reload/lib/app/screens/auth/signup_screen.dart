import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hot_reload/app/screens/auth/signin_screen.dart';
import 'package:hot_reload/utils/constraints/texts.dart';
import '../../../components/style/app_input_style.dart';
import '../../../components/style/text_styles.dart';
import '../../../utils/helper/device.dart';
import '../../../utils/helper/user_handler.dart';
import '../../../components/widget/comman_widget/alert_popup.dart';
import '../../controllers/user/user_signup_controller.dart';

class UserSignup extends StatefulWidget {
  const UserSignup({super.key});

  @override
  State<UserSignup> createState() => UserSignupState();
}

class UserSignupState extends State<UserSignup> {
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController re_passwordController = TextEditingController();

  @override
  void initState() {
    // print("User " + UserHandler.currentUser);
    super.initState();
  }

  // password visibility
  bool _isVisible = false;

  // confirm password visibility
  bool _iscVisible = false;

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
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        dragStartBehavior: DragStartBehavior.start,
        child: Container(
            height: height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 30),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: const DecorationImage(
                      image: AssetImage(KTexts.signupPageImage),
                      fit: BoxFit.cover,
                    ),
                  ),
                  width: width,
                  height: height / 4.3,
                ),
                const SizedBox(
                  height: 10,
                ),
                // SizedBox(height: height / 8),
                Container(
                  width: width - 50,
                  child: const Text(
                    "Create an Account",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 27,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 25,
                  ),
                  child: Column(
                    children: [
                      TextField(
                        controller: nameController,
                        onChanged: (name) => onNameChanged(name),
                        decoration: InputDecoration(
                          border: AppInputStyle.outlineInputBorder,
                          focusedBorder: AppInputStyle.outlineInputBorder,
                          contentPadding: AppInputStyle.contentPadding,
                          filled: validName ? true : false,
                          fillColor: AppInputStyle.validFillColor,
                          hintText: "Brandon Loise",
                          labelText: "Name of the ${UserHandler.currentUser}",
                          hintStyle: KTextStyles.smallerGText,
                          labelStyle: KTextStyles.smallerBText,
                          floatingLabelStyle: KTextStyles.blackXlText,
                          prefixIcon: AppInputStyle.profileIcon,
                          errorBorder: _nameError == ''
                              ? AppInputStyle.InputErrorBorder
                              : AppInputStyle.outlineInputBorder,
                        ),
                      ),
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 1000),
                        width: width - 65,
                        child: Text(
                          textAlign: TextAlign.start,
                          _nameError,
                          style: KTextStyles.errorTextStyle,
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
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
                        height: 8,
                      ),
                      TextField(
                        controller: passwordController,
                        onChanged: (password) => onPasswordChanged(password),
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
                          filled: validPassword ? true : false,
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
                        height: 8,
                      ),
                      TextField(
                        controller: re_passwordController,
                        onChanged: (re_password) =>
                            onRePasswordChanged(re_password),
                        obscureText: !_iscVisible,
                        obscuringCharacter: AppInputStyle.obscuringCharacter,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            splashRadius: 5,
                            onPressed: () {
                              setState(() {
                                _iscVisible = !_iscVisible;
                              });
                            },
                            icon: _iscVisible
                                ? AppInputStyle.visibleIcon
                                : AppInputStyle.visibilityOffIcon,
                          ),
                          border: AppInputStyle.outlineInputBorder,
                          focusedBorder: AppInputStyle.outlineInputBorder,
                          contentPadding: AppInputStyle.contentPadding,
                          filled: validRepassword ? true : false,
                          fillColor: AppInputStyle.validFillColor,
                          hintText: AppInputStyle.hintObsureCharacter,
                          labelText: "Confirm Password",
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
                          _repasswordError,
                          style: KTextStyles.errorTextStyle,
                        ),
                      ),
                      Row(
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
                      const SizedBox(
                        height: 5,
                      ),
                      MaterialButton(
                        animationDuration: const Duration(milliseconds: 10000),
                        height: 40,
                        minWidth: double.infinity,
                        disabledColor: Colors.black54,
                        onPressed: validInputData() && !istap
                            ? () {
                                registerUser();
                                setState(() {
                                  istap = !istap;
                                });
                                Future.delayed(const Duration(seconds: 4), () {
                                  setState(() {
                                    istap = !istap;
                                  });
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
                                    "Sign Up",
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
                  height: 10,
                ),
                const Text("Or Sign Up with",
                    style: TextStyle(color: Colors.grey)),
                const SizedBox(
                  height: 10,
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
                          child: Container(
                            height: 45,
                            width: 45,
                            child: Image.asset(KTexts.facebookLogo),
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
                          child: Container(
                            height: 30,
                            width: 30,
                            child: Image.asset(KTexts.googleLogo),
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
                    const Text("Already a Member ?"),
                    TextButton(
                      style: TextButton.styleFrom(
                        primary: Colors.black,
                      ),
                      onPressed: (() {
                        Get.offAll(
                          () => const UserSignin(),
                          transition: Transition.leftToRight,
                          duration: const Duration(milliseconds: 500),
                        );
                      }),
                      child: const Text("Login"),
                    ),
                  ],
                )
              ],
            )),
      ),
    );
  }

  final specialDigitRegex = RegExp(r'^(?=.*[!@#$%^&*()_+{}\[\]:;<>,.?~\\-])');
  final numericRegex = RegExp(r'[0-9]');
  final nameRegex = RegExp(r'^[a-zA-Z]+(?:\s[a-zA-Z]+)*$');
  final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

  bool validInput = false;
  bool istap = false;

  bool validName = false;
  String _nameError = '';

  onNameChanged(String name) {
    setState(() {
      _nameError = '';
      validName = false;
      if (name.isEmpty) {
        _nameError = "* Name is required.";
      } else if (!nameRegex.hasMatch(name) || name.length < 3) {
        _nameError = "* Name is invalid.";
      } else {
        _nameError = "";
        validName = true;
      }
    });
  }

  bool validEmail = false;

  String _emailError = '';

  onEmailChanged(String email) {
    setState(() {
      _emailError = '';
      validEmail = false;

      if (email.isEmpty) {
        _emailError = "* Email is required.";
      } else if (!emailRegExp.hasMatch(email)) {
        _emailError = "* Email is invalid.";
      } else {
        _emailError = '';
        validEmail = true;
      }
    });
  }

  bool validPassword = false;

  String _passwordError = '';

  onPasswordChanged(String password) {
    setState(() {
      _passwordError = '';
      validPassword = false;

      if (password.isEmpty) {
        _passwordError = "* Password is required.";
        return;
      }
      if (password.length <= 7) {
        _passwordError = "* Password must be 7 characters long.";
      } else if (!numericRegex.hasMatch(password)) {
        _passwordError = "* Password must contain at least one number.";
      } else if (!specialDigitRegex.hasMatch(password)) {
        _passwordError = '* Password must contain at least one special digit.';
      } else if (password.trim().toString() !=
              re_passwordController.text.trim().toString() &&
          re_passwordController.text.isNotEmpty) {
        _repasswordError = "* Password does not match.";
        validPassword = false;
        validRepassword = false;
      } else if (password.trim().toString() ==
          re_passwordController.text.trim().toString()) {
        _repasswordError = "";
        validPassword = true;
        validRepassword = true;
      } else {
        _passwordError = "";
        validPassword = true;
      }
    });
  }

  bool validRepassword = false;
  String _repasswordError = '';

  onRePasswordChanged(String repassword) {
    setState(() {
      _repasswordError = '';
      validRepassword = false;

      if (repassword.isEmpty) {
        _repasswordError = "*Confirm Password is required.";
        return;
      }
      if (repassword.length <= 7) {
        _repasswordError = "* Password must be 7 characters long.";
      } else if (!numericRegex.hasMatch(repassword)) {
        _repasswordError = "* Password must contain at least one number.";
      } else if (!specialDigitRegex.hasMatch(repassword)) {
        _repasswordError =
            '* Password must contain at least one special digit.';
      } else if (repassword.trim().toString() !=
          passwordController.text.trim().toString()) {
        _repasswordError = "* Password does not match.";
      } else {
        _repasswordError = "";
        validRepassword = true;
      }
    });
  }

  bool validInputData() {
    if (validPassword && validRepassword && validEmail && validName) {
      return true;
    } else {
      return false;
    }
  }

  final controller = Get.put(UserSignUpController());

  void registerUser() {
    final name = nameController.text.trim().toString();
    final email = emailController.text.trim().toString();
    final password = passwordController.text.trim().toString();
    final repassword = re_passwordController.text.trim().toString();

    final userType = UserHandler.currentUser;

    if (password != repassword) {
      AlertPopup.warning(
        title: "Password Wrong",
        message: "Password does not match.",
        type: 1,
      );
      return;
    }
    controller.registerAsUser(name, email, password, userType);
  }
}
