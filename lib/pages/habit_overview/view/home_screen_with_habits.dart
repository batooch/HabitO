import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:habito/pages/create_habit/model/habit.dart';

import '../control/habit_list_controller.dart';
import '../control/user_firstname_controller.dart';
import '../model/user_first_name.dart';

class HomeScreenWithHabits extends StatefulWidget {
  const HomeScreenWithHabits({super.key});

  @override
  State<HomeScreenWithHabits> createState() => _HomeScreenWithHabitsState();
}

class _HomeScreenWithHabitsState extends State<HomeScreenWithHabits> {
  final HabitListController _habitController = HabitListController();
  final UserController _userController = UserController();

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
              FutureBuilder<AppUser>(
                future: _userController.fetchCurrentUserFirstName(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  }

                  if (snapshot.hasError) {
                    return const Text(
                      "Hallo",
                      style: TextStyle(
                        color: Color(0xFF1B3624),
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  }

                  final user = snapshot.data!;
                  print('Geladener Vorname: ${user.firstName}');
                  return Text(
                    "Hallo ${user.firstName}",
                    style: const TextStyle(
                      color: Color(0xFF1B3624),
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                },
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

                    final morningHabits =
                        habits.where((habit) => habit.morning != null).toList();
                    final noonHabits =
                        habits.where((habit) => habit.noon != null).toList();
                    final eveningHabits =
                        habits.where((habit) => habit.evening != null).toList();

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
    return GestureDetector(
      onTap: () => _showHabitDetailsDialog(habit),
      child: Card(
        color: const Color(0xFFF2F9F5),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 2,
        margin: const EdgeInsets.symmetric(vertical: 8),
        child: ListTile(title: Text(habit.title)),
      ),
    );
  }

  void _showHabitDetailsDialog(Habit habit) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            title: Text(
              habit.title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Erstellt am: ${habit.createdAt.toLocal().toString().split(' ')[0]}",
                ),

                const SizedBox(height: 20),
                const Text("Möchtest du diese Gewohnheit löschen?"),
              ],
            ),
            actions: [
              TextButton(
                child: const Text("Abbrechen"),
                onPressed: () => context.pop(),
              ),
              TextButton(
                child: const Text(
                  "Löschen",
                  style: TextStyle(color: Colors.red),
                ),
                onPressed: () async {
                  await _habitController.deleteHabit(habit.id!);
                  context.pop();
                  setState(() {});
                },
              ),
            ],
          ),
    );
  }
}
