import 'package:shared_preferences/shared_preferences.dart';

import 'key_value_storage_service.dart';

class KeyValueStorageServiceImpl extends KeyValueStorageService {
  static late KeyValueStorageServiceImpl _instance;
  late SharedPreferences _prefs;

  KeyValueStorageServiceImpl._();

  static KeyValueStorageServiceImpl get instance {
    _instance = KeyValueStorageServiceImpl._();
    return _instance;
  }

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static Future<SharedPreferences> _getPrefs() async {
    return await SharedPreferences.getInstance();
  }

  @override
  Future<T?> getValue<T>(String key) async {
    await init();

    switch (T) {
      case const (int):
        return _prefs.getInt(key) as T?;
      case const (String):
        return _prefs.getString(key) as T?;
      case const (bool):
        return _prefs.getBool(key) as T;
      default:
        throw UnimplementedError(
          'Get not implemented for type ${T.runtimeType}',
        );
    }
  }

  @override
  Future<bool> removeKey(String key) async {
    final prefs = await _getPrefs();
    return await prefs.remove(key);
  }

  @override
  Future<void> setKeyValue<T>(String key, T value) async {
    await init();
    switch (T) {
      case const (int):
        _prefs.setInt(key, value as int);
        break;
      case const (String):
        _prefs.setString(key, value as String);
        break;
      case const (bool):
        _prefs.setBool(key, value as bool);
        break;
      default:
        throw UnimplementedError(
          'Set not implemented for type ${T.runtimeType}',
        );
    }
  }
}
