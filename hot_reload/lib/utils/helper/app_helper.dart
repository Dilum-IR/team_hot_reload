import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AppHelper extends GetxController {
  String get getGreeting => _getGreeting();

  String _getGreeting() {
    var now = DateTime.now();
    var formatter = DateFormat.H().format(now);
    int hour = int.parse(formatter);
    String greeting;
    if (hour >= 6 && hour < 12) {
      greeting = 'Good Morning !';
    } else if (hour >= 12 && hour < 17) {
      greeting = 'Good Afternoon !';
    } else if (hour >= 17 && hour < 20) {
      greeting = 'Good Evening !';
    } else {
      greeting = 'Good Night !';
    }
    return greeting;
  }

  static String getDaySuffix(int day) {
    if (day >= 11 && day <= 13) {
      return 'th';
    }
    switch (day % 10) {
      case 1:
        return 'st';
      case 2:
        return 'nd';
      case 3:
        return 'rd';
      default:
        return 'th';
    }
  }
}
