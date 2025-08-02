import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static late SharedPreferences _prefs;

  static void init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static Future<bool?> getBool(String key) async {
    return _prefs.getBool(key);
  }

  static Future<String?> getString(String key) async {
    return _prefs.getString(key);
  }

  static Future<bool> setBool(String key, bool value) async {
    return _prefs.setBool(key, value);
  }

  static Future<bool> setString(String key, String value) async {
    return _prefs.setString(key, value);
  }
}
