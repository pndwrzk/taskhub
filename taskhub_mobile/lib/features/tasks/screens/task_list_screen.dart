import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:taskhub_mobile/data/services/storage_service.dart';
import 'package:taskhub_mobile/data/models/task_model.dart';
import '../widgets/task_form_dialog.dart';
import '../providers/task_provider.dart';

import '../widgets/task_item_card.dart';
import '../widgets/task_empty_state.dart';
import '../widgets/task_delete_dialog.dart';

class TaskListScreen extends ConsumerWidget {
  const TaskListScreen({super.key});

  void _showTaskForm(
    BuildContext context,
    WidgetRef ref, {
    TaskResponse? task,
  }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => TaskFormDialog(
        task: task,
        onSubmit: (title, desc, status) async {
          if (task == null) {
            await ref.read(taskProvider.notifier).createTask(title, desc);
          } else {
            await ref
                .read(taskProvider.notifier)
                .updateTask(task, title, desc, status);
          }
        },
      ),
    );
  }

  void _showDeleteDialog(BuildContext context, WidgetRef ref, String id) {
    showDialog(
      context: context,
      builder: (_) => TaskDeleteDialog(
        onDelete: () async =>
            await ref.read(taskProvider.notifier).deleteTask(id),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasksAsync = ref.watch(taskProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Tasks',
          style: TextStyle(
            color: Colors.black,
            fontSize: 28,
            fontWeight: FontWeight.w900,
            letterSpacing: -0.5,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.black, size: 26),
            onPressed: () async {
              await StorageService.logout();
              if (context.mounted)
                Navigator.pushReplacementNamed(context, '/login');
            },
          ),
        ],
      ),
      body: tasksAsync.when(
        loading: () => const Center(
          child: CircularProgressIndicator(
            color: Colors.black,
            strokeWidth: 2.5,
          ),
        ),
        error: (_, __) => const Center(child: Text('Failed to load tasks')),
        data: (tasks) {
          if (tasks.isEmpty) return const TaskEmptyState();
          return RefreshIndicator(
            onRefresh: () => ref.read(taskProvider.notifier).loadTasks(),
            color: Colors.black,
            backgroundColor: Colors.white,
            child: ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 140),
              itemCount: tasks.length,
              itemBuilder: (context, i) {
                final task = tasks[i];
                return TaskCard(
                  task: task,
                  onEdit: () => _showTaskForm(context, ref, task: task),
                  onDelete: () => _showDeleteDialog(context, ref, task.id),
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: Container(
        height: 68,
        width: 68,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.black,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: IconButton(
          icon: const Icon(Icons.add, color: Colors.white, size: 32),
          onPressed: () => _showTaskForm(context, ref),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
