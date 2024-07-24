import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MarkerProvider with ChangeNotifier {
  Set<Marker> _markers = {};

  Set<Marker> get markers => _markers;

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
