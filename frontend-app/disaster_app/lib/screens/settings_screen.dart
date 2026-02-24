import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool autoAlert = true;
  bool autoSOS = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Settings"), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            SwitchListTile(
              title: const Text("Enable Auto Alerts"),
              value: autoAlert,
              onChanged: (value) {
                setState(() {
                  autoAlert = value;
                });
              },
            ),

            SwitchListTile(
              title: const Text("Enable Auto SOS"),
              value: autoSOS,
              onChanged: (value) {
                setState(() {
                  autoSOS = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
