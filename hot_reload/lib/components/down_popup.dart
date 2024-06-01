import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../app/screens/auth/signup_screen.dart';
import '../utils/helper/user_handler.dart';

class DownPopup {
  static void showPopupContainer(BuildContext context) {
    showModalBottomSheet(
      isDismissible: true,
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(20.0),
          decoration: const BoxDecoration(
              // color: Colors.orange,
              borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          )),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Choose Your Signup Options',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Column(
                children: [
                  MaterialButton(
                    animationDuration: const Duration(milliseconds: 10000),
                    height: 50,
                    minWidth: double.infinity,
                    disabledColor: Colors.black54,
                    onPressed: () {
                      UserHandler.currentUser = UserHandler.kUserType;
                      Get.to(
                        const UserSignup(),
                        transition: Transition.fade,
                        duration: const Duration(milliseconds: 500),
                      );
                    },
                    color: Colors.black,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: const Text(
                      "Register as a User",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  MaterialButton(
                    animationDuration: const Duration(milliseconds: 10000),
                    height: 50,
                    minWidth: double.infinity,
                    disabledColor: Colors.orangeAccent.withOpacity(0.5),
                    splashColor: Colors.orangeAccent.withOpacity(0.5),
                    onPressed: () {
                      UserHandler.currentUser = UserHandler.kEmpType;
                      Get.to(
                        UserSignup(),
                        transition: Transition.fade,
                        duration: const Duration(milliseconds: 500),
                      );
                    },
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.orangeAccent),
                        borderRadius: BorderRadius.circular(10)),
                    child: const Text(
                      "Register as a Employee",
                      style: TextStyle(
                        color: Colors.orangeAccent,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
