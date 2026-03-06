class Disaster {
  final String id;
  final String type;
  final double latitude;
  final double longitude;
  final double radius; // in meters
  final String message;

  Disaster({
    required this.id,
    required this.type,
    required this.latitude,
    required this.longitude,
    required this.radius,
    required this.message,
  });
}