// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, must_be_immutable, unused_local_variable, use_build_context_synchronously, prefer_interpolation_to_compose_strings

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:uber/main.dart';

import 'home_screen.dart';
import 'login_screen.dart';

class SignupScreen extends StatelessWidget {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController password = TextEditingController();
  static const route = "/signup-screen";

  SignupScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 45),
            Image.asset("assets/logo.png",
                height: 200, width: 200, alignment: Alignment.center),
            Text("Signup as the rider",
                style: TextStyle(fontSize: 24), textAlign: TextAlign.center),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(children: [
                SizedBox(height: 15),
                TextField(
                  controller: name,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      labelText: "Name",
                      labelStyle: TextStyle(
                        fontSize: 14,
                      ),
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 10,
                      )),
                  style: TextStyle(fontSize: 14.0),
                ),
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
                  controller: phone,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                      labelText: "Phone",
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
                      if (name.text.length > 4) {
                        displayMessage(
                            context, "Name must be atlest 3 character");
                      } else if (!email.text.contains("@")) {
                        displayMessage(context, "Email is not valid");
                      } else if (phone.text.isEmpty) {
                        displayMessage(
                            context, "Valid phone number is required");
                      } else if (password.text.length > 7) {
                        displayMessage(
                            context, "Password should be alteat 6 characters");
                      } else {
                        registerUser(context);
                      }
                    },
                    child: Container(
                        height: 50,
                        child: Center(
                          child: Text("Sign Up",
                              style: TextStyle(
                                fontSize: 14,
                              )),
                        )))
              ]),
            ),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      LoginScreen.route, (route) => true);
                },
                child: Text(
                  "Already have an account ? Login Here",
                  style: TextStyle(color: Colors.black),
                ))
          ],
        ),
      ),
    );
  }

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  void registerUser(BuildContext context) async {
    final User? firebaseUser = (await _firebaseAuth
            .createUserWithEmailAndPassword(
                email: email.text, password: password.text)
            .catchError((errMsg) {
      displayMessage(context, "Error" + errMsg.toString());
    }))
        .user;

    if (firebaseUser != null) {
      //registered
      Map userDataMap = {
        "name": name.text.trim(),
        "email": email.text.trim(),
        "phone": phone.text.trim(),
      };

      userRef.child(firebaseUser.uid).set(userDataMap);
      displayMessage(context, "User has been regustered");

      Navigator.of(context)
          .pushNamedAndRemoveUntil(HomeScreen.route, (route) => true);
    } else {
      //error
      displayMessage(context, "new user has not been registered");
    }
  }

  void displayMessage(BuildContext context, String msg) {
    Fluttertoast.showToast(msg: msg);
  }
}
