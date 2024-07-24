// ignore_for_file: library_private_types_in_public_api

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:firebase_auth/firebase_auth.dart'; // For user authentication

class LocationSender extends StatefulWidget {
  const LocationSender({super.key});

  @override
  _LocationSenderState createState() => _LocationSenderState();
}

class _LocationSenderState extends State<LocationSender> {
  final Location _location = Location();
  late LocationData _currentLocation;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late String _userId;

  @override
  void initState() {
    super.initState();
    _userId = _auth.currentUser?.uid ??
        'unknown_user'; // Get the user ID from Firebase Authentication
    _location.onLocationChanged.listen((LocationData locationData) {
      _currentLocation = locationData;
      _sendLocationToServer(_currentLocation);
    });
  }

  void _sendLocationToServer(LocationData locationData) async {
    try {
      // Reference to the user's document
      DocumentReference docRef = _firestore.collection('salesmen').doc(_userId);

      // Set or update the document with the user's location data
      await docRef.set(
        {
          'latitude': locationData.latitude,
          'longitude': locationData.longitude,
          'timestamp': DateTime.now(),
        },
        SetOptions(
          merge: true,
        ),
      ); // Merge with existing data if the document exists
    } catch (e) {
      print('Error sending location to server: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Location Sender'),
      ),
      body: const Center(
        child: Text('Sending location data to server...'),
      ),
    );
  }
}
