import 'package:brew_crew/screens/authentication/register.dart';
import 'package:brew_crew/screens/authentication/sign_in.dart';
import 'package:flutter/material.dart';

class authentication extends StatefulWidget {
  @override
  _authenticationState createState() => _authenticationState();
}

class _authenticationState extends State<authentication> {
  bool showSignIn = true;

  void toggleView() {
    setState(() {
      showSignIn = !showSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn == true) {
      return signIn(toggleView: toggleView);
    } else {
      return Register(toggleView: toggleView);
    }
  }
}
