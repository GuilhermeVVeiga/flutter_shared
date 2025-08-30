import 'package:shared_preferences/shared_preferences.dart';
import '../interfaces/storage_service.dart';

/// Implementação de StorageService usando SharedPreferences.
class SharedPreferencesService implements StorageService {
  SharedPreferences? _prefs;

  Future<SharedPreferences> get _instance async =>
      _prefs ??= await SharedPreferences.getInstance();

  @override
  Future<void> saveString(String key, String value) async {
    final prefs = await _instance;
    await prefs.setString(key, value);
  }

  @override
  Future<String?> readString(String key) async {
    final prefs = await _instance;
    return prefs.getString(key);
  }

  @override
  Future<void> saveBool(String key, bool value) async {
    final prefs = await _instance;
    await prefs.setBool(key, value);
  }

  @override
  Future<bool?> readBool(String key) async {
    final prefs = await _instance;
    return prefs.getBool(key);
  }

  @override
  Future<void> saveInt(String key, int value) async {
    final prefs = await _instance;
    await prefs.setInt(key, value);
  }

  @override
  Future<int?> readInt(String key) async {
    final prefs = await _instance;
    return prefs.getInt(key);
  }

  @override
  Future<void> remove(String key) async {
    final prefs = await _instance;
    await prefs.remove(key);
  }

  @override
  Future<void> clear() async {
    final prefs = await _instance;
    await prefs.clear();
  }
}
