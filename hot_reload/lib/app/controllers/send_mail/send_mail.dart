import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:emailjs/emailjs.dart';

import '../../../components/widget/comman_widget/alert_popup.dart';

class SendEmail extends GetxController {
  Future<void> sendEmail({
    required String name,
    required String email,
    required String subject,
    required String message,
  }) async {
    try {
      Map<String, dynamic> templateParams = {
        'user_name': name,
        'user_email': email,
        'user_subject': subject,
        'user_message': message,
      };

      final String? serviceId = dotenv.env['EMAIL_SERVICE_ID'];
      final String? templateId = dotenv.env['EMAIL_TEMPLATE_ID'];
      final String? publicKey = dotenv.env['EMAIL_PUBLIC_KEY'];
      final String? privetKey = dotenv.env['EMAIL_PRIVATE_KEY'];

      await EmailJS.send(
        serviceId!,
        templateId!,
        templateParams,
        Options(
          publicKey: publicKey!,
          privateKey: privetKey!,
        ),
      );
      print('SUCCESS!');

      AlertPopup.warning(
        title: "Email Send Successful 🎉",
        message: "Please Check Your Email Address",
      );
    } catch (error) {
      if (error is EmailJSResponseStatus) {
        print('ERROR... ${error.status}: ${error.text}');
      }
      print(error.toString());

      AlertPopup.warning(
        title: "Oops! Email Send Failed 😔",
        message: "Please Try Again Later",
      );
    }
  }
}
