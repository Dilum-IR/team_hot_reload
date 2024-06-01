import 'package:flutter/material.dart';

import '../style/app_input_style.dart';
import '../style/text_styles.dart';

class AddLink {
  static void dialog(BuildContext context, TextEditingController linkController,
      Function onConfirm) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            "Add Your Link",
            style: TextStyle(color: Colors.black),
          ),
          content: TextField(
            cursorColor: Colors.black,
            cursorHeight: 20,
            controller: linkController,
            // onChanged: (search) => onSearchChanged(search),
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 17,
              ),
              fillColor: Colors.white,
              filled: true,
              hintText: "https://linkdin.com/louise-128f6",
              labelText: "Your Link",
              hintStyle: KTextStyles.smallerGText,
              // labelStyle: AppInputStyle.labelTextStyle,
              // floatingLabelStyle: AppInputStyle.floatingLabelStyle,
              prefixIcon: const Icon(
                Icons.link,
                size: 25,
                color: Colors.orangeAccent,
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("No"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog

                onConfirm(); // Call the callback function to handle dismissal
              },
              style: TextButton.styleFrom(foregroundColor: Colors.black45),
              child: const Text(
                "Yes",
                style: TextStyle(color: Colors.black87),
              ),
            ),
          ],
        );
      },
    );
  }
}
