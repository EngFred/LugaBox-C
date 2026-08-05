import 'package:shared_preferences/shared_preferences.dart';

class SessionStore {
  const SessionStore._();

  static const _isLoggedInKey = 'is_logged_in';

  static Future<bool> isLoggedIn() async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.getBool(_isLoggedInKey) ?? false;
  }

  static Future<void> markLoggedIn() async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setBool(_isLoggedInKey, true);
  }

  static Future<void> logout() async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setBool(_isLoggedInKey, false);
  }
}
