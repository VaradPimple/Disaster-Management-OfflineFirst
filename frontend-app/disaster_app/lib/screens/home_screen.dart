import 'package:flutter/material.dart';
import '../widgets/sos_button.dart';
import '../widgets/network_status_indicator.dart';
import 'disaster_list_screen.dart';
import 'alert_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Disaster Management'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 🔹 Network Status Indicator (currently hardcoded)
            const NetworkStatusIndicator(isOnline: false),

            const SizedBox(height: 20),

            // 🔹 Status Card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.green[100],
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text(
                "Status: SAFE",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
            ),

            const SizedBox(height: 30),

            // 🔹 SOS Button
            SOSButton(
              onPressed: () {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(const SnackBar(content: Text("SOS Triggered")));
              },
            ),

            const SizedBox(height: 20),

            // 🔹 View Nearby Disasters
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const DisasterListScreen(),
                  ),
                );
              },
              child: const Text("View Nearby Disasters"),
            ),

            const SizedBox(height: 20),

            // 🔹 Simulate Alert (for demo purpose)
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AlertScreen(
                      disasterType: "Flood Warning",
                      message:
                          "You are inside a high-risk flood zone. Move to higher ground immediately.",
                    ),
                  ),
                );
              },
              child: const Text("Simulate Alert"),
            ),
          ],
        ),
      ),
    );
  }
}
