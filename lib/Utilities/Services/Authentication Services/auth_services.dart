import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthServices {
  //  FIREBASE AUTHENTICATION INSTANCE
  final auth = FirebaseAuth.instance;

  //  GET CURRENT USER
  User? getCurrentUser() {
    return auth.currentUser;
  }

  //  FIREBASE FIRE STORE INSTANCE
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  //  METHOD TO SIGN IN
  Future<UserCredential> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      //  sign the authenticated user into the application
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      //  save user information in a separate file if it doesn't already exist
      // and is created through backend of application
      firebaseFirestore.collection('Users').doc(userCredential.user!.uid).set({
        'uid': userCredential.user!.uid,
        'email': email,
      });
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  //  METHOD TO SIGN UP
  Future<UserCredential> signUpWithEmailAndPassword(
      String email, String password) async {
    try {
      //  create the user
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      //  save user information in a separate file
      firebaseFirestore.collection('Users').doc(userCredential.user!.uid).set({
        'uid': userCredential.user!.uid,
        'email': email,
        'name': userCredential.user!.displayName,
      });
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
