import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/disaster.dart';
import '../config/api_config.dart';

class DisasterApiService {
  static String get baseUrl => "${ApiConfig.baseUrl}/disasters";

  // 🔹 Fetch with offline support
  static Future<List<Disaster>> fetchDisasters() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));

      if (response.statusCode == 200) {
        List data = json.decode(response.body);

        // ✅ Save to local storage
        final prefs = await SharedPreferences.getInstance();
        prefs.setString('cached_disasters', json.encode(data));

        return data.map((json) => Disaster.fromJson(json)).toList();
      } else {
        throw Exception();
      }
    } catch (e) {
      // 🔴 OFFLINE MODE (fallback)
      final prefs = await SharedPreferences.getInstance();
      final String? cached = prefs.getString('cached_disasters');

      if (cached != null) {
        List data = json.decode(cached);
        return data.map((json) => Disaster.fromJson(json)).toList();
      } else {
        throw Exception("No internet and no cached data");
      }
    }
  }
}
