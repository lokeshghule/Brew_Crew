import 'package:brew_crew/models/user.dart';
import 'package:brew_crew/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/rendering.dart';

class authService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

//  _auth.authStateChanges().listen(User? user){
//     if(user == null){
//       print("user is currently signed out!");
//     }
//     else{
//       print("User Signed in!");
//     }
//   }

  MyUser? _userFromFirebaseUser(User? user) {
    // MyUser newuser = MyUser(uid: user!.uid);
    // return newuser;
    return user != null ? MyUser(uid: user.uid) : null;
  }

  Stream<MyUser?> get user {
    return _auth.authStateChanges().map(_userFromFirebaseUser);
  }

  // _auth.authStateChanges().listen(User? user){
  //   if(user == null){
  //     print("user is currently signed out!");
  //   }
  //   else{
  //     print("User Signed in!");
  //   }
  // }

  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<void> Sign_out() async {
    try {
      // print("try block completer into auth");
      await _auth.signOut();
    } catch (e) {
      print(e.toString());
      // print("Errorrrrrrrrr ocurrredddd!");
      return null;
    }
  }

  // ignore: non_constant_identifier_names
  Future? RegisterWithEmailandPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      User? user = userCredential.user;
      if (user != null) {
        await DatabaseService(uid: user.uid)
            .updateUserData('0', 'new member', 100);
      } else {
        throw NullThrownError;
      }
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = userCredential.user;

      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
