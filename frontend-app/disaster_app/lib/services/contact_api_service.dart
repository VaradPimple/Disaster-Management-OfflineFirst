import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/contact.dart';
import '../config/api_config.dart';

class ContactApiService {
  static String get baseUrl => "${ApiConfig.baseUrl}/contacts";

  // ✅ GET contacts by user
  static Future<List<Contact>> fetchContacts(String email) async {
    final response = await http.get(Uri.parse("$baseUrl/user/$email"));

    if (response.statusCode == 200) {
      List data = json.decode(response.body);
      return data.map((json) => Contact.fromJson(json)).toList();
    } else {
      throw Exception("Failed to load contacts");
    }
  }

  // ✅ ADD contact
  static Future<void> addContact(Contact contact) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {"Content-Type": "application/json"},
      body: json.encode(contact.toJson()),
    );

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception("Failed to add contact");
    }
  }

  // ✅ DELETE contact
  static Future<void> deleteContact(int id) async {
    final response = await http.delete(Uri.parse("$baseUrl/$id"));

    if (response.statusCode != 200) {
      throw Exception("Failed to delete contact");
    }
  }
}
