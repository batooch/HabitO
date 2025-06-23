import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:habito/pages/create_habit/model/habit.dart';

class HabitListController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<List<Habit>> fetchHabits() async {
    final uid = _auth.currentUser?.uid;

    if (uid == null) {
      print('Kein Benutzer angemeldet.');
      return [];
    }
    try {
      final snapshot =
          await _firestore
              .collection('users')
              .doc(uid)
              .collection('habits')
              .get();

      final List<Habit> habits = [];

      for (var doc in snapshot.docs) {
        final habitData = doc.data();
        final habitId = doc.id;
        final habit = Habit.fromMap(habitData, habitId);
        habits.add(habit);
      }

      return habits;
    } catch (e) {
      print('Fehler beim Abrufen der Habits');
      return [];
    }
  }

  Future<void> deleteHabit(String habitId) async {
    final uid = _auth.currentUser?.uid;

    if (uid == null) {
      print('Kein Benutzer angemeldet.');
      return;
    }

    try {
      await _firestore
          .collection('users')
          .doc(uid)
          .collection('habits')
          .doc(habitId)
          .delete();
      print('Habit erfolgreich gelöscht.');
    } catch (e) {
      print('Fehler beim Löschen des Habits: $e');
    }
  }
}
