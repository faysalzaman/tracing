import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationService {
  // Function to fetch markers from Firebase
  Future<List<LatLng>> fetchMarkersFromFirebase() async {
    List<LatLng> markers = [];

    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('salesmen').get();
    for (var document in snapshot.docs) {
      double latitude = document['latitude'];
      double longitude = document['longitude'];
      markers.add(LatLng(latitude, longitude));
    }

    return markers;
  }
}
