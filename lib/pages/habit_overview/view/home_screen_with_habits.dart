import 'package:flutter/material.dart';

import 'package:habito/pages/create_habit/model/habit.dart';

import '../control/habit_list_controller.dart';

class HomeScreenWithHabits extends StatefulWidget {
  const HomeScreenWithHabits({super.key});

  @override
  State<HomeScreenWithHabits> createState() => _HomeScreenWithHabitsState();
}

class _HomeScreenWithHabitsState extends State<HomeScreenWithHabits> {
  final HabitListController _habitController = HabitListController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF5EE),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1️⃣ Begrüßung
              const Text(
                "Hallo Annika",
                style: TextStyle(
                  color: Color(0xFF1B3624),
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),

              // 2️⃣ FutureBuilder für die Habit-Liste
              Expanded(
                child: FutureBuilder<List<Habit>>(
                  future: _habitController.fetchHabits(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (snapshot.hasError) {
                      return Center(child: Text('Fehler: ${snapshot.error}'));
                    }

                    final habits = snapshot.data;

                    if (habits == null || habits.isEmpty) {
                      return const Center(
                          child: Text('Noch keine Habits erstellt.'));
                    }

                    return ListView.builder(
                      itemCount: habits.length,
                      itemBuilder: (context, index) {
                        final habit = habits[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 8.0),
                          child: ListTile(
                            title: Text(habit.title),
                            subtitle: Text(
                              ' ${habit.morning ? 'Morgens ' : ''}${habit.noon ? 'Mittags ' : ''}${habit.evening ? 'Abends' : ''}',
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
