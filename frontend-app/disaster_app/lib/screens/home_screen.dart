import 'package:flutter/material.dart';
import '../widgets/responsive_wrapper.dart';
import 'disaster_list_screen.dart';
import 'alert_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isOnline = false;
  bool isInDanger = false;

  void simulateDanger() {
    setState(() {
      isInDanger = true;
    });

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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('RakshaSetu')),
      body: ResponsiveWrapper(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: LayoutBuilder(
            builder: (context, constraints) {
              // If laptop width → show side by side
              if (constraints.maxWidth > 600) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: buildActionSection()),
                    const SizedBox(width: 30),
                    Expanded(child: buildInfoSection()),
                  ],
                );
              }

              // Mobile layout
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  buildInfoSection(),
                  const SizedBox(height: 30),
                  buildActionSection(),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget buildInfoSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: isInDanger
                ? Colors.red.withOpacity(0.08)
                : Colors.green.withOpacity(0.08),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Icon(
                isInDanger ? Icons.warning : Icons.verified,
                size: 40,
                color: isInDanger ? Colors.red : Colors.green,
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Text(
                  isInDanger ? "Status: DANGER" : "Status: SAFE",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: isInDanger ? Colors.red : Colors.green,
                  ),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 20),

        Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Padding(
            padding: EdgeInsets.all(20),
            child: Text(
              "RakshaSetu provides offline-first disaster alerts, "
              "location-based risk detection, and emergency SOS support.",
              style: TextStyle(fontSize: 16),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildActionSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ElevatedButton(
          onPressed: () {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(const SnackBar(content: Text("SOS Triggered")));
          },
          child: const Text("Trigger SOS"),
        ),

        const SizedBox(height: 20),

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

        OutlinedButton(
          onPressed: simulateDanger,
          child: const Text("Simulate Alert"),
        ),
      ],
    );
  }
}
