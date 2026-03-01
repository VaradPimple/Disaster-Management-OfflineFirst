import 'package:flutter/material.dart';

class DisasterGuidelineDetailScreen extends StatelessWidget {
  final String disasterType;

  const DisasterGuidelineDetailScreen({super.key, required this.disasterType});

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
            child: ListView.builder(
              itemCount: guidelines.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    leading: const Icon(
                      Icons.check_circle,
                      color: Colors.green,
                    ),
                    title: Text(guidelines[index]),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
