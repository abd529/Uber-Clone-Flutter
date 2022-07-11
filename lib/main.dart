// ignore_for_file: prefer_const_constructors

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:uber/screens/home_screen.dart';
import 'package:uber/screens/login_screen.dart';
import 'package:uber/screens/sigup_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

DatabaseReference userRef = FirebaseDatabase.instance.ref().child("user");

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Uber App',
      theme: ThemeData(fontFamily: "Brand-Bold", primarySwatch: Colors.yellow),
      home: SignupScreen(),
      routes: {
        LoginScreen.route: (ctx) => LoginScreen(),
        SignupScreen.route: (ctx) => SignupScreen(),
        HomeScreen.route: (ctx) => HomeScreen(),
      },
    );
  }
}
