import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
class CacheHelper {
  static late SharedPreferences sharedPreferences;

  static Future<void> init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  ///save Data
  static Future<bool> saveData({
    required String key,
    required dynamic value,
  }) async {
    if (value is String) {
      return await sharedPreferences.setString(key, value);
    }

    if (value is bool) {
      return await sharedPreferences.setBool(key, value);
    }

    if (value is int) {
      return await sharedPreferences.setInt(key, value);
    }

    if (value is double) {
      return await sharedPreferences.setDouble(key, value);
    }

    return false;
  }

  ///get Data
  static dynamic getData(String key) {
    return sharedPreferences.get(key);
  }
  static bool containsKey(String key) {
    return sharedPreferences.containsKey(key);
  }

  ///remove Data
  static Future<bool> removeData(String key) async {
    return await sharedPreferences.remove(key);
  }

  ///clear
  static Future<bool> clear() async {
    return await sharedPreferences.clear();
  }

  /// Save Object
  static Future<bool> saveObject({
    required String key,
    required Map<String, dynamic> value,
  }) async {
    return await sharedPreferences.setString(
      key,
      jsonEncode(value),
    );
  }

  /// Get Object
  static Map<String, dynamic>? getObject(String key) {
    final data = sharedPreferences.getString(key);

    if (data == null) return null;

    return jsonDecode(data) as Map<String, dynamic>;
  }
}
