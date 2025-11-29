import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:taskhub_mobile/data/models/auth_model.dart';
import 'package:taskhub_mobile/data/services/storage_service.dart';

class AuthHttpClient extends http.BaseClient {
  final _inner = http.Client();

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    await _attachToken(request);

    var response = await _inner.send(request);

    if (response.statusCode == 401) {
      final refreshed = await _refreshToken();
      if (refreshed) {
        await _attachToken(request, force: true);
        response = await _inner.send(request);
      } else {
        await StorageService.logout();
        throw Exception('Session expired. Please login again.');
      }
    }

    return response;
  }

  Future<void> _attachToken(
    http.BaseRequest request, {
    bool force = false,
  }) async {
    final token = await StorageService.getAccessToken();
    if (token != null &&
        (force || !request.headers.containsKey('Authorization'))) {
      request.headers['Authorization'] = 'Bearer $token';
    }
  }

  static Future<bool> _refreshToken() async {
    final baseUrl = dotenv.env['API_URL'];
    final refreshToken = await StorageService.getRefreshToken();
    if (refreshToken == null) return false;

    try {
      final response = await http.post(
        Uri.parse('$baseUrl/auth/refresh'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'refresh_token': refreshToken}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body)['data'];

        await StorageService.saveLoginData(
          LoginData(
            accessToken: data['access_token'],
            accessTokenExpiresAt: data['access_token_expires_at'],
            refreshToken: data['refresh_token'],
            refreshTokenExpiresAt: data['refresh_token_expires_at'],
            tokenType: data['token_type'],
            user: UserData(
              id: data['user']['id'],
              email: data['user']['email'],
            ),
          ),
        );

        return true;
      }
    } catch (e) {
      print('Refresh failed: $e');
    }

    return false;
  }

  @override
  void close() => _inner.close();
}
