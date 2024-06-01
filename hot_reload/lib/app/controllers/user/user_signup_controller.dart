import 'package:get/get.dart';
import 'package:hot_reload/app/controllers/user/shared_auth_user.dart';

import '../../../components/widget/comman_widget/alert_popup.dart';
import '../../../services/authentication_services.dart';
import '../../../services/crud_services.dart';
import '../../../utils/helper/user_handler.dart';
import '../../model/user_model.dart';
import '../../screens/auth/signin_screen.dart';
import '../../screens/user/navigation_bar.dart';

class UserSignUpController extends GetxController {
  final authController = Get.put(AuthenticationService());

  final crudController = Get.put(CrudServices());

  static UserSignUpController get instance => Get.find();

  void registerAsUser(
      String name, String email, String password, String userType) async {
    try {
      // print(userType);
      // return;
      final userCredential = await authController.registerUser(email, password);

      final newUser = UserModel.register(
        email: email,
        id: userCredential.user!.uid,
        name: name,
        userType: userType,
      );

      await authController
          .insertUser(collection: "Users", user: newUser)
          .whenComplete(() {
        AlertPopup.warning(
          title: "Congratulations! 🎉",
          message: "Your account has been created!",
          type: 0,
        );
      });

      Get.to(
        () => const UserSignin(),
        transition: Transition.rightToLeft,
        duration: const Duration(milliseconds: 500),
      );
    } catch (e) {}
  }

  void loginAllUsers(String email, String password) async {
    String userId = "";
    try {
      await authController.loginUser(email, password).then((value) {
        userId = value.user!.uid;
      });

      // get user all information for saved to local storage
      final userData =
          await crudController.findOne(collection: "Users", filed: userId);

      // print(userData);

      if (userData.isNotEmpty) {
        AlertPopup.warning(
          title: "Congratulations! 🎉",
          message: "Login Successful!",
          type: 0,
        );

        // print(userData[0].image_url.toString());

        if (userData[0].userType == UserHandler.kUserType) {
          Get.offAll(
            () => const CustomNavigationBar(),
            transition: Transition.cupertino,
            duration: const Duration(milliseconds: 1000),
          );
        }
      }

      // save the users data in to the memory
      if (userData[0] != null) {
        final authUser = [
          userData[0].id.toString(),
          userData[0].userType.toString(),
          userData[0].email.toString(),
          userData[0].name.toString(),
        ];
        SharedAuthUser.saveAuthUser(authUser);

        final aboutme = [
          // dob
          userData[0].dob.toString(),
          // phone
          userData[0].phone.toString(),
        ];

        SharedAuthUser.saveAuthInfoUser(aboutme);
      }

      if (userData[0].image_url != null) {
        SharedAuthUser.saveimageUrl(userData[0].image_url.toString());
      }
    } catch (e) {}
  }

  Future<void> googleSignIn() async {
    try {
      await authController.signInWithGoogle().then((value) async {
        String userId = "";

        userId = value.user!.uid;
        var userEmail = value.user!.email;
        var userName = value.user!.displayName;

        // print(value);

        if (userId == "") {
          AlertPopup.warning(
            title: "Oops Something went wrong!",
            message: "Please try again later",
            type: 0,
          );
          return;
        }
        // check now if google sign in user is already in use or not
        final userData = await crudController.findOne(
            collection: "Users", filed: userId.toString());

        final userType = UserHandler.currentUser;

        if (userData.isEmpty) {
          final newUser = UserModel.register(
            email: userEmail.toString(),
            id: userId.toString(),
            name: userName.toString(),
            userType: userType ?? UserHandler.kUserType,
          );

          await authController
              .insertUser(collection: "Users", user: newUser)
              .whenComplete(() {
            AlertPopup.warning(
              title: "Congratulations! 🎉",
              message: "Your account has been created!",
              type: 0,
            );
          });
        }

        // print(userType);
        final authUser = [
          userId.toString(),
          userData.isNotEmpty
              ? userData[0].userType
              : userType != null
                  ? userType.toString()
                  : UserHandler.kUserType,
          userEmail.toString(),
          userName.toString(),
        ];
        SharedAuthUser.saveAuthUser(authUser);

        AlertPopup.warning(
          title: "Congratulations! 🎉",
          message: "Login Successful!",
          type: 0,
        );

        if (userData[0].userType == UserHandler.kUserType) {
          Get.offAll(
            () => const CustomNavigationBar(),
            transition: Transition.cupertino,
            duration: const Duration(milliseconds: 1000),
          );
        }
      });
    } catch (e) {}
  }

  Future<void> facebookSignIn() async {
    try {
      await authController.signInWithFacebook().then((value) async {
        String userId = "";
        userId = value.user!.uid;
        var userEmail = value.user!.email;
        var userName = value.user!.displayName;

        if (userId == "") {
          AlertPopup.warning(
            title: "Oops Something went wrong!",
            message: "Please try again later",
            type: 0,
          );
          return;
        }
        // check now if facebook sign in user is already in use or not
        final userData =
            await crudController.findOne(collection: "Users", filed: userId);

        final userType = UserHandler.currentUser;

        if (userData.isEmpty) {
          final newUser = UserModel.register(
            email: userEmail.toString(),
            id: userId.toString(),
            name: userName.toString(),
            userType: userType ?? UserHandler.kUserType,
          );

          await authController
              .insertUser(collection: "Users", user: newUser)
              .whenComplete(() {
            AlertPopup.warning(
              title: "Congratulations! 🎉",
              message: "Your account has been created!",
              type: 0,
            );
          });
        }

        print(userType);
        final authUser = [
          userId.toString(),
          userData.isNotEmpty
              ? userData[0].userType
              : userType != null
                  ? userType.toString()
                  : UserHandler.kUserType,
          userEmail.toString(),
          userName.toString(),
        ];
        SharedAuthUser.saveAuthUser(authUser);

        AlertPopup.warning(
          title: "Congratulations! 🎉",
          message: "Login Successful!",
          type: 0,
        );

        if (userData[0].userType == UserHandler.kUserType) {
          Get.offAll(
            () => const CustomNavigationBar(),
            transition: Transition.cupertino,
            duration: const Duration(milliseconds: 1000),
          );
        }
      });
    } catch (e) {}
  }

  void logoutUser() {
    AuthenticationService.instance.logoutUser();
  }
}
