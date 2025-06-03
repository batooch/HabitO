import 'package:firebase_auth/firebase_auth.dart';


class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> registerWithEmailAndPassword({
    required String email,
    required String password,
  })async{
    try{
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password);
      return result.user;
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