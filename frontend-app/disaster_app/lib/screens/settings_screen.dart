import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  final bool isDarkMode;
  final Function(bool) onThemeChanged;

  const SettingsScreen({
    super.key,
    required this.isDarkMode,
    required this.onThemeChanged,
  });

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
            // 🌙 Dark Mode
            SwitchListTile(
              title: const Text("Dark Mode"),
              value: widget.isDarkMode,
              onChanged: (value) {
                widget.onThemeChanged(value);
              },
            ),

            const Divider(),

            // 🚨 Auto Alert
            SwitchListTile(
              title: const Text("Enable Auto Alerts"),
              value: autoAlert,
              onChanged: (value) {
                setState(() {
                  autoAlert = value;
                });
              },
            ),

            // 🆘 Auto SOS
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
