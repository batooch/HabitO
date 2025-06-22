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
              const Text(
                "Hallo Annika",
                style: TextStyle(
                  color: Color(0xFF1B3624),
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
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
                        child: Text('Noch keine Habits erstellt.'),
                      );
                    }

                    final morningHabits = habits.where((habit) => habit.morning != null).toList();
                    final noonHabits = habits.where((habit) => habit.noon != null).toList();
                    final eveningHabits = habits.where((habit) => habit.evening != null).toList();

                    return ListView(
                      children: [
                        if (morningHabits.isNotEmpty) ...[
                          const Text(
                            "Morgens",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Text("08:00 - 11:00"),
                          ...morningHabits.map(buildHabitCard).toList(),
                        ],
                        if (noonHabits.isNotEmpty) ...[
                          const SizedBox(height: 16),
                          const Text(
                            "Mittags",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Text("11:00 - 16:00"),
                          ...noonHabits.map(buildHabitCard).toList(),
                        ],
                        if (eveningHabits.isNotEmpty) ...[
                          const SizedBox(height: 16),
                          const Text(
                            "Abends",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Text("16:00 - 22:00"),
                          ...eveningHabits.map(buildHabitCard).toList(),
                        ],
                      ],
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

  Widget buildHabitCard(Habit habit) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(title: Text(habit.title)),
    );
  }
}
