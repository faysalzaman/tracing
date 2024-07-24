// lib/helpers/permissions_helper.dart
import 'package:permission_handler/permission_handler.dart';

class PermissionsHelper {
  static Future<void> requestLocationPermission() async {
    if (await Permission.location.request().isGranted) {
      // Permission granted
    } else {
      // Handle permission denied
    }
  }
}
