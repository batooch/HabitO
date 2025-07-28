import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/habit.dart';

class HabitRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<List<Habit>> fetchHabits() async {
    final uid = _auth.currentUser?.uid;
    if (uid == null) throw Exception('Kein Benutzer angemeldet');

    final snapshot =
        await _firestore
            .collection('users')
            .doc(uid)
            .collection('habits')
            .get();

    return snapshot.docs
        .map((doc) => Habit.fromMap(doc.data(), doc.id))
        .toList();
  }

  Future<void> addHabit(Habit habit) async {
    final uid = _auth.currentUser?.uid;
    if (uid == null) throw Exception('Kein Benutzer angemeldet');

    await _firestore
        .collection('users')
        .doc(uid)
        .collection('habits')
        .add(habit.toMap());
  }

  Future<void> deleteHabit(String habitId) async {
    final uid = _auth.currentUser?.uid;
    if (uid == null) throw Exception('Kein Benutzer angemeldet');

    await _firestore
        .collection('users')
        .doc(uid)
        .collection('habits')
        .doc(habitId)
        .delete();
  }

  Future<void> updateHabitDoneStatus(String habitId, bool isDone) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('habits')
        .doc(habitId)
        .update({'done': isDone});
  }
}
