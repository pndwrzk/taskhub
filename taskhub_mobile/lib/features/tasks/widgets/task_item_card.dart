import 'package:flutter/material.dart';
import 'package:taskhub_mobile/data/models/task_model.dart';
import 'task_status_badge.dart';
import 'task_action_button.dart';

class TaskCard extends StatelessWidget {
  final TaskResponse task;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const TaskCard({
    super.key,
    required this.task,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final isDone = task.status == 2;

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: Colors.black12, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 30,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    task.title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                TaskStatusBadge(status: task.status),
              ],
            ),

            if (task.description != null &&
                task.description!.trim().isNotEmpty) ...[
              const SizedBox(height: 16),
              Text(
                task.description!,
                style: TextStyle(
                  fontSize: 15,
                  color: isDone ? Colors.black38 : Colors.black54,
                  height: 1.5,
                ),
              ),
            ],

            const SizedBox(height: 24),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TaskActionButton(icon: Icons.edit_outlined, onTap: onEdit),
                const SizedBox(width: 12),
                TaskActionButton(
                  icon: Icons.delete_outline,
                  onTap: onDelete,
                  color: Colors.red.shade600,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
