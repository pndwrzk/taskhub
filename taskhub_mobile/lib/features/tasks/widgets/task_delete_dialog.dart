import 'package:flutter/material.dart';

class TaskDeleteDialog extends StatelessWidget {
  final VoidCallback onDelete;

  const TaskDeleteDialog({super.key, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      title: const Text(
        'Delete Task?',
        style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18),
      ),
      content: const Text(
        'This action cannot be undone.',
        style: TextStyle(color: Colors.black54),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel', style: TextStyle(color: Colors.black54)),
        ),
        TextButton(
          onPressed: () {
            onDelete();
            Navigator.pop(context);
          },
          child: const Text(
            'Delete',
            style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
