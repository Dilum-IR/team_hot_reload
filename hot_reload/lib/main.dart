import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:hot_reload/services/api/firebase_api.dart';
import 'package:hot_reload/utils/constraints/colors.dart';

import 'app/controllers/user/shared_auth_user.dart';
import 'app/screens/check_connection/check_network.dart';
import 'firebase_options.dart';
import 'utils/helper/dependency_injection.dart';

// https://firebase.google.com/docs/auth/flutter/federated-auth

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedAuthUser.init();

  await FlutterConfig.loadEnvVariables();
  // await FirebaseApi().initNotifications();

  await dotenv.load(fileName: ".env").whenComplete(() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  });

  String? apiKey = dotenv.env['GOOGLE_MAPS_API_KEY'];

  // print('apiKey: $apiKey');

  runApp(const MyApp());

  // check connections
  DependencyInjection.init();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Developed by Team Hot Reload',
      theme: ThemeData(
        primarySwatch: KColors.app_primary,
      ),
      home: const CheckNetwork(),
    );
  }
}
