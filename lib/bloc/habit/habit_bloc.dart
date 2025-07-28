import 'package:flutter_bloc/flutter_bloc.dart';
import '../../repository/habit_repository.dart';
import 'habit_event.dart';
import 'habit_state.dart';

class HabitBloc extends Bloc<HabitEvent, HabitState> {
  final HabitRepository habitRepository;

  HabitBloc(this.habitRepository) : super(HabitInitial()) {
    on<LoadHabits>((event, emit) async {
      emit(HabitLoading());
      try {
        final habits = await habitRepository.fetchHabits();
        emit(HabitLoaded(habits));
      } catch (e) {
        emit(HabitError("Fehler beim Laden der Habits"));
      }
    });

    on<AddHabit>((event, emit) async {
      try {
        await habitRepository.addHabit(event.habit);
        final habits = await habitRepository.fetchHabits();
        emit(HabitLoaded(habits));
        emit(HabitAddSuccess());
      } catch (e) {
        emit(HabitError("Fehler beim Hinzufügen"));
      }
    });

    on<DeleteHabit>((event, emit) async {
      try {
        await habitRepository.deleteHabit(event.habitId);
        final habits = await habitRepository.fetchHabits();
        emit(HabitLoaded(habits));
      } catch (e) {
        emit(HabitError("Fehler beim Löschen"));
      }
    });

    on<ToggleHabitDone>((event, emit) async {
      try {
        await habitRepository.updateHabitDoneStatus(event.habitId, event.isDone);
        final habits = await habitRepository.fetchHabits();
        emit(HabitLoaded(habits));
      } catch (e) {
        emit(HabitError("Fehler beim Aktualisieren des Habit-Status"));
      }
    });

  }
}
