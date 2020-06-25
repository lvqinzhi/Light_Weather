import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

class shared_preferences_utility {
  static shared_preferences_utility _instance;

  static Future<shared_preferences_utility> get instance async {
    return await getInstance();
  }

  static SharedPreferences _spf;

  shared_preferences_utility._();

  Future _init() async {
    _spf = await SharedPreferences.getInstance();
  }

  static Future<shared_preferences_utility> getInstance() async {
    if (_instance == null) {
      _instance = new shared_preferences_utility._();
      await _instance._init();
    }
    return _instance;
  }

  static bool _beforecheck() {
    if (_spf == null) {
      return true;
    }
    return false;
  }

  bool hasKey(String key) {
    Set keys = getKeys(key);
    return keys.contains(keys);
  }

  Set<String> getKeys(String key) {
    if (_beforecheck()) return null;
    return _spf.getKeys();
  }

  get(String key) {
    if (_beforecheck()) return null;
    return _spf.get(key);
  }

  getString(String key) {
    if (_beforecheck()) return null;
    return _spf.getString(key);
  }

  Future<bool> putString(String key, String value) {
    if (_beforecheck()) return null;
    return _spf.setString(key, value);
  }

  bool getBool(String key) {
    if (_beforecheck()) return null;
    return _spf.getBool(key);
  }

  Future<bool> putBool(String key, bool value) {
    if (_beforecheck()) return null;
    return _spf.setBool(key, value);
  }

  int getInt(String key) {
    if (_beforecheck()) return null;
    return _spf.getInt(key);
  }

  Future<bool> putInt(String key, int value) {
    if (_beforecheck()) return null;
    return _spf.setInt(key, value);
  }

  double getDouble(String key) {
    if (_beforecheck()) return null;
    return _spf.getDouble(key);
  }

  Future<bool> putDouble(String key, double value) {
    if (_beforecheck()) return null;
    return _spf.setDouble(key, value);
  }

  List<String> getStringList(String key) {
    if (_beforecheck()) return null;
    return _spf.getStringList(key);
  }

  Future<bool> putStringLisg(String key, List<String> value) {
    if (_beforecheck()) return null;
    return _spf.setStringList(key, value);
  }

  dynamic getDynamic(String key) {
    if (_beforecheck()) return null;
    return _spf.get(key);
  }

  Future<bool> remove(String key) {
    if (_beforecheck()) return null;
    return _spf.remove(key);
  }

  Future<bool> clear() {
    if (_beforecheck()) return null;
    return _spf.clear();
  }
}
