import 'package:flutter/material.dart';

abstract class TimeRangeEvent {}

class UpdateTimeRange extends TimeRangeEvent {
  final String period;
  final TimeOfDay start;
  final TimeOfDay end;

  UpdateTimeRange({
    required this.period,
    required this.start,
    required this.end,
  });
}

class LoadTimeRanges extends TimeRangeEvent {}
