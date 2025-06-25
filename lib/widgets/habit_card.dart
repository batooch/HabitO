import 'package:flutter/material.dart';
import '../models/habit.dart';

class HabitCard extends StatelessWidget {
  final Habit habit;
  final VoidCallback onTap;

  const HabitCard({super.key, required this.habit, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: const Color(0xFFF2F9F5),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 2,
        margin: const EdgeInsets.symmetric(vertical: 8),
        child: ListTile(
          leading: Checkbox(
            value: false,
            onChanged: (bool? value) {
              print('Checkbox für "${habit.title}" geklickt');
            },
          ),
          title: Text(habit.title),
        ),
      ),
    );
  }
}
