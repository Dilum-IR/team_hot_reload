import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../utils/constraints/colors.dart';

class AppInputStyle {
  //obscure character
  static String obscuringCharacter = '●';
  static String hintObsureCharacter = '●●●●●●●●●';

  // registration for use RegEx
  final passwordContain =
      RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
  final phnNumContain = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  final usernameContain = RegExp(r"^[\s a-z A-Z]+");
  final emailContain =
      RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');

  // user input success with field filled color
  static Color validFillColor = Colors.orangeAccent.withOpacity(0.1);

  // ----------------------------------- input field border -----------------------------------
  static OutlineInputBorder outlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: const BorderSide(color: KColors.black),
  );

  static OutlineInputBorder outlineDropDownInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: const BorderSide(color: Colors.black12),
  );

  static OutlineInputBorder InputErrorBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: const BorderSide(color: Colors.red),
  );

  // ----------------------------------- Icons -----------------------------------
  static Icon profileIcon = const Icon(
    Iconsax.user,
    color: KColors.black,
    size: 18,
  );

  static Icon emailIcon = const Icon(
    Icons.email_outlined,
    color: KColors.black,
    size: 18,
  );
  static Icon passwordIcon = const Icon(
    Iconsax.key,
    color: KColors.black,
    size: 18,
  );
  static Icon visibleIcon = const Icon(
    Icons.visibility,
    color: KColors.black,
  );
  static Icon visibilityOffIcon = const Icon(
    Icons.visibility_off,
    color: Colors.grey,
  );
  static Icon dropDownIcon = const Icon(
    Icons.keyboard_arrow_down_rounded,
    size: 30,
    color: KColors.secondary,
  );
  static Icon searchIcon = const Icon(
    Icons.search_rounded,
    size: 30,
    color: KColors.app_primary,
  );

  // ----------------------------------- padding -----------------------------------
  static EdgeInsets contentPadding =
      const EdgeInsets.symmetric(horizontal: 20, vertical: 15);
}
