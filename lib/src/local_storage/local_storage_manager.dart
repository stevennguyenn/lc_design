import 'hive_adapter.dart';
import 'secure_storage.dart';

class LocalStorageManager {
  static final LocalStorageManager instance = LocalStorageManager._();

  LocalStorageManager._();

  final HiveAdapter _hive = HiveAdapter.instance;
  final SecureStorageAdapter _secureStorage = SecureStorageAdapter.instance;

  Future<void> init() async {
    await _hive.init();
    await _secureStorage.init();
    await _hive.openBox();
  }

  Future<void> saveData<T>(
    T data, {
    required String key,
    bool isSecretData = false,
  }) async {
    await _hive.saveData(
      data,
      key: key,
      isSecretData: isSecretData,
    );
  }

  Future<void> saveDataAsList<T>(
      T data, {
        required String key,
        bool isSecretData = false,
      }) async {
    await _hive.saveDataAsList(
      data,
      key: key,
      isSecretData: isSecretData,
    );
  }

  Future<dynamic> getData(String key) async {
    return await _hive.getData(key);
  }

  Future<void> removeData() async {
    await _hive.removeDataBox();
  }
}
