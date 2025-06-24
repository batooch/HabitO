import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../pages/create_habit/model/habit.dart';


class HabitDetailsDialog extends StatelessWidget {
  final Habit habit;
  final VoidCallback onDelete;

  const HabitDetailsDialog({
    super.key,
    required this.habit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      title: Text(
        habit.title,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Erstellt am: ${habit.createdAt.toLocal().toString().split(' ')[0]}"),
          const SizedBox(height: 20),
          const Text("Möchtest du diese Gewohnheit löschen?"),
        ],
      ),
      actions: [
        TextButton(
          child: const Text("Abbrechen"),
          onPressed: () => context.pop(),
        ),
        TextButton(
          child: const Text("Löschen", style: TextStyle(color: Colors.red)),
          onPressed: () {
            onDelete();
            context.pop();
          },
        ),
      ],
    );
  }
}
