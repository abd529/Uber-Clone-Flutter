// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_field, unused_local_variable, unused_local_variable

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uber/widgets/drawer.dart';

class HomeScreen extends StatefulWidget {
  static const route = "/home";
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Completer<GoogleMapController> controllerMap = Completer();

  late GoogleMapController newMapController;

  late Position currentPosition;
  var geoLocator = Geolocator();
  double bottomPadding = 0;

  void positionLocator() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    currentPosition = position;

    LatLng latLngPosition = LatLng(position.latitude, position.longitude);

    CameraPosition camPosition =
        CameraPosition(target: latLngPosition, zoom: 14);

    newMapController.animateCamera(CameraUpdate.newCameraPosition(camPosition));
  }

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Drawer(child: DrawerU()),
        appBar: AppBar(
            iconTheme: IconThemeData(color: Colors.black),
            title: Text(
              "Uber",
              style: TextStyle(color: Colors.black),
            ),
            backgroundColor: Colors.yellow[600]),
        body: Stack(
          children: [
            GoogleMap(
              padding: EdgeInsets.only(bottom: bottomPadding),
              mapType: MapType.normal,
              myLocationButtonEnabled: true,
              myLocationEnabled: true,
              zoomGesturesEnabled: true,
              zoomControlsEnabled: true,
              initialCameraPosition: _kGooglePlex,
              onMapCreated: (GoogleMapController controller) {
                controllerMap.complete(controller);
                newMapController = controller;
                setState(() {
                  bottomPadding = 365;
                });
                positionLocator();
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
                          Divider(),
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
