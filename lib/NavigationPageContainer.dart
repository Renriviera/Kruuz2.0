import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:kruuz_flutter/NavigationPage.dart';
import 'package:location/location.dart';
import 'dart:io' show Platform;

class NavigationPageContainer extends StatefulWidget {
  NavigationPageContainer();
  State<StatefulWidget> createState() {
    return _NavigationPageContainerState();
  }
}

class _NavigationPageContainerState extends State<NavigationPageContainer> {
  Location location = Location();
  bool hasPermission = false;
  LocationData position;
  double latitude;
  double longitude;
  void _askPermission() async {
//    print("HERE");
    await PermissionHandler()
        .requestPermissions([PermissionGroup.locationAlways]).then((onValue) {
      _getLocation();
//      print("WHERE");
    });
  }

  void _getLocation() async {
    print("ARE WE HERE");
    bool checkPermission =
        await location.hasPermission() && await location.serviceEnabled();

    if (Platform.isAndroid == true) {
      if (!checkPermission) {
        checkPermission = await location.requestPermission() &&
            await location.requestService();
      }
    }

    if (checkPermission) {
      position = await location
          .getLocation()
          .catchError((e) => print("Unable to find your position."));
    }
    print(position.latitude);
    setState(() {
      latitude = position.latitude;
      longitude = position.longitude;
    });
    setState(() {
      hasPermission = true;
    });
  }

  void initState() {
    _askPermission();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        body: hasPermission == false
            ? Center(child: CircularProgressIndicator())
            : NavigationPage(latitude: latitude, longitude: longitude));
  }
}
