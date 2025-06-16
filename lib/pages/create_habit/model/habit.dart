
 class Habit {

  final String? id;
  final String title;
  final DateTime createdAt;

  Habit({
   required this.id,
   required this.title,
    required this.createdAt,
  });
  Map<String, dynamic> toMap() {
   return {
    'title': title,
    'createdAt': createdAt.toIso8601String(),
   };
  }
}