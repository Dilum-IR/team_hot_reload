import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../utils/constraints/colors.dart';

class KTextTitle extends StatelessWidget {
  const KTextTitle({super.key, required this.text});

  final String text;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.lato(
        fontSize: 18,
        color: KColors.black,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}

class KTextLabel extends StatelessWidget {
  const KTextLabel({super.key, required this.text});

  final String text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 9.0),
      child: Text(
        text,
        style: GoogleFonts.lato(
          fontSize: 18,
          color: KColors.black,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
