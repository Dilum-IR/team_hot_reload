import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../utils/constraints/colors.dart';

class AlertPopup {
  static void warning({
    required String title,
    required String message,
    int type = 0,
  }) {
    late IconData icon;
    late Color color;

    switch (type) {
      case 0:
        icon = Icons.check_circle;
        color = KColors.success;
        break;
      case 1:
        icon = Icons.error;
        color = KColors.error;
        break;
      case 2:
        icon = Icons.warning;
        color = KColors.warning;
        break;
      default:
        icon = Icons.change_circle_rounded;
        color = KColors.info;
        break;
    }
    Get.snackbar(
      title,
      titleText: Text(
        title,
        style: GoogleFonts.lato(
          fontSize: 15,
          fontWeight: FontWeight.w900,
          color: KColors.white,
        ),
      ),
      message,
      messageText: Text(
        message,
        style: GoogleFonts.lato(
          fontSize: 15,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      backgroundColor: color,
      colorText: Colors.white,
      icon: Icon(
        icon,
        color: Colors.white,
        size: 30,
        shadows: const [
          Shadow(
            color: Colors.black54,
            offset: Offset(0, 0),
            blurRadius: 50,
          ),
        ],
      ),
      margin: const EdgeInsets.only(
        top: 10,
      ),
      padding: const EdgeInsets.only(
        // right: 50,
        left: 20,
        top: 10,
        bottom: 10,
      ),
      maxWidth: 350,
      barBlur: 6,
    );
  }
}
