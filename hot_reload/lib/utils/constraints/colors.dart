// todo: this file contains all the colors

import 'package:flutter/material.dart';

class KColors {
  KColors._();

  // primary theme data app color
  static const MaterialColor app_primary = MaterialColor(0XFF430C30, {
    50: Color(0XFF430C30),
    100: Color(0XFF430C30),
    200: Color(0XFF430C30),
    300: Color(0XFF430C30),
    400: Color(0XFF430C30),
    500: Color(0XFF430C30),
    600: Color(0XFF430C30),
    700: Color(0XFF430C30),
    800: Color(0XFF430C30),
    900: Color(0XFF430C30),
  });

  // on board colors
  static const onboardColor = Colors.white;

  static const Color background = Color.fromRGBO(232, 232, 232, 1);

  static const Color primary = Color.fromRGBO(67, 12, 48, 1);
  static const Color secondary = Color.fromRGBO(255, 97, 97, 1);

  static const Color white = Color.fromRGBO(253, 251, 246, 1);
  static const Color grey = Color.fromRGBO(232, 232, 232, 1);
  static const Color primaryShade = Color.fromRGBO(218, 202, 214, 1);

  static const Color black = Color.fromRGBO(0, 0, 0, 1);
  static const Color lightGrey = Color.fromRGBO(34, 40, 49, 1);

  // status colors
  static const Color reserved = Color.fromRGBO(255, 179, 58, 1);
  static const Color pending = Color.fromRGBO(255, 129, 190, 1);
  static const Color rejected = Color(0xFFD32F2F);
  static const Color completed = Color.fromRGBO(139, 216, 162, 1);

  static const Color rates = Color.fromRGBO(255, 179, 58, 1);
  static const Color gold = Color.fromRGBO(242, 146, 12, 1);

  // Error validation colors
  static const Color error = Color(0xCBD32F2F);
  static const Color success = Color(0xCC388E3C);
  static const Color warning = Color(0x98F57C00);
  static const Color info = Color(0xA51976D2);

  // Gradient colors
  static const Gradient linerGradient = LinearGradient(
    begin: Alignment(0.0, 0.0),
    end: Alignment(0.707, -0.707),
    colors: [],
  );
}
