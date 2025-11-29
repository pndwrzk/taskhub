import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:taskhub_mobile/core/utils/decode.dart';
import 'package:taskhub_mobile/data/models/task_model.dart';
import '../../core/utils/auth_http_client.dart';

class TaskService {
  static final String? _baseUrl = dotenv.env['API_URL'];
  static final _client = AuthHttpClient();

  static Uri _uri(String path) => Uri.parse('$_baseUrl$path');

  static Future<List<TaskResponse>> getTasks() async {
    final response = await _client.get(_uri('/tasks'));
    final body = decodeResponse(response);

    if (response.statusCode == 200) {
      final list = body['data'] as List;
      return list.map((e) => TaskResponse.fromJson(e)).toList();
    }

    throw Exception(body['message'] ?? 'Failed to fetch tasks');
  }

  static Future<TaskResponse> createTask(CreateTaskRequest payload) async {
    final response = await _client.post(
      _uri('/tasks'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(payload.toJson()),
    );

    final body = decodeResponse(response);

    if (response.statusCode == 201) {
      return TaskResponse.fromJson(body['data']);
    }

    throw Exception(body['message'] ?? 'Failed to create task');
  }

  static Future<TaskResponse> updateTask(
    String id,
    UpdateTaskRequest payload,
  ) async {
    final response = await _client.put(
      _uri('/tasks/$id'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(payload.toJson()),
    );

    final body = decodeResponse(response);

    if (response.statusCode == 200) {
      return TaskResponse.fromJson(body['data']);
    }

    throw Exception(body['message'] ?? 'Failed to update task');
  }

  static Future<void> deleteTask(String id) async {
    final response = await _client.delete(_uri('/tasks/$id'));

    if (response.statusCode != 200 && response.statusCode != 204) {
      final body = decodeResponse(response);
      throw Exception(body['message'] ?? 'Failed to delete task');
    }
  }
}
