class Habit {
  final String? id;
  final String title;
  final DateTime createdAt;
  final bool morning;
  final bool noon;
  final bool evening;

  Habit({
    required this.id,
    required this.title,
    required this.createdAt,
    required this.morning,
    required this.noon,
    required this.evening,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'createdAt': createdAt.toIso8601String(),
      'morning': morning,
      'noon': noon,
      'evening': evening,
    };
  }
}
