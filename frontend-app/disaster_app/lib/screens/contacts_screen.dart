import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/contact.dart';
import '../services/contact_api_service.dart';

class ContactsScreen extends StatefulWidget {
  const ContactsScreen({super.key});

  @override
  State<ContactsScreen> createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {
  List<Contact> contacts = [];

  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController relationController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 200), loadContacts);
  }

  Future<void> loadContacts() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final email = prefs.getString("userEmail") ?? "";

      if (email.isEmpty) return;

      final data = await ContactApiService.fetchContacts(email);

      setState(() {
        contacts = data;
      });
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Failed to load contacts")));
    }
  }

  Future<void> addContact() async {
    if (nameController.text.isEmpty ||
        phoneController.text.isEmpty ||
        relationController.text.isEmpty) {
      return;
    }

    try {
      final prefs = await SharedPreferences.getInstance();
      final email = prefs.getString("userEmail") ?? "";

      await ContactApiService.addContact(
        Contact(
          name: nameController.text,
          phone: phoneController.text,
          relation: relationController.text,
          userEmail: email,
        ),
      );

      Navigator.pop(context);

      await Future.delayed(const Duration(milliseconds: 300)); // ✅ FIX

      await loadContacts();

      nameController.clear();
      phoneController.clear();
      relationController.clear();
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Failed to add contact")));
    }
  }

  Future<void> deleteContact(int index) async {
    try {
      final contact = contacts[index];

      if (contact.id != null) {
        await ContactApiService.deleteContact(contact.id!);
      }

      await loadContacts();
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Failed to delete contact")));
    }
  }

  void showAddContactDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Add Emergency Contact"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: "Name"),
              ),
              TextField(
                controller: phoneController,
                decoration: const InputDecoration(labelText: "Phone"),
                keyboardType: TextInputType.phone,
              ),
              TextField(
                controller: relationController,
                decoration: const InputDecoration(labelText: "Relation"),
              ),
            ],
          ),
          actions: [
            TextButton(onPressed: addContact, child: const Text("Add")),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Emergency Contacts"),
        centerTitle: true,
      ),
      body: contacts.isEmpty
          ? const Center(child: Text("No Contacts Added"))
          : ListView.builder(
              itemCount: contacts.length,
              itemBuilder: (context, index) {
                final contact = contacts[index];
                return ListTile(
                  title: Text(contact.name),
                  subtitle: Text("${contact.phone} • ${contact.relation}"),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => deleteContact(index),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: showAddContactDialog,
        child: const Icon(Icons.add),
      ),
    );
  }
}
