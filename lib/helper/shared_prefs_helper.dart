import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsHelper {
  static SharedPreferences? _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static SharedPreferences get prefs {
    if (_prefs == null) {
      throw Exception(
          "SharedPrefsHelper not initialized. Call SharedPrefsHelper.init() in main()");
    }
    return _prefs!;
  }

  /// Set String
  static Future<bool> setString(String key, String value) async {
    return await prefs.setString(key, value);
  }

  /// Get String
  static String? getString(String key) {
    return prefs.getString(key);
  }

  /// Set Int
  static Future<bool> setInt(String key, int value) async {
    return await prefs.setInt(key, value);
  }

  /// Get Int
  static int? getInt(String key) {
    return prefs.getInt(key);
  }

  /// Set  Double
  static Future<bool> setDouble(String key, double value) async {
    return await prefs.setDouble(key, value);
  }

  /// Get Double
  static double? getDouble(String key) {
    return prefs.getDouble(key);
  }

  /// Set Bool
  static Future<bool> setBool(String key, bool value) async {
    return await prefs.setBool(key, value);
  }

  /// Get Bool
  static bool? getBool(String key) {
    return prefs.getBool(key);
  }

  /// Remove Key
  static Future<bool> remove(String key) async {
    return await prefs.remove(key);
  }

  /// Clear All
  static Future<bool> clear() async {
    return await prefs.clear();
  }
}
