import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:habito/pages/habit_overview/view/home_screen_with_habits.dart';
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
              onPressed: () {
                context.goNamed('create');
              },
              child: const Text("Gewohnheit erstellen"),
            ),
            ElevatedButton(
              onPressed: () {
                context.goNamed('ori');
              },
              child: const Text("Ori fragen"),
            ),
            ElevatedButton(
              onPressed: () {
                context.goNamed('home');
              },
              child: const Text("Habits zeigen"),
            ),
          ],
        ),
      ),
    );
  }
}
