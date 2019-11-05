import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class NavigationPage extends StatefulWidget {
  final latitude;
  final longitude;
  NavigationPage({this.latitude, this.longitude});
  State<StatefulWidget> createState() {
    return _NavigationPageState();
  }
}

class _NavigationPageState extends State<NavigationPage> {
  GoogleMapController mapController;
  bool hasPermission = false;
  Location location = Location();
  LatLng _center = LatLng(40.730610, -73.935242); //,

  void _onMapCreated(GoogleMapController controller) {
    location.onLocationChanged().listen((location) async {
      print(location.latitude);
      if (location.latitude != _center.latitude ||
          location.longitude != _center.longitude) {
        print(_center.latitude);
        setState(() {
          print('THERE!!!');
          _center = LatLng(
            location.latitude, // 37.4219983
            location.longitude, // -122.084
          );
//          mapController.animateCamera(
//            CameraUpdate.newCameraPosition(
//              CameraPosition(
//                target: LatLng(
//                  _center.latitude,
//                  _center.longitude,
//                ),
//                zoom: 20.0,
//              ),
//            ),
//          );
        });
      }
      setState(() {
        mapController = controller;
      });
    });
  }

//  Future<LatLng> _getLocation() async {
//    var currentLocation;
//    var answer;
//    try {
//      currentLocation = await location.getLocation();
//      answer = LatLng(currentLocation.latitude, currentLocation.longitude);
//    } catch (e) {
//      answer = null;
//    }
//
//    return answer;
//  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GoogleMap(
      initialCameraPosition: CameraPosition(
          target: LatLng(widget.latitude, widget.longitude), zoom: 11.0),
      onMapCreated: _onMapCreated,
      myLocationEnabled: true,
    );
  }
}
