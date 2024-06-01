import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';

import '../../../components/widget/comman_widget/no_connection.dart';
import '../../../components/widget/comman_widget/alert_popup.dart';

class NetworkController extends GetxController {
  final Connectivity _connectivity = Connectivity();
  @override
  void onInit() {
    _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    super.onInit();
  }

  void _updateConnectionStatus(ConnectivityResult connectivityResult) {
    if (connectivityResult == ConnectivityResult.none) {
      Get.to(() => const NoConnection());
      AlertPopup.warning(
          title: "Network Connection Unstable",
          message: "Please check your connection and try again.",
          type: 1);
    } else {
      // if (Get.to(() => NoConnection()) != null) {
      Future.delayed(const Duration(seconds: 1)).then((value) => Get.back());
      // }
    }
  }
}
