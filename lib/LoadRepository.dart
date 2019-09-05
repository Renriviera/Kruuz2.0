import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';

class LoadRepository {
  Future<void> postLoad(
      String name,
      String type,
      String pickupAddress,
      String dropoffAddress,
      String status,
      DateTime pickupDate,
      DateTime dropoffDate,
      int length,
      int width,
      int height,
      int weight) async {
//    final CollectionReference loadsRef = Firestore.instance.collection('Load').add({'name': name, 'type' : type, 'pickupAddress': pickupAddress, 'dropoffAddress': dropoffAddress, 'status': open, });
  }
}
