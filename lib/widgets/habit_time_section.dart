import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:habito/models/habit.dart';
import 'package:habito/widgets/habit_card.dart';

class HabitTimeSection extends StatelessWidget {
  final String title;
  final List<Habit> habits;
  final String timeText;
  final void Function(Habit habit) onHabitTap;
  final void Function(Habit habit, bool isChecked) onCheckboxChanged;

  const HabitTimeSection({
    super.key,
    required this.title,
    required this.habits,
    required this.timeText,
    required this.onHabitTap,
    required this.onCheckboxChanged,
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
          (habit) => HabitCard(
            habit: habit,
            isChecked: habit.isDone,
            onCheckboxChanged:
                (value) => onCheckboxChanged(habit, value ?? false),
            onTap: () => onHabitTap(habit),
          ),
        ),
      ],
    );
  }
}
