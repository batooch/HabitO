import 'package:habito/models/habit.dart';

abstract class IHabitRepository {
  Future<List<Habit>> fetchHabits();

  Future<void> addHabit(Habit habit);

  Future<void> deleteHabit(String habitId);

  Future<void> updateHabitDoneStatus(String habitId, bool isDone);
}
