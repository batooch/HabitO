import 'package:habito/models/time_of_day_range.dart';

class Habit {
  final String? id;
  final String title;
  final DateTime createdAt;
  final TimeOfDayRange? morning;
  final TimeOfDayRange? noon;
  final TimeOfDayRange? evening;
  final bool isDone;

  Habit({
    required this.id,
    required this.title,
    required this.createdAt,
    this.morning,
    this.noon,
    this.evening,
    this.isDone = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'createdAt': createdAt.toIso8601String(),
      'morning': morning?.toMap(),
      'noon': noon?.toMap(),
      'evening': evening?.toMap(),
      'isDone': isDone,
    };
  }

  factory Habit.fromMap(Map<String, dynamic> map, String documentId) {
    return Habit(
      id: documentId,
      title: map['title'] as String? ?? 'Unbenannt',
      createdAt:
          map['createdAt'] != null
              ? DateTime.tryParse(map['createdAt'] as String) ?? DateTime.now()
              : DateTime.now(),
      morning:
          map['morning'] != null && map['morning'] is Map
              ? TimeOfDayRange.fromMap(map['morning'] as Map<String, dynamic>)
              : null,
      noon:
          map['noon'] != null && map['noon'] is Map
              ? TimeOfDayRange.fromMap(map['noon'] as Map<String, dynamic>)
              : null,
      evening:
          map['evening'] != null && map['evening'] is Map
              ? TimeOfDayRange.fromMap(map['evening'] as Map<String, dynamic>)
              : null,
      isDone: map['isDone'] as bool? ?? false,
    );
  }

  Habit copyWith({
    String? id,
    String? title,
    DateTime? createdAt,
    TimeOfDayRange? morning,
    TimeOfDayRange? noon,
    TimeOfDayRange? evening,
    bool? isDone,
  }) {
    return Habit(
      id: id ?? this.id,
      title: title ?? this.title,
      createdAt: createdAt ?? this.createdAt,
      morning: morning ?? this.morning,
      noon: noon ?? this.noon,
      evening: evening ?? this.evening,
      isDone: isDone ?? this.isDone,
    );
  }
}
