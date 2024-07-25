import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MarkerProvider with ChangeNotifier {
  Set<Marker> _markers = {};

  Set<Marker> get markers => _markers;

  MarkerProvider() {
    _initializeMarkers();
  }

  void _initializeMarkers() {
    FirebaseFirestore.instance
        .collection('salesmen')
        .snapshots()
        .listen((snapshot) {
      Set<Marker> newMarkers = {};
      for (var document in snapshot.docs) {
        double latitude = document['latitude'];
        double longitude = document['longitude'];
        newMarkers.add(
          Marker(
            markerId: MarkerId(document.id),
            position: LatLng(latitude, longitude),
          ),
        );
      }
      _markers = newMarkers;
      notifyListeners();
    });
  }

  void setMarkers(Set<Marker> markers) {
    _markers = markers;
    notifyListeners();
  }

  void addMarker(Marker marker) {
    _markers.add(marker);
    notifyListeners();
  }

  void removeMarker(MarkerId markerId) {
    _markers.removeWhere((marker) => marker.markerId == markerId);
    notifyListeners();
  }
}
