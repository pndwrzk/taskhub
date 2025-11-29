import 'package:flutter/material.dart';

class TaskActionButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final Color? color;

  const TaskActionButton({
    super.key,
    required this.icon,
    required this.onTap,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.black.withOpacity(0.06),
          border: Border.all(color: Colors.black12),
        ),
        child: Icon(icon, size: 24, color: color ?? Colors.black87),
      ),
    );
  }
}
