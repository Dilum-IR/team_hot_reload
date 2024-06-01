import 'package:get/get.dart';

import '../app/screens/auth/signin_screen.dart';
import '../app/screens/auth/signup_screen.dart';
import '../app/screens/user/navigation_bar.dart';
import '../app/screens/welcome_screen.dart';

class Router {
  static back() => Get.back();

  static navPage() => Get.offAll(
        () => const CustomNavigationBar(),
        transition: Transition.circularReveal,
        duration: const Duration(milliseconds: 1000),
      );

  static logout() => Get.offAll(
        () => const WelcomeScreen(),
        transition: Transition.circularReveal,
        duration: const Duration(milliseconds: 1000),
      );

  static userRegister() => Get.to(() => const UserSignup(),
      transition: Transition.fadeIn,
      duration: const Duration(milliseconds: 700));

  static userLogin() => Get.to(() => const UserSignin(),
      transition: Transition.fadeIn,
      duration: const Duration(milliseconds: 700));
}
