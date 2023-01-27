import 'dart:convert';
import 'package:hive_flutter/adapters.dart';

import 'secure_storage.dart';

class HiveBoxKey {
  HiveBoxKey._();

  static final instance = HiveBoxKey._();
  final userBox = "user_box";
  final dataBox = "data_box";
}

class HiveAdapter {
  static final instance = HiveAdapter._();

  HiveAdapter._();

  ///save secure data (token, user information,....)
  late LazyBox secretBox;

  ///save normal data
  late LazyBox dataBox;

  Future<void> init() async {
    await Hive.initFlutter();
  }

  Future<void> openBox() async {
    final key = await SecureStorageAdapter.instance.getKey();
    final encryptionKey = base64Url.decode(key);
    // debugPrint('Encryption key: $encryptionKey');
    secretBox = await Hive.openLazyBox(
      HiveBoxKey.instance.userBox,
      encryptionCipher: HiveAesCipher(encryptionKey),
    );
    dataBox = await Hive.openLazyBox(HiveBoxKey.instance.dataBox);
  }

  Future<void> saveData<T>(
    T data, {
    required String key,
    bool isSecretData = false,
  }) async {
    if (isSecretData) {
      await secretBox.put(key, data);
      return;
    }
    await dataBox.put(key, data);
  }

  Future<dynamic> getData(
    String key, {
    bool isSecretData = false,
  }) async {
    if (isSecretData) {
      return await secretBox.get(key);
    }
    return await dataBox.get(key);
  }

  Future<void> removeAllData() async {
    await removeDataBox();
    await removeSecretBox();
  }

  Future<void> removeDataBox() async {
    await dataBox.clear();
  }

  Future<void> removeSecretBox() async {
    await secretBox.clear();
  }
}
