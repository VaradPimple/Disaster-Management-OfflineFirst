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
            Text("Danger Radius: $radius km"),
            const SizedBox(height: 6),
            Text(message),
          ],
        ),
      ),
    );
  }
}
