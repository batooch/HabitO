import 'package:flutter/material.dart';

import 'package:habito/widgets/ori_light.dart';

class OriChat extends StatelessWidget {
  const OriChat({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDF7ED),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFDF7ED),
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xFF1D4033)),
        title: const Text('Ori', style: TextStyle(color: Color(0xFF1D4033))),
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
                'Hi, ich bin Ori. Ich helfe dir dabei,\ndeine Ziele in kleine Schritte zu verwandeln.\nWas ist dein Ziel?',
                style: TextStyle(
                  fontSize: 16,
                  height: 1.5,
                  color: Color(0xFF1D4033),
                ),
              ),
            ),

            const Row(
              children: [
                Icon(Icons.lightbulb, color: Color(0xFF1D4033)),
                SizedBox(width: 8),
                Text(
                  'Hier findest du Vorschläge für neue Gewohnheiten.',
                  style: TextStyle(
                    color: Color(0xFF1D4033),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            const Expanded(child: HabitSuggestions()),
          ],
        ),
      ),
    );
  }
}
