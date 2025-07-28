import 'package:habito/models/habit.dart';

abstract class HabitEvent {}

class LoadHabits extends HabitEvent {}

class AddHabit extends HabitEvent {
  final Habit habit;

  AddHabit(this.habit);
}

class DeleteHabit extends HabitEvent {
  final String habitId;

  DeleteHabit(this.habitId);
}

class ToggleHabitDone extends HabitEvent {
  final String habitId;
  final bool isDone;

  ToggleHabitDone(this.habitId, this.isDone);
}
