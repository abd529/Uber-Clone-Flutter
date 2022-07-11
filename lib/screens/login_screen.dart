// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:uber/screens/sigup_screen.dart';

class LoginScreen extends StatelessWidget {
  static const route = "login-screen";
  const LoginScreen({Key? key}) : super(key: key);

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
                    onPressed: () {},
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
}
