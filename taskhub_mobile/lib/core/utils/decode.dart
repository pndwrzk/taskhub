import 'dart:convert';
import 'package:http/http.dart' as http;

Map<String, dynamic> decodeResponse(http.Response response) {
  try {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      final decoded = jsonDecode(response.body);
      if (decoded is Map<String, dynamic>) return decoded;
      return {};
    } else {
      return {};
    }
  } catch (_) {
    return {};
  }
}
