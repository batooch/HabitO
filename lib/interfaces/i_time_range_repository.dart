import 'package:habito/models/time_of_day_range.dart';

abstract class ITimeRangeRepository {
  Future<void> saveTimeRange(String period, TimeOfDayRange range);

  Future<Map<String, TimeOfDayRange>> loadTimeRanges();
}
