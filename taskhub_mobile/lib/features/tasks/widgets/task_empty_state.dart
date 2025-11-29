import 'package:flutter/material.dart';

class TaskEmptyState extends StatelessWidget {
  const TaskEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.checklist_outlined,
            size: 110,
            color: Colors.black.withOpacity(0.15),
          ),
          const SizedBox(height: 32),
          const Text(
            'No tasks yet',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w800,
              color: Colors.black54,
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'Tap + to create one',
            style: TextStyle(fontSize: 16, color: Colors.black38),
          ),
        ],
      ),
    );
  }
}
