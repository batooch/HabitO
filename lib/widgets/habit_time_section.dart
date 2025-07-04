import 'package:flutter/material.dart';
import '../models/habit.dart';
import 'habit_card.dart';

class HabitTimeSection extends StatelessWidget {
  final String title;
  final List<Habit> habits;
  final String timeText;
  final void Function(Habit habit) onHabitTap;

  const HabitTimeSection({
    super.key,
    required this.title,
    required this.habits,
    required this.timeText,
    required this.onHabitTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        Text(
          timeText,
          style: const TextStyle(fontSize: 14, color: Colors.grey),
        ),
        const SizedBox(height: 8),
        ...habits.map(
          (habit) => HabitCard(habit: habit, onTap: () => onHabitTap(habit)),
        ),
      ],
    );
  }
}
