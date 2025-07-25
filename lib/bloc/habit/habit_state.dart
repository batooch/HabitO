import '../../models/habit.dart';

abstract class HabitState {}

class HabitInitial extends HabitState {}

class HabitLoading extends HabitState {}

class HabitLoaded extends HabitState {
  final List<Habit> habits;

  HabitLoaded(this.habits);
}

class HabitError extends HabitState {
  final String message;

  HabitError(this.message);
}

class HabitAddSuccess extends HabitState {}

class HabitDeleteSuccess extends HabitState {}
