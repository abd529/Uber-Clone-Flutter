// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, unused_local_variable, prefer_interpolation_to_compose_strings, must_be_immutable, use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:uber/main.dart';
import 'package:uber/screens/sigup_screen.dart';
import 'package:uber/widgets/progress.dart';

import 'home_screen.dart';

class LoginScreen extends StatelessWidget {
  static const route = "login-screen";

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 45),
            Image.asset("assets/logo.png",
                height: 200, width: 200, alignment: Alignment.center),
            Text("Login as the rider",
                style: TextStyle(fontSize: 24), textAlign: TextAlign.center),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(children: [
                SizedBox(height: 15),
                TextField(
                  controller: email,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                      labelText: "Email",
                      labelStyle: TextStyle(
                        fontSize: 14,
                      ),
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 10,
                      )),
                  style: TextStyle(fontSize: 14.0),
                ),
                SizedBox(height: 1),
                TextField(
                  controller: password,
                  obscureText: true,
                  decoration: InputDecoration(
                      labelText: "Password",
                      labelStyle: TextStyle(
                        fontSize: 14,
                      ),
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 10,
                      )),
                  style: TextStyle(fontSize: 14.0),
                ),
                SizedBox(height: 14),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.yellow,
                      onPrimary: Colors.black,
                    ),
                    onPressed: () {
                      loginUser(context);
                    },
                    child: Container(
                        height: 50,
                        child: Center(
                          child: Text("Login",
                              style: TextStyle(
                                fontSize: 14,
                              )),
                        )))
              ]),
            ),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      SignupScreen.route, (route) => true);
                },
                child: Text(
                  "Don't have an account? Register Here",
                  style: TextStyle(color: Colors.black),
                ))
          ],
        ),
      ),
    );
  }

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  void loginUser(BuildContext context) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Progress("Athenticating");
        });

    try {
      UserCredential userCredential =
          await _firebaseAuth.signInWithEmailAndPassword(
              email: email.text, password: password.text);
      final User? firebaseUser = userCredential.user;
      if (firebaseUser != null) {
        final DatabaseEvent event =
            await userRef.child(firebaseUser.uid).once();
        if (event.snapshot.value != null) {
          Navigator.pushNamedAndRemoveUntil(
              context, HomeScreen.route, (route) => false);
          displayMessage(
            context,
            "Login successful",
          );
        } else {
          Navigator.of(context).pop();
          displayMessage(
              context, "No records exist. Please create new account");
          await _firebaseAuth.signOut();
        }
      } else {
        Navigator.of(context).pop();
        displayMessage(context, "Error: Cannot be signed in");
      }
    } catch (e) {
      Navigator.of(context).pop();
      displayMessage(context, e.toString());
    }
  }

  Widget displayMessage(BuildContext context, String msg) {
    return SnackBar(content: Text(msg));
  }
}
