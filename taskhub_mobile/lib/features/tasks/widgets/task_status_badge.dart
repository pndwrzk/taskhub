import 'package:flutter/material.dart';

class TaskStatusBadge extends StatelessWidget {
  final int status;

  const TaskStatusBadge({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    final labels = {0: 'To Do', 1: 'In Progress', 2: 'Done'};
    Color backgroundColor;
    Color textColor = Colors.white;

    switch (status) {
      case 0:
        backgroundColor = Colors.grey;
        break;
      case 1:
        backgroundColor = Colors.blue;
        break;
      case 2:
        backgroundColor = Colors.green;
        break;
      default:
        backgroundColor = Colors.grey;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Text(
        labels[status] ?? 'To Do',
        style: TextStyle(
          color: textColor,
          fontSize: 12,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}
