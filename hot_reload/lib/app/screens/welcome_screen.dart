import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hot_reload/components/style/text_styles.dart';
import 'package:hot_reload/utils/constraints/texts.dart';

import '../../components/down_popup.dart';
import '../../utils/constraints/colors.dart';
import '../../utils/helper/device.dart';
import '../../utils/helper/user_handler.dart';
import 'auth/signin_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with TickerProviderStateMixin {
  int activeIndex = 0;
  Timer? _timer;

  @override
  void initState() {
    animation();
    UserHandler.currentUser = null;
    UserHandler.email = null;
    UserHandler.name = null;
    UserHandler.id = null;
    UserHandler.userType = null;

    _timer = Timer.periodic(Duration(seconds: 5), (timer) {
      setState(() {
        activeIndex++;

        if (activeIndex == 4) activeIndex = 0;
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _timer?.cancel();
    slideController.dispose();
    fadeController.dispose();
    super.dispose();
  }

  late AnimationController fadeController;
  late AnimationController slideController;

  late Animation<double> fadeAnimation;
  late Animation<double> slideAnimation;

  void animation() {
    slideController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    )..forward().then((value) => null);

    fadeController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..forward();

    slideAnimation =
        Tween<double>(begin: 1.0, end: 0.0).animate(CurvedAnimation(
      parent: slideController,
      curve: Curves.easeInOut,
    ));

    fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: fadeController,
        curve: Curves.easeInQuad,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var height = KDeviceUtils.getHeight(context);
    var width = KDeviceUtils.getWidth(context);

    return WillPopScope(
      onWillPop: () async {
        return await true;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 10,
                ),
                FadeTransition(
                  opacity: fadeAnimation,
                  child: Container(
                    height: height / 2.5,
                    width: width,
                    child: Stack(
                      children: [
                        Positioned(
                          top: 0,
                          left: 0,
                          right: 0,
                          bottom: 0,
                          child: AnimatedOpacity(
                            opacity: activeIndex == 0 ? 1 : 0,
                            duration: const Duration(
                              seconds: 1,
                            ),
                            curve: Curves.linear,
                            child: Image.asset(
                              KTexts.sliderImages[0],
                              height: 400,
                            ),
                          ),
                        ),
                        Positioned(
                          top: 0,
                          left: 0,
                          right: 0,
                          bottom: 0,
                          child: AnimatedOpacity(
                            opacity: activeIndex == 1 ? 1 : 0,
                            duration: const Duration(seconds: 1),
                            curve: Curves.linear,
                            child: Image.asset(
                              KTexts.sliderImages[1],
                              height: 400,
                            ),
                          ),
                        ),
                        Positioned(
                          top: 0,
                          left: 0,
                          right: 0,
                          bottom: 0,
                          child: AnimatedOpacity(
                            opacity: activeIndex == 2 ? 1 : 0,
                            duration: const Duration(seconds: 1),
                            curve: Curves.linear,
                            child: Image.asset(
                              KTexts.sliderImages[2],
                              height: 400,
                            ),
                          ),
                        ),
                        Positioned(
                          top: 0,
                          left: 0,
                          right: 0,
                          bottom: 0,
                          child: AnimatedOpacity(
                            opacity: activeIndex == 3 ? 1 : 0,
                            duration: const Duration(seconds: 1),
                            curve: Curves.linear,
                            child: Image.asset(
                              KTexts.sliderImages[3],
                              height: 400,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                FadeTransition(
                  opacity: fadeAnimation,
                  child: Text(
                    'Welcome',
                    style: KTextStyles.blackXXLBText,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                FadeTransition(
                  opacity: fadeAnimation,
                  child: Container(
                    height: 120,
                    width: 120,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      boxShadow: const [
                        BoxShadow(
                          offset: Offset(0, 0),
                          color: Colors.black26,
                          blurRadius: 10,
                          spreadRadius: -6,
                        ),
                      ],
                      image: const DecorationImage(
                        image: AssetImage(
                          KTexts.logo,
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                // Text(
                //   'CareerWave',
                //   style: TextStyle(
                //     fontSize: 32,
                //     fontFamily: "Prompt",
                //     fontWeight: FontWeight.bold,
                //   ),
                // ),
                const SizedBox(
                  height: 15,
                ),
                FadeTransition(
                  opacity: fadeAnimation,
                  child: Container(
                    width: width,
                    alignment: Alignment.center,
                    child: DefaultTextStyle(
                      style: GoogleFonts.lato(
                        wordSpacing: 0.2,

                        // fontWeight: FontWeight.w700,
                        fontSize: 16,
                        color: Colors.black,
                        shadows: [
                          const BoxShadow(
                            offset: Offset(0, 0),
                            color: Colors.black54,
                            blurRadius: 20,
                            spreadRadius: 0,
                          ),
                        ],
                      ),
                      child: AnimatedTextKit(
                        pause: const Duration(seconds: 2),
                        isRepeatingAnimation: true,
                        totalRepeatCount: 100,
                        animatedTexts: [
                          TyperAnimatedText(
                            KTexts.onBoardingTitle1,
                            speed: const Duration(milliseconds: 100),
                          ),
                          TyperAnimatedText(
                            KTexts.onBoardingTitle2,
                            speed: const Duration(milliseconds: 100),
                          ),
                          TyperAnimatedText(
                            KTexts.onBoardingTitle3,
                            speed: const Duration(milliseconds: 100),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(flex: 2, child: Container()),
                AnimatedBuilder(
                  animation: slideController,
                  builder: (context, child) {
                    return Transform.translate(
                      offset: Offset(-1.0, slideAnimation.value * 180),
                      child: Opacity(
                        opacity: fadeAnimation.value,
                        child: child,
                      ),
                    );
                  },
                  child: Column(
                    children: [
                      MaterialButton(
                        animationDuration: const Duration(milliseconds: 1000),
                        height: 50,
                        minWidth: width,
                        disabledColor: Colors.black54,
                        onPressed: () {
                          Get.to(
                            () => UserSignin(),
                            transition: Transition.fade,
                            duration: const Duration(milliseconds: 500),
                          );
                        },
                        color: Colors.black,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: Text(
                          "Login",
                          style: GoogleFonts.lato(
                            color: KColors.white,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      MaterialButton(
                        animationDuration: const Duration(milliseconds: 1000),
                        height: 50,
                        minWidth: double.infinity,
                        disabledColor: Colors.orangeAccent.withOpacity(0.7),
                        splashColor: Colors.orangeAccent.withOpacity(0.7),
                        onPressed: () {
                          DownPopup.showPopupContainer(context);
                        },
                        color: KColors.primary,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: Text(
                          "Register",
                          style: GoogleFonts.lato(
                            color: KColors.white,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
