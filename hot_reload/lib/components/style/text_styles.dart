import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/constraints/colors.dart';

class KTextStyles {
  KTextStyles._();

  static TextStyle appName = GoogleFonts.stardosStencil(
    fontSize: 45,
    fontWeight: FontWeight.w500,
    color: KColors.white,
  );

  //  -------------------------------------------- thin text  --------------------------------------------
  static TextStyle thinBText = GoogleFonts.lato(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: KColors.black,
  );

  static TextStyle thinGText = GoogleFonts.lato(
    fontSize: 12,
    color: KColors.black.withOpacity(0.5),
    fontWeight: FontWeight.w400,
  );

  // --------------------------------------------  smaller text --------------------------------------------
  static TextStyle smallerBText = GoogleFonts.lato(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: KColors.black,
  );

  static TextStyle smallerBBText = GoogleFonts.lato(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: KColors.black,
  );

  static TextStyle smallerWText = GoogleFonts.lato(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: KColors.white,
  );

  static TextStyle smallerWBText = GoogleFonts.lato(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: KColors.white,
  );

  static TextStyle smallerGText = GoogleFonts.lato(
    fontSize: 14,
    color: KColors.black.withOpacity(0.5),
  );

  // -------------------------------------------- medium text --------------------------------------------
  static TextStyle mediumBText = GoogleFonts.lato(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: KColors.black,
  );

  static TextStyle mediumBBText = GoogleFonts.lato(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: KColors.black,
  );

  static TextStyle mediumWText = GoogleFonts.lato(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: KColors.white,
  );

  static TextStyle mediumWBText = GoogleFonts.lato(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: KColors.white,
  );

  static TextStyle mediumGText = GoogleFonts.lato(
    fontSize: 16,
    color: KColors.black.withOpacity(0.5),
  );

  static TextStyle mediumPBText = GoogleFonts.lato(
    fontSize: 16,
    color: KColors.primary,
    fontWeight: FontWeight.w600,
  );

  //  -------------------------------------------- large text   --------------------------------------------
  static TextStyle largeBText = GoogleFonts.lato(
    fontSize: 20,
    color: KColors.black,
  );

  static TextStyle largeWBText = GoogleFonts.lato(
    fontSize: 20,
    color: KColors.white,
    fontWeight: FontWeight.w600,
  );

  // -------------------------------------------- Extra text --------------------------------------------
  static TextStyle whiteXMText = GoogleFonts.lato(
    fontSize: 15,
    color: KColors.grey.withOpacity(0.7),
  );

  static TextStyle grayXLText = GoogleFonts.lato(
    fontSize: 18,
    color: KColors.black.withOpacity(0.5),
  );

  static TextStyle grayXlBText = GoogleFonts.lato(
    fontSize: 18,
    color: KColors.black.withOpacity(0.5),
    fontWeight: FontWeight.w600,
  );
  static TextStyle blackXlText = GoogleFonts.lato(
    fontSize: 18,
    color: KColors.black.withOpacity(0.5),
    fontWeight: FontWeight.w400,
  );

  static TextStyle blackXLBText = GoogleFonts.lato(
    fontSize: 29,
    fontWeight: FontWeight.w500,
    color: KColors.black,
  );
  static TextStyle blackXXLBText = GoogleFonts.lato(
    fontSize: 37,
    fontWeight: FontWeight.w500,
    color: KColors.black,
  );

// -------------------------------------------- Error text --------------------------------------------
  static TextStyle errorTextStyle = GoogleFonts.lato(
    color: Colors.red,
    fontSize: 14.0,
    fontWeight: FontWeight.bold,
  );
}
