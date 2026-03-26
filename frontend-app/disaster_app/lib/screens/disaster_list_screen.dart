import 'package:flutter/material.dart';
import '../widgets/disaster_card.dart';
import '../services/disaster_api_service.dart';
import '../models/disaster.dart';

class DisasterListScreen extends StatefulWidget {
  const DisasterListScreen({super.key});

  @override
  State<DisasterListScreen> createState() => _DisasterListScreenState();
}

class _DisasterListScreenState extends State<DisasterListScreen> {
  late Future<List<Disaster>> disasters;

  @override
  void initState() {
    super.initState();
    disasters = DisasterApiService.fetchDisasters();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Nearby Disasters")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: FutureBuilder<List<Disaster>>(
          future: disasters,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return const Center(child: Text("Failed to load disasters"));
            }

            final disasterList = snapshot.data!;

            return ListView.builder(
              itemCount: disasterList.length,
              itemBuilder: (context, index) {
                final disaster = disasterList[index];

                return DisasterCard(
                  type: disaster.type,
                  radius: disaster.radius,
                  message: disaster.message,
                );
              },
            );
          },
        ),
      ),
    );
  }
}
