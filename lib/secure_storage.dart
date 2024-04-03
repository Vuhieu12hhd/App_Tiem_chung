import 'package:hive/hive.dart';

class SercureStorageApp {
  SercureStorageApp._privateConstructor();

  static final SercureStorageApp _secureStorageApp = SercureStorageApp
      ._privateConstructor();

  factory SercureStorageApp(){
    return _secureStorageApp;
  }

  SaveValue(String key, String? value) async {
    final hiveStorage = Hive.box('injection');
    await hiveStorage.put(key, value);
  }

  String GetValueData(String key) {
    final hiveStorage = Hive.box('injection');
    return hiveStorage.get(key) ?? '';
  }

  ClearCacheApp() async {
    final hiveStorage = Hive.box('injection');
    await hiveStorage.clear();
  }

  Delete(String key) async {
    final hiveStorage = Hive.box('injection');
    await hiveStorage.delete(key);
  }
}
