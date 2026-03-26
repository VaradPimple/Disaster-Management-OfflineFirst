class Disaster {
  final int id;
  final String type;
  final double latitude;
  final double longitude;
  final double radius;
  final String message;

  Disaster({
    required this.id,
    required this.type,
    required this.latitude,
    required this.longitude,
    required this.radius,
    required this.message,
  });

  factory Disaster.fromJson(Map<String, dynamic> json) {
    return Disaster(
      id: json['id'],
      type: json['type'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      radius: json['radius'],
      message: json['message'],
    );
  }
}
