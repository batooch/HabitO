import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:habito/bloc/habit/habit_bloc.dart';
import 'package:habito/bloc/habit/habit_event.dart';
import 'package:habito/bloc/habit/habit_state.dart';
import 'package:habito/bloc/habit_time_range/time_range_bloc.dart';
import 'package:habito/bloc/habit_time_range/time_range_state.dart';
import 'package:habito/models/habit.dart';
import 'package:habito/widgets/time_option_chip.dart';

class CreateHabitPage extends StatefulWidget {
  const CreateHabitPage({super.key});

  @override
  State<CreateHabitPage> createState() => _CreateHabitPageState();
}

class _CreateHabitPageState extends State<CreateHabitPage> {
  final TextEditingController _habitNew = TextEditingController();
  final Set<String> selectedPeriods = {};

  void _handleSubmitHabit(TimeRangeState state) {
    final text = _habitNew.text.trim();
    if (text.isEmpty) return;

    final habit = Habit(
      id: null,
      title: text,
      createdAt: DateTime.now(),
      morning:
          selectedPeriods.contains('morning') ? state.ranges['morning'] : null,
      noon: selectedPeriods.contains('noon') ? state.ranges['noon'] : null,
      evening:
          selectedPeriods.contains('evening') ? state.ranges['evening'] : null,
    );

    context.read<HabitBloc>().add(AddHabit(habit));
  }

  @override
  void dispose() {
    _habitNew.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<HabitBloc, HabitState>(
      listener: (context, state) {
        if (state is HabitAddSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Habit erfolgreich erstellt!')),
          );
          _habitNew.clear();
          selectedPeriods.clear();
          Future.delayed(const Duration(seconds: 2), () {
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
          child: BlocBuilder<TimeRangeBloc, TimeRangeState>(
            builder: (context, timeState) {
              return Column(
                children: [
                  const Text(
                    'Was möchtest du \nzur Gewohnheit machen?',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: _habitNew,
                    decoration: const InputDecoration(
                      labelText: 'Gewohnheit erstellen',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ...['morning', 'noon', 'evening'].map((period) {
                    return TimeOptionChip(
                      label: period,
                      selected: selectedPeriods.contains(period),
                      toggle: () {
                        setState(() {
                          if (selectedPeriods.contains(period)) {
                            selectedPeriods.remove(period);
                          } else {
                            selectedPeriods.add(period);
                          }
                        });
                      },
                    );
                  }),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () => _handleSubmitHabit(timeState),
                    child: const Text('Erstellen'),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
