import 'package:flutter/material.dart';
import 'package:habito/constants/app_colors.dart';
import 'package:habito/models/habit.dart';

class HabitCard extends StatelessWidget {
  final Habit habit;
  final bool isChecked;
  final void Function(bool?) onCheckboxChanged;
  final VoidCallback onTap;

  const HabitCard({
    super.key,
    required this.habit,
    required this.isChecked,
    required this.onCheckboxChanged,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: isChecked ? 0.5 : 1.0,
      child: Card(
        color: AppColors.backgroundSoft,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 2,
        margin: const EdgeInsets.symmetric(vertical: 8),
        child: ListTile(
          onTap: onTap,
          leading: Checkbox(value: isChecked, onChanged: onCheckboxChanged),
          title: Text(habit.title, style: const TextStyle(fontSize: 16)),
        ),
      ),
    );
  }
}
