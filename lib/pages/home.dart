import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habito/pages/create_habit_page.dart';
import 'package:habito/pages/ori_chat.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Ich bin die Startseite.")),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () => Get.to(CreateHabitPage()),
              child: const Text("Gewohnheit erstellen"),
            ),
            ElevatedButton(
              onPressed: () => Get.to(const OriChat()),
              child: const Text("Ori fragen"),
            ),
          ],
        ),
      ),
    );
  }
}
