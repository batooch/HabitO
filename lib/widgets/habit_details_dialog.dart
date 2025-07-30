import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:habito/constants/app_texts.dart';
import 'package:habito/constants/app_text_styles.dart';
import 'package:habito/models/habit.dart';

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
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: Text(
        habit.title,
        style: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.bold),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${AppTexts.habitDialogCreatedAt} ${habit.createdAt
                .toLocal()
                .toString()
                .split(' ')[0]}',
            style: AppTextStyles.bodySmall,
          ),
          const SizedBox(height: 20),
          Text(
            AppTexts.habitDialogDeleteQuestion,
            style: AppTextStyles.bodyMedium,
          ),
        ],
      ),
      actions: [
    TextButton(
    child: Text(
    AppTexts.habitDialogCancel,
      style: AppTextStyles.bodyMedium,
    ),
    onPressed: () => context.pop(),
    ),
    TextButton(
    child: Text(
    AppTexts.habitDialogDelete,
    style: AppTextStyles.bodyMedium.copyWith(color: Colors.red),
    ),
    onPressed: () {
    onDelete();
    context.goNamed('home');
    },
    )
    ,
    ]
    ,
    );
  }
}
