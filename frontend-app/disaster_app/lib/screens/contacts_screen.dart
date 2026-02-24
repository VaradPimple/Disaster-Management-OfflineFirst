import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/contact.dart';

class ContactsScreen extends StatefulWidget {
  const ContactsScreen({super.key});

  @override
  State<ContactsScreen> createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {
  List<Contact> contacts = [];

  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadContacts();
  }

  Future<void> saveContacts() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> contactList = contacts
        .map(
          (contact) =>
              jsonEncode({'name': contact.name, 'phone': contact.phone}),
        )
        .toList();

    await prefs.setStringList('contacts', contactList);
  }

  Future<void> loadContacts() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? contactList = prefs.getStringList('contacts');

    if (contactList != null) {
      setState(() {
        contacts = contactList.map((item) {
          final decoded = jsonDecode(item);
          return Contact(name: decoded['name'], phone: decoded['phone']);
        }).toList();
      });
    }
  }

  void addContact() {
    if (nameController.text.isEmpty || phoneController.text.isEmpty) return;

    setState(() {
      contacts.add(
        Contact(name: nameController.text, phone: phoneController.text),
      );
    });

    saveContacts();

    nameController.clear();
    phoneController.clear();
    Navigator.pop(context);
  }

  void deleteContact(int index) {
    setState(() {
      contacts.removeAt(index);
    });

    saveContacts();
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
                  subtitle: Text(contact.phone),
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
