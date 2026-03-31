import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/responsive_wrapper.dart';
import '../services/location_service.dart';
import '../services/disaster_api_service.dart';
import '../services/distance_service.dart';
import '../models/disaster.dart';
import '../models/contact.dart'; //
import 'disaster_list_screen.dart';
import 'alert_screen.dart';
import 'map_screen.dart';
import '../services/sos_service.dart';
import '../services/contact_api_service.dart';
import 'package:geocoding/geocoding.dart';
import 'admin_login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isInDanger = false;
  bool isLoadingLocation = false;
  String locationStatus = "Location not fetched";

  String userName = "";

  @override
  void initState() {
    super.initState();
    loadUser();
  }

  Future<void> loadUser() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userName = prefs.getString("userName") ?? "Guest";
    });
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    if (context.mounted) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => AdminLoginScreen()),
        (route) => false,
      );
    }
  }

  Future<void> fetchLocation() async {
    setState(() {
      isLoadingLocation = true;
    });

    final position = await LocationService.getCurrentLocation();

    if (position == null) {
      setState(() {
        locationStatus = "Unable to fetch location";
        isLoadingLocation = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Location permission denied or disabled")),
      );
      return;
    }

    try {
      final placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      ).timeout(const Duration(seconds: 3));

      final place = placemarks[0];

      String address =
          "${place.locality ?? ''}, ${place.administrativeArea ?? ''}";

      setState(() {
        locationStatus =
            "$address\nLat: ${position.latitude.toStringAsFixed(4)}, "
            "Lng: ${position.longitude.toStringAsFixed(4)}";
      });
    } catch (e) {
      setState(() {
        locationStatus =
            "Lat: ${position.latitude.toStringAsFixed(4)}, "
            "Lng: ${position.longitude.toStringAsFixed(4)}";
      });
    }

    try {
      List<Disaster> disasters = await DisasterApiService.fetchDisasters();

      for (var disaster in disasters) {
        double distance = DistanceService.calculateDistance(
          position.latitude,
          position.longitude,
          disaster.latitude,
          disaster.longitude,
        );

        if (distance <= disaster.radius) {
          setState(() {
            isInDanger = true;
            isLoadingLocation = false;
          });

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AlertScreen(
                disasterType: disaster.type,
                message: disaster.message,
              ),
            ),
          );

          return;
        }
      }

      setState(() {
        isInDanger = false;
        isLoadingLocation = false;
      });
    } catch (e) {
      setState(() {
        isLoadingLocation = false;
      });
    }
  }

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

  // ✅ FIXED SOS (WITH EMAIL)
  Future<void> triggerSOS() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final email = prefs.getString("userEmail") ?? "";

      final List<Contact> contacts = await ContactApiService.fetchContacts(
        email,
      );

      if (contacts.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("No emergency contacts found")),
        );
        return;
      }

      await SosService.triggerSOS(contacts);

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Opening SMS app...")));
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Failed to trigger SOS")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('RakshaSetu'),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Center(
              child: Text(userName, style: const TextStyle(fontSize: 14)),
            ),
          ),
          IconButton(
            tooltip: "Logout",
            onPressed: logout,
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: ResponsiveWrapper(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth > 600) {
                return Row(
                  children: [
                    Expanded(child: buildInfoSection()),
                    const SizedBox(width: 30),
                    Expanded(child: buildActionSection()),
                  ],
                );
              }

              return Column(
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
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                const Icon(Icons.location_on),
                const SizedBox(width: 10),
                Expanded(child: Text(locationStatus)),
                isLoadingLocation
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : TextButton(
                        onPressed: fetchLocation,
                        child: const Text("Fetch"),
                      ),
              ],
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
          onPressed: triggerSOS, // ✅ FIXED
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
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const MapScreen()),
            );
          },
          child: const Text("Open Disaster Map"),
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
