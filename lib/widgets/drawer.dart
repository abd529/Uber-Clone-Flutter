// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace

import 'package:flutter/material.dart';

class DrawerU extends StatelessWidget {
  const DrawerU({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
            child: Column(
          children: [
            DrawerHeader(
              child: Row(
                children: [
                  Image.asset(
                    "assets/user_icon.png",
                    height: 65,
                    width: 65,
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Abdullah Ayaz",
                        style: TextStyle(fontSize: 18),
                      ),
                      Text("Visit Profie")
                    ],
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.history),
              title: Text("History"),
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text("Visit Profile"),
            ),
            ListTile(
              leading: Icon(Icons.info),
              title: Text("About"),
            ),
          ],
        )),
      ],
    );
  }
}
