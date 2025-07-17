import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../bloc/habit/habit_bloc.dart';
import '../bloc/habit/habit_event.dart';
import '../bloc/habit/habit_state.dart';
import '../models/habit.dart';
import '../models/time_of_day_range.dart';
import '../widgets/time_option_chip.dart';

class CreateHabitPage extends StatefulWidget {
  const CreateHabitPage({super.key});

  @override
  State<CreateHabitPage> createState() => _CreateHabitPageState();
}

class _CreateHabitPageState extends State<CreateHabitPage> {
  final TextEditingController _habitNew = TextEditingController();

  bool isMorning = false;
  bool isNoon = false;
  bool isEvening = false;

  final TimeOfDayRange morningRange = TimeOfDayRange(
    start: TimeOfDay(hour: 6, minute: 0),
    end: TimeOfDay(hour: 9, minute: 0),
  );
  final TimeOfDayRange noonRange = TimeOfDayRange(
    start: TimeOfDay(hour: 12, minute: 0),
    end: TimeOfDay(hour: 14, minute: 0),
  );
  final TimeOfDayRange eveningRange = TimeOfDayRange(
    start: TimeOfDay(hour: 18, minute: 0),
    end: TimeOfDay(hour: 21, minute: 0),
  );

  @override
  void dispose() {
    _habitNew.dispose();
    super.dispose();
  }

  void _handleSubmitHabit() async {
    final text = _habitNew.text.trim();

    if (text.isNotEmpty) {
      final habit = Habit(
        id: null,
        title: text,
        createdAt: DateTime.now(),
        morning: isMorning ? morningRange : null,
        noon: isNoon ? noonRange : null,
        evening: isEvening ? eveningRange : null,
      );
      context.read<HabitBloc>().add(AddHabit(habit));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<HabitBloc, HabitState>(
      listener: (context, state) {
        if (state is HabitLoaded) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Habit erfolgreich erstellt!")),
          );

          _habitNew.clear();
          setState(() {
            isMorning = false;
            isNoon = false;
            isEvening = false;
          });

          Future.delayed(const Duration(seconds: 3), () {
            context.goNamed('home');
          });
        }

        if (state is HabitError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const Text(
                "Was möchtest du \nzur Gewohnheit machen?",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _habitNew,
                decoration: const InputDecoration(
                  labelText: "Gewohnheit erstellen",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              TimeOptionChip(
                label: 'morning',
                selected: isMorning,
                toggle: () => setState(() => isMorning = !isMorning),
                range: morningRange,
              ),
              TimeOptionChip(
                label: 'noon',
                selected: isNoon,
                toggle: () => setState(() => isNoon = !isNoon),
                range: noonRange,
              ),
              TimeOptionChip(
                label: 'evening',
                selected: isEvening,
                toggle: () => setState(() => isEvening = !isEvening),
                range: eveningRange,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _handleSubmitHabit,
                child: const Text("Erstellen"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
