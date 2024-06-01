import 'package:shared_preferences/shared_preferences.dart';

class SharedAuthUser {
  static late final SharedPreferences prefs;

  static Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
  }

  static void saveAuthUser(value) {
    prefs.setStringList('user', value);
  }

  static dynamic getAuthUser() {
    return prefs.get("user");
  }

  static dynamic removeUser() {
    return prefs.remove("user");
  }

  static void saveAuthInfoUser(value) => prefs.setStringList('aboutme', value);
  static dynamic getAuthInfoUser() => prefs.get("aboutme");
  static dynamic removeInfoUser() {
    return prefs.remove("aboutme");
  }

  static void saveimageUrl(value) => prefs.setString('image', value);
  static dynamic getimageUrl() => prefs.getString("image");
  static dynamic removeimageUrl() => prefs.remove("image");
}
