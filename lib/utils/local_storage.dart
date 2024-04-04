import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  final SharedPreferences sharedPreferences;

  LocalStorage({required this.sharedPreferences});

  Future storeToken(String token) =>
      sharedPreferences.setString(_StorageKey.token, token);

  Future storeId(int id) => sharedPreferences.setInt(_StorageKey.id, id);

  void clearAll() {
    sharedPreferences.clear();
  }

  String get token => sharedPreferences.getString(_StorageKey.token) ?? '';

  int get id => sharedPreferences.getInt(_StorageKey.id) ?? -1;
}

abstract class _StorageKey {
  static String token = 'token';
  static String id = 'id';
}
