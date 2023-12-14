import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  Future<void> storeToken(String token) async {
    await _secureStorage.write(key: 'auth_token', value: token);
  }

  Future<String?> retrieveToken() async {
    return await _secureStorage.read(key: 'auth_token');
  }

  Future<void> updateToken(String newToken) async {
    await _secureStorage.write(key: 'auth_token', value: newToken);
  }

  Future<void> deleteToken() async {
    await _secureStorage.delete(key: 'auth_token');
  }
}
