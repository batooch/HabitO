import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:habito/models/habit.dart';

import '../widgets/custom_fab.dart';
import '../controllers/habit_list_controller.dart';
import '../widgets/habit_card.dart';
import '../widgets/habit_details_dialog.dart';

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
                'Deine Gewohnheiten',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
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
                          const Text(
                            '06:00 – 09:00',
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                          ),

                          ...morningHabits
                              .map(
                                (habit) => HabitCard(
                                  habit: habit,
                                  onTap: () => _showHabitDetailsDialog(habit),
                                ),
                              )
                              .toList(),
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
                          const Text(
                            '12:00 – 14:00',
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                          ),

                          ...noonHabits
                              .map(
                                (habit) => HabitCard(
                                  habit: habit,
                                  onTap: () => _showHabitDetailsDialog(habit),
                                ),
                              )
                              .toList(),
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
                          const Text(
                            '18:00 – 21:00',
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                          ),

                          ...eveningHabits
                              .map(
                                (habit) => HabitCard(
                                  habit: habit,
                                  onTap: () => _showHabitDetailsDialog(habit),
                                ),
                              )
                              .toList(),
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
      floatingActionButton: const CustomFAB(

      ),
    );
  }

  void _showHabitDetailsDialog(Habit habit) {
    showDialog(
      context: context,
      builder:
          (context) => HabitDetailsDialog(
            habit: habit,
            onDelete: () async {
              await _habitController.deleteHabit(habit.id!);
              context.pop();
              setState(() {});
            },
          ),
    );
  }
}
