import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../models/auth_model.dart';

class StorageService {
  static const _storage = FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
    iOptions: IOSOptions(accessibility: KeychainAccessibility.first_unlock),
  );

  static Future<void> saveLoginData(LoginData loginData) async {
    await Future.wait([
      _storage.write(key: 'access_token', value: loginData.accessToken),
      _storage.write(
        key: 'access_token_expires_at',
        value: loginData.accessTokenExpiresAt.toString(),
      ),
      _storage.write(key: 'refresh_token', value: loginData.refreshToken),
      _storage.write(
        key: 'refresh_token_expires_at',
        value: loginData.refreshTokenExpiresAt.toString(),
      ),
      _storage.write(key: 'token_type', value: loginData.tokenType),
      _storage.write(key: 'user_id', value: loginData.user.id),
      _storage.write(key: 'user_email', value: loginData.user.email),
    ]);
  }

  static Future<String?> getAccessToken() async =>
      await _storage.read(key: 'access_token');

  static Future<String?> getRefreshToken() async =>
      await _storage.read(key: 'refresh_token');

  static Future<String?> getUserId() async =>
      await _storage.read(key: 'user_id');

  static Future<String?> getUserEmail() async =>
      await _storage.read(key: 'user_email');

  static Future<bool> isLoggedIn() async {
    final token = await getAccessToken();
    return token != null;
  }

  static Future<void> logout() async {
    await _storage.deleteAll();
  }
}
