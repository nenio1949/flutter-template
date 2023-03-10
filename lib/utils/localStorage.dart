import 'package:shared_preferences/shared_preferences.dart';

/// 本地缓存
class LocalStorage {
  static SharedPreferences? prefs;

  /// 初始化
  static initSP() async {
    prefs = await SharedPreferences.getInstance();
  }

  /// 保存
  static save(String key, String value) {
    prefs?.setString(key, value);
  }

  /// 获取
  static get(String key) {
    return prefs?.get(key);
  }

  /// 移除
  static remove(String key) {
    prefs?.remove(key);
  }

  /// 清除
  static clear() {
    prefs?.clear();
  }
}
