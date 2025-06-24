import 'package:habito/models/time_of_day_range.dart';

class Habit {
  final String? id;
  final String title;
  final DateTime createdAt;
  final TimeOfDayRange? morning;
  final TimeOfDayRange? noon;
  final TimeOfDayRange? evening;

  Habit({
    required this.id,
    required this.title,
    required this.createdAt,
    this.morning,
    this.noon,
    this.evening,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'createdAt': createdAt.toIso8601String(),
      'morning': morning?.toMap(),
      'noon': noon?.toMap(),
      'evening': evening?.toMap(),
    };
  }

  factory Habit.fromMap(Map<String, dynamic> map, String documentId) {
    return Habit(
      id: documentId,
      title: map['title'] ?? 'Unbenannt',
      createdAt:
          map['createdAt'] != null
              ? DateTime.tryParse(map['createdAt']) ?? DateTime.now()
              : DateTime.now(),
      morning:
          map['morning'] != null && map['morning'] is Map
              ? TimeOfDayRange.fromMap(
                Map<String, dynamic>.from(map['morning']),
              )
              : null,
      noon:
          map['noon'] != null && map['noon'] is Map
              ? TimeOfDayRange.fromMap(Map<String, dynamic>.from(map['noon']))
              : null,
      evening:
          map['evening'] != null && map['evening'] is Map
              ? TimeOfDayRange.fromMap(
                Map<String, dynamic>.from(map['evening']),
              )
              : null,
    );
  }
}
