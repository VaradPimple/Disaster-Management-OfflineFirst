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

  Map<String, List<String>> getGuidelines() {
    switch (disasterType) {
      case "Flood":
        return {
          "do": [
            "Move to higher ground immediately.",
            "Disconnect electricity supply.",
            "Keep emergency kit ready.",
          ],
          "dont": [
            "Do not walk through moving water.",
            "Do not drive in flooded areas.",
            "Do not touch wet electrical equipment.",
          ],
        };

      case "Earthquake":
        return {
          "do": [
            "Drop, Cover and Hold.",
            "Stay away from windows.",
            "Move to open area after shaking stops.",
          ],
          "dont": [
            "Do not use elevators.",
            "Do not run during shaking.",
            "Do not stand near heavy objects.",
          ],
        };

      case "Cyclone":
        return {
          "do": [
            "Stay indoors.",
            "Secure windows and doors.",
            "Keep emergency supplies ready.",
          ],
          "dont": [
            "Do not go near coastal areas.",
            "Do not ignore official warnings.",
            "Do not stand under trees.",
          ],
        };

      case "Volcano":
        return {
          "do": [
            "Wear mask to avoid ash inhalation.",
            "Stay indoors.",
            "Follow evacuation orders.",
          ],
          "dont": [
            "Do not go near lava flows.",
            "Do not ignore ash fall warnings.",
            "Do not drive during heavy ash fall.",
          ],
        };

      default:
        return {
          "do": ["Stay alert and follow official guidance."],
          "dont": [],
        };
    }
  }

  @override
  Widget build(BuildContext context) {
    final guidelineMap = getGuidelines();
    final dos = guidelineMap["do"]!;
    final donts = guidelineMap["dont"]!;
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
                // Top Graphic Section
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

                Expanded(
                  child: ListView(
                    children: [
                      // DO SECTION
                      const Text(
                        "What To Do",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                      const SizedBox(height: 10),

                      ...dos.map(
                        (item) => Card(
                          child: ListTile(
                            leading: const Icon(
                              Icons.check_circle,
                              color: Colors.green,
                            ),
                            title: Text(item),
                          ),
                        ),
                      ),

                      const SizedBox(height: 25),

                      // DON'T SECTION
                      const Text(
                        "What Not To Do",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      ),
                      const SizedBox(height: 10),

                      ...donts.map(
                        (item) => Card(
                          child: ListTile(
                            leading: const Icon(
                              Icons.cancel,
                              color: Colors.red,
                            ),
                            title: Text(item),
                          ),
                        ),
                      ),
                    ],
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
