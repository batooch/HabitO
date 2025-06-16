import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:habito/pages/create_habit/control/create_habit_controller.dart';
import 'package:habito/pages/create_habit/model/habit.dart';

class CreateHabitPage extends StatefulWidget {
  const CreateHabitPage({super.key});

  @override
  State<CreateHabitPage> createState() => _CreateHabitPageState();
}

class _CreateHabitPageState extends State<CreateHabitPage> {
  final TextEditingController _habitNew = TextEditingController();
  final CreateHabitController _habitController = CreateHabitController();

  @override
  void dispose() {
    _habitNew.dispose();
    super.dispose();
  }

  void _handleSubmitHabit() async {
    final text = _habitNew.text.trim();

    if (text.isNotEmpty) {
      final habit = Habit(id: null, title: text, createdAt: DateTime.now());
      await _habitController.addHabit(habit);
      _habitNew.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Was möchtest du zur Gewohnheit machen?")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _habitNew,
              decoration: const InputDecoration(
                labelText: "Gewohnheit erstellen",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                _handleSubmitHabit();
              },
              child: const Text("Erstellen"),
            ),
          ],
        ),
      ),
    );
  }
}
