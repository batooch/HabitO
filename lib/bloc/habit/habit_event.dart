import '../../models/habit.dart';

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
