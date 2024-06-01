import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

import '../../../components/widget/comman_widget/no_connection.dart';
import '../../../utils/helper/user_handler.dart';
import '../../controllers/user/shared_auth_user.dart';
import '../on_boarding/on_boarding_screen.dart';
import '../user/navigation_bar.dart';
import '../user/qr_scan_generator.dart';

class CheckNetwork extends StatefulWidget {
  const CheckNetwork({Key? key}) : super(key: key);

  @override
  State<CheckNetwork> createState() => _CheckNetworkState();
}

class _CheckNetworkState extends State<CheckNetwork> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      // backgroundColor: Colors.white,
      body: SizedBox(
        width: size.width,
        height: size.height,
        // check the network connection for app
        child: StreamBuilder(
          stream: Connectivity().onConnectivityChanged,
          builder: (context, AsyncSnapshot<ConnectivityResult> snapshot) {
            // print(snapshot.toString());
            if (snapshot.hasData) {
              ConnectivityResult? result = snapshot.data;
              if (result != ConnectivityResult.none) {
                if (SharedAuthUser.getAuthUser() != null) {
                  // Todo : sign in two method redirection
                  if (SharedAuthUser.getAuthUser()[1] ==
                      UserHandler.kUserType) {
                    return const CustomNavigationBar();
                  } else {
                    return const OnBoardingScreen();
                  }
                } else {
                  return const OnBoardingScreen();
                  // return const QRScannerAndGenerator();
                }
                // connected to mobile
              } else {
                return const NoConnection();
                // no internet
              }
            } else {
              return const NoConnection();
              // show loading msg
            }
          },
        ),
      ),
    );
  }
}
