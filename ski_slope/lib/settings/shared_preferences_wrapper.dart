import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesWrapper {
  final SharedPreferences _instance;

  SharedPreferencesWrapper(this._instance);

  bool? getBool(String key) => _instance.getBool(key);

  int? getInt(String key) => _instance.getInt(key);

  double? getDouble(String key) => _instance.getDouble(key);

  String? getString(String key) => _instance.getString(key);

  Future<bool> setBool(String key, bool? value) =>
      value == null ? _instance.remove(key) : _instance.setBool(key, value);

  Future<bool> setInt(String key, int? value) => value == null ? _instance.remove(key) : _instance.setInt(key, value);

  Future<bool> setDouble(String key, double? value) =>
      value == null ? _instance.remove(key) : _instance.setDouble(key, value);

  Future<bool> setString(String key, String? value) =>
      value == null ? _instance.remove(key) : _instance.setString(key, value);
}
