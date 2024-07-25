// ignore_for_file: use_build_context_synchronously, no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:location/location.dart';
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

    // Update the provider with the current position marker
    Provider.of<MarkerProvider>(context, listen: false)
        .addMarker(_currentPositionMarker!);
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
                  mapType: MapType.normal,
                  buildingsEnabled: true,
                  compassEnabled: true,
                  rotateGesturesEnabled: true,
                  scrollGesturesEnabled: true,
                  trafficEnabled: true,
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
