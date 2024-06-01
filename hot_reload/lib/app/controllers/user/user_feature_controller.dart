import 'package:get/get.dart';
import 'package:hot_reload/app/controllers/user/shared_auth_user.dart';

import '../../../services/authentication_services.dart';
import '../../../services/crud_services.dart';
import '../../../utils/helper/user_handler.dart';
import '../../../components/widget/comman_widget/alert_popup.dart';
import '../../model/education.dart';
import '../../model/employee_job_post.dart';
import '../../model/qualification.dart';
import '../../model/user_model.dart';

class UserFeatureController extends GetxController {
  final authController = Get.put(AuthenticationService());

  final crudController = Get.put(CrudServices());

  void saveAboutMe(List data) async {
    try {
      final aboutMeData = UserModel.aboutMe(
          id: UserHandler.id,
          userType: UserHandler.userType,
          email: data[0],
          name: data[1],
          dob: data[2] ?? "",
          phone: data[3] ?? "",
          links: data[4] ?? [],
          image_url: data[5] ?? "");

      await crudController
          .update(collection: "Users", data: aboutMeData.toJsonAboutMe())
          .then((value) => Get.back(result: data[1]));

      AlertPopup.warning(
        title: "Update Successful 🎉",
        message: "Your Profile updated",
      );

      // todo: success with add to the shared preferences

      if (data[1] != null) {
        final authUser = [
          UserHandler.id.toString(),
          UserHandler.userType.toString(),
          UserHandler.email.toString(),
          data[1].toString(),
        ];
        UserHandler.name = data[1];
        SharedAuthUser.saveAuthUser(authUser);
      }

      List<String> aboutme = [];

      aboutme = [
        // dob
        data[2] ?? "",
        // phone
        data[3] ?? "",
      ];
      SharedAuthUser.saveAuthInfoUser(aboutme);
    } catch (e) {}
  }

  void saveEducation(Education data) async {
    try {
      await crudController
          .update(collection: "Users", data: data.toJson())
          .then((value) => Get.back());

      AlertPopup.warning(
        title: "Update Successful 🎉",
        message: "Your Education details updated",
      );

      // todo: success with add to the shared preferences
      List<String> aboutme = [];
    } catch (e) {}
  }

  void saveQualifi(Qualification data) async {
    try {
      await crudController
          .update(collection: "Users", data: data.toJson())
          .then((value) {
        Get.back();
      });

      AlertPopup.warning(
        title: "Update Successful 🎉",
        message: "Your Qualifications updated.",
      );
    } catch (e) {}
  }

  Future<Qualification> getQualifi() async {
    try {
      List data = await crudController.findOne(
          collection: "Users", filed: UserHandler.id);
      return data[4];
    } catch (e) {
      return Qualification(desc: '', date: '', qualifi: '', id: UserHandler.id);
      // throw e;
    }
  }

  void saveImageUrl(String url) {
    final saveImage = UserModel.addImage(id: UserHandler.id, image_url: url);
    crudController.update(
        collection: "Users", data: saveImage.toJsonAddImage());
  }
}
