// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_field

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeScreen extends StatefulWidget {
  static const route = "/home";
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Completer<GoogleMapController> controllerMap = Completer();

  late GoogleMapController newMapController;

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(
              "Uber",
              style: TextStyle(color: Colors.black),
            ),
            backgroundColor: Colors.yellow[600]),
        body: Stack(
          children: [
            GoogleMap(
              mapType: MapType.normal,
              myLocationButtonEnabled: true,
              initialCameraPosition: _kGooglePlex,
              onMapCreated: (GoogleMapController controller) {
                controllerMap.complete(controller);
                newMapController = controller;
              },
            ),
            Positioned(
                right: 0,
                left: 0,
                bottom: 0,
                child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15)),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black,
                              blurRadius: 15,
                              spreadRadius: 0.5,
                              offset: Offset(0.5, 0.5))
                        ]),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Hi there!"),
                          Text(
                            "Where to?",
                            style: TextStyle(
                              fontSize: 24,
                            ),
                          ),
                          SizedBox(height: 20),
                          Padding(
                            padding: EdgeInsets.all(5),
                            child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.black,
                                          blurRadius: 5,
                                          spreadRadius: 0.3,
                                          offset: Offset(0.5, 0.5))
                                    ]),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.search,
                                        color: Colors.yellow[600],
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text("Search Drop Off")
                                    ],
                                  ),
                                )),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Divider(),
                          Row(
                            children: [
                              Icon(
                                Icons.home,
                                size: 35,
                                color: Colors.grey[400],
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Add Home",
                                      style: TextStyle(fontSize: 21)),
                                  Text("add your living home address",
                                      style: TextStyle(color: Colors.grey[400]))
                                ],
                              ),
                            ],
                          ),
                          Divider(),
                          Row(
                            children: [
                              Icon(
                                Icons.work,
                                size: 35,
                                color: Colors.grey[400],
                              ),
                              SizedBox(width: 20),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Add Work",
                                      style: TextStyle(fontSize: 21)),
                                  Text(
                                      "add your working place or office address",
                                      style: TextStyle(color: Colors.grey[400]))
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 30,
                          )
                        ],
                      ),
                    ))),
          ],
        ));
  }
}
