import 'dart:math';

class DistanceService {
  static double calculateDistance(
    double userLat,
    double userLng,
    double disasterLat,
    double disasterLng,
  ) {
    const double earthRadius = 6371000; // meters

    double dLat = _degToRad(disasterLat - userLat);
    double dLng = _degToRad(disasterLng - userLng);

    double a = sin(dLat / 2) * sin(dLat / 2) +
        cos(_degToRad(userLat)) *
            cos(_degToRad(disasterLat)) *
            sin(dLng / 2) *
            sin(dLng / 2);

    double c = 2 * atan2(sqrt(a), sqrt(1 - a));

    return earthRadius * c; // distance in meters
  }

  static double _degToRad(double deg) {
    return deg * (pi / 180);
  }
}