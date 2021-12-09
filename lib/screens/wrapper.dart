import 'package:brew_crew/models/user.dart';
import 'package:brew_crew/screens/authentication/authentication.dart';
import 'package:brew_crew/screens/home/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class wrapper extends StatelessWidget {
  //final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    //final user = Provider.of<MyUser>(context);
    // late User user;
    // user = FirebaseAuth.getInstance().getCurrentUser();
    // user = _auth.currentUser!;
    // if (user == null) {
    //   return authentication();
    // } else {
    //return home();
    // }

    User? u = FirebaseAuth.instance.currentUser;
    if (u == null) {
      return authentication();
    } else {
      return home();
    }

    // ignore: unnecessary_null_comparison
    //   if (user == null) {
    //     print("user is null inside wrappper");
    //     return authentication();
    //   } else {
    //     print("returning home in wrapper");
    //     return home();
    //   }
  }
}
