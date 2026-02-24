import 'package:flutter/material.dart';
import '../widgets/sos_button.dart';
import '../widgets/network_status_indicator.dart';
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
      appBar: AppBar(
        title: const Text('Disaster Management'),
        centerTitle: true,
      ),
      body: ResponsiveWrapper(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // 🔹 Network Status Indicator
              NetworkStatusIndicator(isOnline: isOnline),

              const SizedBox(height: 20),

              // 🔹 Dynamic Status Card
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: isInDanger ? Colors.red[100] : Colors.green[100],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  isInDanger ? "Status: DANGER" : "Status: SAFE",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: isInDanger ? Colors.red : Colors.green,
                  ),
                ),
              ),

              const SizedBox(height: 30),

              // 🔹 SOS Button
              SOSButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("SOS Triggered")),
                  );
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

              // 🔹 Simulate Alert
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                onPressed: simulateDanger,
                child: const Text("Simulate Alert"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
