import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  late final SharedPreferences _prefs;

  Future<void> initialize() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<bool> setString(String key, String value) async =>
      _prefs.setString(key, value);

  String? getString(String key) => _prefs.getString(key);

  Future<bool> setInt(String key, int value) async => _prefs.setInt(key, value);

  int getInt(String key, {int defaultValue = 0}) =>
      _prefs.getInt(key) ?? defaultValue;

  // Future<bool> setBool(String key, {required bool value}) async =>
  //     _prefs.setBool(key, value);

  // bool getBool(String key, {bool defaultValue = false}) =>
  //     _prefs.getBool(key) ?? defaultValue;
}

/*

  // Bool değerler
  Future<bool> setBool(String key, {required bool value}) async {
    return _prefs.setBool(key, value);
  }

  bool? getBool(String key) {
    return _prefs.getBool(key);
  }

  // Double değerler
  Future<bool> setDouble(String key, double value) async {
    return _prefs.setDouble(key, value);
  }

  double? getDouble(String key) {
    return _prefs.getDouble(key);
  }

  // String listeler
  Future<bool> setStringList(String key, List<String> value) async {
    return _prefs.setStringList(key, value);
  }

  List<String>? getStringList(String key) {
    return _prefs.getStringList(key);
  }

  // Belirli bir key'i silme
  Future<bool> remove(String key) async {
    return _prefs.remove(key);
  }

  // Tüm verileri silme
  Future<bool> clear() async {
    return _prefs.clear();
  }

  // Key'in var olup olmadığını kontrol etme
  bool containsKey(String key) {
    return _prefs.containsKey(key);
  }

  // Tüm key'leri getirme
  Set<String> getKeys() {
    return _prefs.getKeys();
  }
*/
