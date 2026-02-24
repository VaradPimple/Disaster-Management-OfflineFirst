import 'package:flutter/material.dart';
import '../widgets/disaster_card.dart';

class DisasterListScreen extends StatelessWidget {
  const DisasterListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> dummyDisasters = [
      {
        "type": "Flood",
        "radius": 5.0,
        "message": "Heavy flood warning in low-lying areas.",
      },
      {
        "type": "Earthquake",
        "radius": 10.0,
        "message": "Seismic activity detected nearby.",
      },
    ];

    return Scaffold(
      appBar: AppBar(title: const Text("Nearby Disasters")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView.builder(
          itemCount: dummyDisasters.length,
          itemBuilder: (context, index) {
            final disaster = dummyDisasters[index];

            return DisasterCard(
              type: disaster["type"],
              radius: disaster["radius"],
              message: disaster["message"],
            );
          },
        ),
      ),
    );
  }
}
