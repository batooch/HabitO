import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> registerUser({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
  }) async {
    UserCredential result = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    final user = result.user;
    if (user == null) {
      throw FirebaseAuthException(
        code: 'registration-failed',
        message: 'User creation returned null.',
      );
    }

    await _firestore.collection('users').doc(user.uid).set({
      'uid': user.uid,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'createdAt': FieldValue.serverTimestamp(),
    });

    return user.uid;
  }

  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    UserCredential result = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    final user = result.user;
    if (user == null) {
      throw FirebaseAuthException(
        code: 'login-failed',
        message: 'Login returned null.',
      );
    }

    return user.uid;
  }

  Future<void> logout() async {
    await _auth.signOut();
  }
}
