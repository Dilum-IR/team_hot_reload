import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ShowConfirm {
  static void dialog(BuildContext context, String desc, Function onConfirm) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "Confirmation",
            style: GoogleFonts.lato(color: Colors.black),
          ),
          content: Text(desc),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("No", style: GoogleFonts.lato()),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog

                onConfirm(); // Call the callback function to handle dismissal
              },
              style: TextButton.styleFrom(foregroundColor: Colors.black45),
              child: Text(
                "Yes",
                style: GoogleFonts.lato(color: Colors.black87),
              ),
            ),
          ],
        );
      },
    );
  }
}
