import 'package:flutter/material.dart';
import '../models/habit.dart';

class HabitCard extends StatefulWidget {
  final Habit habit;
  final VoidCallback onTap;

  const HabitCard({super.key, required this.habit, required this.onTap});

  @override
  State<HabitCard> createState() => _HabitCardState();
}

class _HabitCardState extends State<HabitCard> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Opacity(
        opacity: isChecked ? 0.5 : 1.0,
        child: Card(
          color: const Color(0xFFF2F9F5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 2,
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: ListTile(
            leading: Checkbox(
              value: isChecked,
              onChanged: (bool? value) {
                setState(() {
                  isChecked = value ?? false;
                });
                print(
                  'Checkbox für "${widget.habit.title}" ${isChecked ? 'aktiviert' : 'deaktiviert'}',
                );
              },
            ),
            title: Text(widget.habit.title),
          ),
        ),
      ),
    );
  }
}
