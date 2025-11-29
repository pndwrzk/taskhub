import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:taskhub_mobile/data/models/base_response_model.dart';
import 'package:taskhub_mobile/data/models/auth_model.dart';

class AuthService {
  static final String? _baseUrl = dotenv.env['API_URL'];
  static final _client = http.Client();

  static Future<BaseResponse<LoginData>> login(LoginPayload payload) async {
    final url = Uri.parse('$_baseUrl/auth/login');

    final response = await _client.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(payload.toJson()),
    );

    final json = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return BaseResponse.fromJson(json, (data) => LoginData.fromJson(data));
    } else {
      throw Exception(json['message'] ?? 'Login failed');
    }
  }

  static Future<BaseResponse<RegisterData>> register(
    RegisterPayload payload,
  ) async {
    final url = Uri.parse('$_baseUrl/auth/register');

    final response = await _client.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(payload.toJson()),
    );

    final json = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return BaseResponse.fromJson(json, (data) => RegisterData.fromJson(data));
    } else {
      throw Exception(json['message'] ?? 'Register failed');
    }
  }
}
