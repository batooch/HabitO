import '../../models/time_of_day_range.dart';

class TimeRangeState {
  final Map<String, TimeOfDayRange> ranges;

  TimeRangeState({required this.ranges});

  TimeRangeState copyWith({Map<String, TimeOfDayRange>? ranges}) {
    return TimeRangeState(ranges: ranges ?? this.ranges);
  }

  TimeOfDayRange? getRange(String period) => ranges[period];
}
