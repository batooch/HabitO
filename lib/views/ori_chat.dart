import 'package:flutter/material.dart';
import 'package:habito/constants/app_text_styles.dart';
import 'package:habito/constants/app_texts.dart';

import 'package:habito/widgets/ori_light.dart';

class OriChat extends StatelessWidget {
  const OriChat({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xFF1D4033)),
        title: const Text(
          AppTexts.oriTitle,
          style: AppTextStyles.headlineLarge,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: const Text(
                AppTexts.oriWelcomeMessage,
                style: AppTextStyles.bodyLarge,
              ),
            ),

            const Row(
              children: [
                Icon(Icons.lightbulb, color: Color(0xFF1D4033)),
                SizedBox(width: 8),
                Text(
                  AppTexts.oriSuggestionTitle,
                  style: AppTextStyles.bodyMedium,
                ),
              ],
            ),

            const SizedBox(height: 12),

            Expanded(child: HabitSuggestions()),
          ],
        ),
      ),
    );
  }
}
