import 'package:shared_preferences/shared_preferences.dart';

class UserSimplePreferences {
  static const _keyUserName = 'username';
  static SharedPreferences _preferences;
  static Future setUsername(String username) async =>
      await _preferences.setString(_keyUserName, username);
  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();
  static String getUsername() => _preferences.getString(_keyUserName);
}
