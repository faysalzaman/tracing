// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tracing/provider/markers_provider.dart';
import 'package:tracing/services/location_service.dart';

class UpdateLocationScreen extends StatefulWidget {
  const UpdateLocationScreen({super.key});

  @override
  State<UpdateLocationScreen> createState() => _UpdateLocationScreenState();
}

class _UpdateLocationScreenState extends State<UpdateLocationScreen> {
  final LocationService _locationService = LocationService();

  @override
  void initState() {
    super.initState();
    _fetchMarkersAndUpdate();
  }

  Future<void> _fetchMarkersAndUpdate() async {
    try {
      List<LatLng> newPositions =
          await _locationService.fetchMarkersFromFirebase();
      _updateMarkers(newPositions);
    } catch (e) {
      print('Error fetching markers: $e');
    }
  }

  void _updateMarkers(List<LatLng> newPositions) {
    Set<Marker> newMarkers = newPositions.map((position) {
      return Marker(
        markerId: MarkerId(position.toString()),
        position: position,
      );
    }).toSet();

    Provider.of<MarkerProvider>(context, listen: false).setMarkers(newMarkers);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Location'),
      ),
      body: const Center(
        child: Text('Updating locations...'),
      ),
    );
  }
}
