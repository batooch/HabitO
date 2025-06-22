import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:time_range_picker/time_range_picker.dart';

import '../control/create_habit_controller.dart';
import '../model/habit.dart';
import '../model/time_of_day_range.dart';

class CreateHabitPage extends StatefulWidget {
  const CreateHabitPage({super.key});

  @override
  State<CreateHabitPage> createState() => _CreateHabitPageState();
}

class _CreateHabitPageState extends State<CreateHabitPage> {
  final TextEditingController _habitNew = TextEditingController();
  final CreateHabitController _habitController = CreateHabitController();

  bool isMorning = false;
  bool isNoon = false;
  bool isEvening = false;

  TimeOfDayRange morningRange = TimeOfDayRange(
    start: const TimeOfDay(hour: 6, minute: 0),
    end: const TimeOfDay(hour: 9, minute: 0),
  );
  TimeOfDayRange noonRange = TimeOfDayRange(
    start: const TimeOfDay(hour: 12, minute: 0),
    end: const TimeOfDay(hour: 14, minute: 0),
  );
  TimeOfDayRange eveningRange = TimeOfDayRange(
    start: const TimeOfDay(hour: 18, minute: 0),
    end: const TimeOfDay(hour: 21, minute: 0),
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
      await _habitController.addHabit(habit);

      _habitNew.clear();
      setState(() {
        isMorning = false;
        isNoon = false;
        isEvening = false;
      });

      context.goNamed('home');
    }
  }

  Future<void> _selectTimeRange(String label) async {
    TimeOfDayRange current = switch (label) {
      'morning' => morningRange,
      'noon' => noonRange,
      'evening' => eveningRange,
      _ => morningRange,
    };

    final result = await showTimeRangePicker(
      context: context,
      start: current.start,
      end: current.end,
    );

    if (result != null) {
      setState(() {
        final newRange = TimeOfDayRange(start: result.startTime, end: result.endTime);
        switch (label) {
          case 'morning':
            morningRange = newRange;
            break;
          case 'noon':
            noonRange = newRange;
            break;
          case 'evening':
            eveningRange = newRange;
            break;
        }
      });
    }
  }

  Widget _buildTimeOption({
    required String label,
    required bool selected,
    required VoidCallback toggle,
    required TimeOfDayRange range,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ChoiceChip(
          label: Text(label[0].toUpperCase() + label.substring(1)),
          selected: selected,
          onSelected: (_) => setState(toggle),
        ),
        if (selected)
          InkWell(
            onTap: () => _selectTimeRange(label),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                children: [
                  Text(range.toString(), style: const TextStyle(fontSize: 16)),
                  const SizedBox(width: 8),
                  const Icon(Icons.access_time, size: 18),
                ],
              ),
            ),
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Was möchtest du zur Gewohnheit machen?")),
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
            _buildTimeOption(
              label: 'morning',
              selected: isMorning,
              toggle: () => isMorning = !isMorning,
              range: morningRange,
            ),
            _buildTimeOption(
              label: 'noon',
              selected: isNoon,
              toggle: () => isNoon = !isNoon,
              range: noonRange,
            ),
            _buildTimeOption(
              label: 'evening',
              selected: isEvening,
              toggle: () => isEvening = !isEvening,
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
    );
  }
}
