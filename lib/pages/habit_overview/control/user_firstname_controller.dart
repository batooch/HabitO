import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../model/user_first_name.dart';

class UserController {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  Future<AppUser> fetchCurrentUserFirstName() async {
    final uid = _auth.currentUser?.uid;
    if (uid == null) throw Exception('Kein Nutzer angemeldet');

    final doc = await _firestore.collection('users').doc(uid).get();
    if (!doc.exists) throw Exception('Nutzer nicht gefunden');

    return AppUser.fromMap(doc.data()!, uid);
  }
}
