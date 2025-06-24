import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/habit.dart';

class CreateHabitController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> addHabit(Habit habit) async {
    final uid = _auth.currentUser?.uid;
    if (uid == null) {
      print("Kein Benutzer angemeldet.");
      return;
    }

    try {
      await _firestore
          .collection('users')
          .doc(uid)
          .collection('habits')
          .add(habit.toMap());
      print("Habit erfolgreich gespeichert.");
    } catch (e) {
      print("Fehler beim Speichern des Habits: $e");
    }
  }
}
