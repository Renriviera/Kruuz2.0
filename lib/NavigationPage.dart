import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class NavigationPage extends StatefulWidget {
  NavigationPage();
  State<StatefulWidget> createState() {
    return _NavigationPageState();
  }
}

class _NavigationPageState extends State<NavigationPage> {
  GoogleMapController mapController;
  final LatLng _center = const LatLng(45.521563, -122.677433);
  @override
  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        body: GoogleMap(
      initialCameraPosition: CameraPosition(target: _center, zoom: 11.0),
      onMapCreated: _onMapCreated,
      myLocationEnabled: true,
    ));
  }
}
