import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskhub_mobile/data/models/task_model.dart';
import 'package:taskhub_mobile/data/services/task_service.dart';

final taskProvider =
    StateNotifierProvider<TaskNotifier, AsyncValue<List<TaskResponse>>>(
      (ref) => TaskNotifier(),
    );

class TaskNotifier extends StateNotifier<AsyncValue<List<TaskResponse>>> {
  TaskNotifier() : super(const AsyncLoading()) {
    loadTasks();
  }

  Future<void> loadTasks() async {
    state = const AsyncLoading();
    try {
      final data = await TaskService.getTasks();
      state = AsyncData(data);
    } catch (e) {
      state = AsyncError(e, StackTrace.current);
    }
  }

  Future<void> createTask(String title, String? desc) async {
    await TaskService.createTask(
      CreateTaskRequest(title: title, description: desc),
    );
    await loadTasks();
  }

  Future<void> updateTask(
    TaskResponse task,
    String title,
    String? desc,
    int status,
  ) async {
    await TaskService.updateTask(
      task.id,
      UpdateTaskRequest(title: title, description: desc, status: status),
    );
    await loadTasks();
  }

  Future<void> deleteTask(String id) async {
    await TaskService.deleteTask(id);
    await loadTasks();
  }
}
