// lib/models/salesman.dart
class Salesman {
  final String id;
  final String name;
  final double latitude;
  final double longitude;

  Salesman({
    required this.id,
    required this.name,
    required this.latitude,
    required this.longitude,
  });

  factory Salesman.fromMap(Map<String, dynamic> data) {
    return Salesman(
      id: data['id'] ?? '',
      name: data['name'] ?? '',
      latitude: data['latitude'] ?? 0.0,
      longitude: data['longitude'] ?? 0.0,
    );
  }
}
