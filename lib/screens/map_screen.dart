import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:location/location.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tracing/provider/markers_provider.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController? _controller;
  final Location _location = Location();
  LatLng? _currentPosition;
  Marker? _currentPositionMarker;
  bool _isMapInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializeMap();
  }

  Future<void> _initializeMap() async {
    await _getCurrentLocation();
    await _fetchMarkersAndUpdate();
    setState(() {
      _isMapInitialized = true;
    });
  }

  Future<void> _getCurrentLocation() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await _location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await _location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await _location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await _location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    final locationData = await _location.getLocation();
    _currentPosition = LatLng(locationData.latitude!, locationData.longitude!);
    _currentPositionMarker = Marker(
      markerId: const MarkerId('currentLocation'),
      position: _currentPosition!,
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
    );
  }

  Future<void> _fetchMarkersAndUpdate() async {
    try {
      List<LatLng> newPositions = await _fetchMarkersFromFirebase();
      _updateMarkers(newPositions);
    } catch (e) {
      print('Error fetching markers: $e');
    }
  }

  Future<List<LatLng>> _fetchMarkersFromFirebase() async {
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

  void _updateMarkers(List<LatLng> newPositions) {
    Set<Marker> newMarkers = newPositions.map((position) {
      return Marker(
        markerId: MarkerId(position.toString()),
        position: position,
      );
    }).toSet();

    if (_currentPositionMarker != null) {
      newMarkers.add(_currentPositionMarker!);
    }

    Provider.of<MarkerProvider>(context, listen: false).setMarkers(newMarkers);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Salesmen Tracker'),
      ),
      body: _isMapInitialized
          ? Consumer<MarkerProvider>(
              builder: (context, markerProvider, child) {
                return GoogleMap(
                  onMapCreated: (controller) {
                    _controller = controller;
                    if (_currentPosition != null) {
                      _controller?.animateCamera(
                        CameraUpdate.newLatLngZoom(_currentPosition!, 15),
                      );
                    }
                  },
                  markers: markerProvider.markers,
                  initialCameraPosition: CameraPosition(
                    target: _currentPosition ??
                        const LatLng(
                          37.77483,
                          -122.41942,
                        ), // Default position if current position is null
                    zoom: 15,
                  ),
                  myLocationEnabled: false,
                  myLocationButtonEnabled: false,
                );
              },
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
