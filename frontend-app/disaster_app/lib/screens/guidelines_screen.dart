import 'package:flutter/material.dart';
import 'disaster_guideline_detail_screen.dart';

class GuidelinesScreen extends StatelessWidget {
  const GuidelinesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Safety Guidelines"), centerTitle: true),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 500),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                buildGuidelineButton(
                  context,
                  "Flood",
                  Icons.water,
                  Colors.blue,
                ),

                buildGuidelineButton(
                  context,
                  "Earthquake",
                  Icons.public,
                  Colors.brown,
                ),

                buildGuidelineButton(
                  context,
                  "Cyclone",
                  Icons.air,
                  Colors.grey,
                ),

                buildGuidelineButton(
                  context,
                  "Volcano",
                  Icons.local_fire_department,
                  Colors.red,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildGuidelineButton(
    BuildContext context,
    String title,
    IconData icon,
    Color color,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          padding: const EdgeInsets.symmetric(vertical: 18),
        ),
        icon: Icon(icon, size: 28),
        label: Text(title, style: const TextStyle(fontSize: 18)),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  DisasterGuidelineDetailScreen(disasterType: title),
            ),
          );
        },
      ),
    );
  }
}
