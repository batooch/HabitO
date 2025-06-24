import 'package:flutter/material.dart';

class TimeOfDayRange {
  final TimeOfDay start;
  final TimeOfDay end;

  TimeOfDayRange({
    required this.start,
    required this.end,
  });

  Map<String, String> toMap() {
    return {
      'start': _formatTime(start),
      'end': _formatTime(end),
    };
  }

  factory TimeOfDayRange.fromMap(Map<String, dynamic> map) {
    return TimeOfDayRange(
      start: _parseTime(map['start']),
      end: _parseTime(map['end']),
    );
  }

  static String _formatTime(TimeOfDay time) {
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  static TimeOfDay _parseTime(String timeStr) {
    final parts = timeStr.split(':');
    return TimeOfDay(
      hour: int.parse(parts[0]),
      minute: int.parse(parts[1]),
    );
  }

  @override
  String toString() {
    return '${_formatTime(start)} – ${_formatTime(end)}';
  }
}
