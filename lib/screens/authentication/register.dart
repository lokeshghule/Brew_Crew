import 'package:brew_crew/screens/authentication/authentication.dart';
import 'package:brew_crew/screens/home/home.dart';
import 'package:brew_crew/services/auth.dart';
import 'package:brew_crew/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:brew_crew/shared/constants.dart';

class Register extends StatefulWidget {
  Function toggleView;

  Register({required this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final authService _auth = authService();
  final _formKey = GlobalKey<FormState>();

  String email = "";
  String password = "";
  String error = "";
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.brown[100],
            appBar: AppBar(
              title: Text("Sign Up"),
              backgroundColor: Colors.brown[400],
              elevation: 0.0,
              actions: [
                TextButton.icon(
                    onPressed: () {
                      widget.toggleView();
                    },
                    icon: Icon(Icons.person),
                    label: Text("Sign in"))
              ],
            ),
            body: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 0.0, horizontal: 60.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(
                      height: 20.0,
                    ),
                    TextFormField(
                      decoration:
                          textInputDecoration.copyWith(hintText: "email"),
                      validator: (value) =>
                          value == null || value.isEmpty ? "Enter login" : null,
                      cursorColor: Colors.brown[400],
                      onChanged: (value) {
                        email = value;
                      },
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    TextFormField(
                      decoration:
                          textInputDecoration.copyWith(hintText: "password"),
                      validator: (val) {
                        if (val == null || val.length < 6) {
                          return "Enter password longer than or equal to 6 characters";
                        }
                        return null;
                      },
                      obscureText: true,
                      onChanged: (value) {
                        password = value;
                      },
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.pink[400],
                      ),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            loading = true;
                          });
                          dynamic result =
                              await _auth.RegisterWithEmailandPassword(
                                  email, password);
                          if (result == null) {
                            setState(() {
                              error = "Please Enter valid Credentials!";
                              setState(() {
                                loading = false;
                              });
                            });
                          } else {
                            //authentication();
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => home()));
                          }

                          // print("Email:$email  Password:$password ");
                          // Fluttertoast.showToast(
                          //     msg: "Email:$email  Password:$password ",
                          //     toastLength: Toast.LENGTH_SHORT);
                        }
                      },
                      child: Text(
                        "sign up",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    SizedBox(
                      height: 14.0,
                    ),
                    Text(
                      error,
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 14.0,
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
  }
}
