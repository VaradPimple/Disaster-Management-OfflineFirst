import 'package:flutter/material.dart';
import '../widgets/sos_button.dart';

class AlertScreen extends StatelessWidget {
  final String disasterType;
  final String message;

  const AlertScreen({
    super.key,
    required this.disasterType,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red[50],
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text("⚠ ALERT"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 20),

            Icon(
              Icons.warning_amber_rounded,
              size: 100,
              color: Colors.red[700],
            ),

            const SizedBox(height: 20),

            Text(
              disasterType,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),

            const SizedBox(height: 20),

            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 18),
            ),

            const Spacer(),

            SOSButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Emergency SOS Sent")),
                );
              },
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
