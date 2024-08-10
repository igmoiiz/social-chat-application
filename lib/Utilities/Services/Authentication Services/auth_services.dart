import 'package:firebase_auth/firebase_auth.dart';

class AuthServices {
  //  FIREBASE AUTHENTICATION INSTANCE
  final auth = FirebaseAuth.instance;
  //  METHOD TO SIGN IN
  Future<UserCredential> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  //  METHOD TO SIGN UP
  Future<UserCredential> signUpWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  //  METHOD TO SIGN OUT
  Future<void> signOutMethod() async {
    return await auth.signOut();
  }

  //  METHOD FOR FORGET PASSWORD

  //  errors
}
