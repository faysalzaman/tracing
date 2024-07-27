import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart'; // For user authentication
import 'package:flutter/material.dart';
import 'package:location/location.dart';

class LocationSender extends StatefulWidget {
  const LocationSender({super.key});

  @override
  State<LocationSender> createState() => _LocationSenderState();
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
    _initializeUser();
  }

  void _initializeUser() async {
    User? user = _auth.currentUser;
    if (user != null) {
      _userId = user.uid;
      _location.onLocationChanged.listen((LocationData locationData) {
        _currentLocation = locationData;
        _sendLocationToServer(_currentLocation);
      });
    } else {
      // Handle user not logged in scenario
    }
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
      // print('Error sending location to server: $e');
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
