import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<User?> registerWithEmailAndPassword({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
  })async{
    try{
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password);
      User ? user = result.user;
      if(user != null) {
        await _firestore.collection('users').doc(user.uid).set ({
          'uid': user.uid,
          'email': email,
          'firstName': firstName,
          'createdAt': FieldValue.serverTimestamp(),
        });
      }
      return user;
    }on FirebaseAuthException catch (e) {
      print("Registrierungsfehler: ${e.code} → ${e.message}");
      return null;
    }
  }

  Future<User?> loginWithEmailAndPassword ({
    required String email,
    required String password,
})async {
    try{
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return result.user;
    }on FirebaseAuthException catch (e) {
      print("Registrierungsfehler: ${e.code} → ${e.message}");
      return null;
    }
  }

}