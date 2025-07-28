import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habito/bloc/habit_time_range/time_range_event.dart';
import 'package:habito/bloc/habit_time_range/time_range_state.dart';

import '../../models/time_of_day_range.dart';
import '../../repository/time_range_repository.dart';

class TimeRangeBloc extends Bloc<TimeRangeEvent, TimeRangeState> {
  final TimeRangeRepository repository;

  TimeRangeBloc(this.repository)
    : super(
        TimeRangeState(
          ranges: {
            'morning': TimeOfDayRange(
              start: TimeOfDay(hour: 6, minute: 0),
              end: TimeOfDay(hour: 9, minute: 0),
            ),
            'noon': TimeOfDayRange(
              start: TimeOfDay(hour: 12, minute: 0),
              end: TimeOfDay(hour: 14, minute: 0),
            ),
            'evening': TimeOfDayRange(
              start: TimeOfDay(hour: 18, minute: 0),
              end: TimeOfDay(hour: 21, minute: 0),
            ),
          },
        ),
      ) {
    on<UpdateTimeRange>(_onUpdateTimeRange);
    on<LoadTimeRanges>(_onLoadTimeRanges);
  }

  void _onUpdateTimeRange(
    UpdateTimeRange event,
    Emitter<TimeRangeState> emit,
  ) async {
    final updated = Map<String, TimeOfDayRange>.from(state.ranges);
    final newRange = TimeOfDayRange(start: event.start, end: event.end);

    updated[event.period] = newRange;
    emit(state.copyWith(ranges: updated));

    await repository.saveTimeRange(event.period, newRange);
  }

  void _onLoadTimeRanges(
    LoadTimeRanges event,
    Emitter<TimeRangeState> emit,
  ) async {
    try {
      final loaded = await repository.loadTimeRanges();
      emit(TimeRangeState(ranges: loaded));
    } catch (e) {}
  }
}
