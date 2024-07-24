import 'package:flutter/material.dart';
import 'package:tracing/location_sender.dart';
import 'package:tracing/screens/map_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
      ),
      body: Center(
        child: Column(
          children: [
            Text('Welcome to the home screen!'),
            // two buttons

            // one to navigate to the location sender screen
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return const LocationSender();
                    },
                  ),
                );
              },
              child: const Text('Location Sender'),
            ),

            // one to navigate to the Map screen
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return MapScreen();
                    },
                  ),
                );
              },
              child: const Text('Map Screen'),
            ),
          ],
        ),
      ),
    );
  }
}
