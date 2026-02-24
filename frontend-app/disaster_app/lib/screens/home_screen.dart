import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Disaster Management')),
      body: const Center(
        child: Text(
          'Offline-First Disaster Alert System',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
