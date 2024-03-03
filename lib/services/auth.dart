import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_practice_project/models/user.dart';
import 'package:firebase_practice_project/services/database.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //create user obj based on firebaseUser;
  Users? _userFromFirebaseUser(User? user) {
    return user != null ? Users(uid: user.uid) : null;
  }

  // auth change user stream
  Stream<Users?> get user {
    return _auth.authStateChanges().map(_userFromFirebaseUser);
    // return _auth.authStateChanges().map((User? user) => _userFromFirebaseUser(user));
  }

  //sing in anon

  Future<dynamic> signInAnon() async {
    try {
      UserCredential credential = await _auth.signInAnonymously();

      User? user = credential.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      log("signInAnon :$e");
      return null;
    }
  }

  //sign in with email & password
  Future<dynamic> signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? user = credential.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  //register with email & password

  Future<dynamic> registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = credential.user;
      // create a new document for the user with uid
      await DatabaseService(uid: user?.uid).updateUserData('0', 'new member', 100);
      return _userFromFirebaseUser(user);
    } catch (e) {
      log(e.toString());
      return null;
    }
  }
  //sign out

  Future<dynamic> signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      log(e.toString());
      return null;
    }
  }
}
