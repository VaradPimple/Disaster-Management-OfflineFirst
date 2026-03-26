import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../services/location_service.dart';
import '../services/disaster_api_service.dart';
import '../models/disaster.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng? userLocation;
  List<Disaster> disasters = [];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    final position = await LocationService.getCurrentLocation();
    final disasterData = await DisasterApiService.fetchDisasters();

    if (position != null) {
      setState(() {
        userLocation = LatLng(position.latitude, position.longitude);
        disasters = disasterData;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (userLocation == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Disaster Map")),
      body: FlutterMap(
        options: MapOptions(initialCenter: userLocation!, initialZoom: 14),
        children: [
          // 🗺️ Map tiles
          TileLayer(
            urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
            userAgentPackageName: 'com.example.disaster_app',
          ),

          // 🔴 REAL DISASTER CIRCLES (CORRECT FIX)
          CircleLayer(
            circles: disasters.map((d) {
              // limit radius for visibility
              double adjustedRadius = d.radius > 5000 ? 5000 : d.radius;

              return CircleMarker(
                point: LatLng(d.latitude, d.longitude),
                radius: adjustedRadius,
                useRadiusInMeter: true,
                color: Colors.red.withOpacity(0.3),
                borderStrokeWidth: 2,
                borderColor: Colors.red,
              );
            }).toList(),
          ),

          // 📍 Markers
          MarkerLayer(
            markers: [
              // 👤 User
              Marker(
                point: userLocation!,
                width: 80,
                height: 80,
                child: const Icon(
                  Icons.person_pin_circle,
                  size: 40,
                  color: Colors.blue,
                ),
              ),

              // ⚠️ Disasters
              ...disasters.map((d) {
                return Marker(
                  point: LatLng(d.latitude, d.longitude),
                  width: 80,
                  height: 80,
                  child: const Icon(Icons.warning, size: 35, color: Colors.red),
                );
              }).toList(),
            ],
          ),
        ],
      ),
    );
  }
}
