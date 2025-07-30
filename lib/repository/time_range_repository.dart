import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:habito/interfaces/i_time_range_repository.dart';
import 'package:habito/models/time_of_day_range.dart';

class TimeRangeRepository implements ITimeRangeRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Future<void> saveTimeRange(String period, TimeOfDayRange range) async {
    final uid = _auth.currentUser?.uid;
    if (uid == null) throw Exception('Kein Benutzer angemeldet');

    await _firestore
        .collection('users')
        .doc(uid)
        .collection('timeRanges')
        .doc(period)
        .set(range.toMap());
  }

  @override
  Future<Map<String, TimeOfDayRange>> loadTimeRanges() async {
    final uid = _auth.currentUser?.uid;
    if (uid == null) throw Exception('Kein Benutzer angemeldet');

    final snapshot =
        await _firestore
            .collection('users')
            .doc(uid)
            .collection('timeRanges')
            .get();

    return {
      for (var doc in snapshot.docs) doc.id: TimeOfDayRange.fromMap(doc.data()),
    };
  }
}
