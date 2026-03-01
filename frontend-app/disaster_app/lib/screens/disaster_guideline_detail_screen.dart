import 'package:flutter/material.dart';

class DisasterGuidelineDetailScreen extends StatelessWidget {
  final String disasterType;

  const DisasterGuidelineDetailScreen({super.key, required this.disasterType});

  IconData getDisasterIcon() {
    switch (disasterType) {
      case "Flood":
        return Icons.water;
      case "Earthquake":
        return Icons.public;
      case "Cyclone":
        return Icons.air;
      case "Volcano":
        return Icons.local_fire_department;
      default:
        return Icons.warning;
    }
  }

  Color getDisasterColor() {
    switch (disasterType) {
      case "Flood":
        return Colors.blue;
      case "Earthquake":
        return Colors.brown;
      case "Cyclone":
        return Colors.grey;
      case "Volcano":
        return Colors.red;
      default:
        return Colors.orange;
    }
  }

  List<String> getGuidelines() {
    switch (disasterType) {
      case "Flood":
        return [
          "Move to higher ground immediately.",
          "Avoid walking through flood waters.",
          "Disconnect electricity supply.",
          "Keep emergency kit ready.",
        ];
      case "Earthquake":
        return [
          "Drop, Cover and Hold.",
          "Stay away from windows.",
          "Do not use elevators.",
          "Move to open area after shaking stops.",
        ];
      case "Cyclone":
        return [
          "Stay indoors and secure windows.",
          "Avoid coastal areas.",
          "Keep emergency supplies ready.",
          "Listen to official warnings.",
        ];
      case "Volcano":
        return [
          "Wear mask to avoid ash inhalation.",
          "Stay indoors.",
          "Avoid river valleys.",
          "Follow evacuation orders.",
        ];
      default:
        return ["Stay alert and follow official guidance."];
    }
  }

  @override
  Widget build(BuildContext context) {
    final guidelines = getGuidelines();
    final color = getDisasterColor();

    return Scaffold(
      appBar: AppBar(
        title: Text("$disasterType Guidelines"),
        centerTitle: true,
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                // 🔥 Top Graphic Section
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: [
                      Icon(getDisasterIcon(), size: 100, color: color),
                      const SizedBox(height: 10),
                      Text(
                        disasterType,
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: color,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 30),

                // 📘 Guidelines List
                Expanded(
                  child: ListView.builder(
                    itemCount: guidelines.length,
                    itemBuilder: (context, index) {
                      return Card(
                        elevation: 3,
                        margin: const EdgeInsets.only(bottom: 12),
                        child: ListTile(
                          leading: Icon(Icons.check_circle, color: color),
                          title: Text(
                            guidelines[index],
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
