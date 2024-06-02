import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../../services/crud_services.dart';
import '../../../components/widget/comman_widget/alert_popup.dart';
import '../../model/employee_job_post.dart';
import '../user/shared_auth_user.dart';

class EmployeeFeatureController extends GetxController {
  final crudController = Get.put(CrudServices());

  void saveJob(EmployeeJobPost jobPost) async {
    try {
      await crudController.jobInsert(
          collection: "Jobs", data: jobPost.toJson());

      AlertPopup.warning(
        title: "Job add Successful 🎉",
        message: "Your job is now posted.",
      );

      // Get.to(
      //   () => EmpHomeScreen(),
      //   transition: Transition.cupertino,
      //   duration: Duration(
      //     milliseconds: 1000,
      //   ),
      // );
    } catch (e) {}
  }

  Future<List<EmployeeJobPost>> getJob() async {
    try {
      String uid = SharedAuthUser.getAuthUser()[0];
      List<EmployeeJobPost> data = await crudController.jobFindOneId(
          collection: "Jobs", key: "id", filed: uid);
      return data;
    } catch (e) {
      return [];
    }
  }

  Future<List<EmployeeJobPost>> getAllJob() async {
    try {
      List<EmployeeJobPost> data =
          await crudController.jobFindAll(collection: "Jobs");
      return data;
    } catch (e) {
      return [];
    }
  }
}
