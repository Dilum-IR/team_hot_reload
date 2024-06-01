import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../utils/constraints/colors.dart';
import '../../../utils/constraints/texts.dart';
import '../welcome_screen.dart';
import 'on_board_page.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen>
    with TickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> fadeAnimation;

  @override
  void initState() {
    animation();
    super.initState();
  }

  void animation() {
    animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..forward();

    fadeAnimation = CurvedAnimation(
      parent: animationController,
      curve: Curves.easeOut,
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  final pages = [
    const OnBoardPage(
      color: KColors.onboardColor,
      image: KTexts.onBoardImage1,
      title: "Welcome to Career Wave!",
      sub_title: "Sign in to your CareerWave account!",
    ),
    const OnBoardPage(
      color: KColors.onboardColor,
      image: KTexts.onBoardImage2,
      title: "Connect With Job Community",
      sub_title: "Surf Your Way to Success!",
    ),
    const OnBoardPage(
      color: KColors.onboardColor,
      image: KTexts.onBoardImage3,
      title: "Get Started Now",
      sub_title: "Unlock doors to your dream career journey!",
    ),
  ];

  final controller = LiquidController();
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          LiquidSwipe(
            slideIconWidget: currentPage != 2
                ? const Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: Colors.orangeAccent,
                    size: 28,
                  )
                : Container(),
            enableSideReveal: true,
            liquidController: controller,
            enableLoop: false,
            pages: pages,
            onPageChangeCallback: onPageChangeCallBack,
          ),
          Positioned(
              bottom: 50,
              child: OutlinedButton(
                  style: ElevatedButton.styleFrom(
                    side: const BorderSide(color: Colors.black45, width: 5),
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(15),
                  ),
                  onPressed: currentPage == 2
                      ? null
                      : () {
                          setState(() {
                            currentPage++;
                          });
                          controller.animateToPage(
                            page: currentPage,
                            duration: 500,
                          );
                        },
                  child: Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.black87,
                    ),
                    padding: EdgeInsets.all(20),
                    child: const Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: Colors.white,
                    ),
                  ))),
          Positioned(
            bottom: 20,
            child: AnimatedSmoothIndicator(
              effect: const WormEffect(
                  dotHeight: 5,
                  dotColor: Colors.black45,
                  activeDotColor: Colors.orangeAccent),
              activeIndex: controller.currentPage,
              count: 3,
            ),
          ),
          Positioned(
            bottom: 30,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FadeTransition(
                  opacity: fadeAnimation,
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        currentPage = 2;
                      });
                      controller.jumpToPage(page: 2);
                    },
                    child: currentPage != 2
                        ? const Text(
                            "Skip",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.black87,
                            ),
                          )
                        : Container(),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 1.7,
                ),
                TextButton(
                  onPressed: currentPage == 2
                      ? () {
                          Get.to(
                            const WelcomeScreen(),
                            transition: Transition.fade,
                            duration: const Duration(seconds: 1),
                          );
                        }
                      : () {
                          setState(() {
                            currentPage++;
                          });
                          controller.animateToPage(
                            page: currentPage,
                            duration: 500,
                          );
                        },
                  child: const Text(
                    "Next",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.orangeAccent,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void onPageChangeCallBack(int activePageIndex) {
    setState(() {
      currentPage = activePageIndex;
    });
  }
}
