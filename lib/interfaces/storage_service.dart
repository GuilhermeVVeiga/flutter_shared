/// Interface para armazenamento local de dados chave-valor.
abstract interface class StorageService {
  Future<void> saveString(String key, String value);
  Future<String?> readString(String key);

  Future<void> saveBool(String key, bool value);
  Future<bool?> readBool(String key);

  Future<void> saveInt(String key, int value);
  Future<int?> readInt(String key);

  Future<void> remove(String key);
  Future<void> clear();
}
