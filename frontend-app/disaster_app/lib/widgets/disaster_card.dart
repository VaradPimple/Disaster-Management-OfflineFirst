import 'package:flutter/material.dart';

class DisasterCard extends StatelessWidget {
  final String type;
  final double radius;
  final String message;

  const DisasterCard({
    super.key,
    required this.type,
    required this.radius,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    // 🔹 Convert meters → km
    final double radiusKm = radius / 1000;

    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              type,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),

            // ✅ Correct unit + formatted
            Text(
              "Danger Radius: ${radiusKm.toStringAsFixed(1)} km",
              style: const TextStyle(color: Colors.grey),
            ),

            const SizedBox(height: 6),
            Text(message),
          ],
        ),
      ),
    );
  }
}
