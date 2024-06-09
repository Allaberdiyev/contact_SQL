import 'dart:math';

import 'package:contacts_with_sqlite/controllers/contacts_controller.dart';
import 'package:flutter/material.dart';

class ContactsScreen extends StatefulWidget {
  const ContactsScreen({super.key});

  @override
  State<ContactsScreen> createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {
  final contactsController = ContactsController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 187, 187, 187),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 187, 187, 187),
        automaticallyImplyLeading: false,
        title: SizedBox(
          height: 50,
          child: TextField(
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.search),
              hintText: "Search contacts",
              hintStyle: const TextStyle(height: 1.3),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),
        ),
      ),
      body: FutureBuilder(
          future: contactsController.list,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            }
            if (!snapshot.hasData) {
              return const Center(
                child: Text("No information"),
              );
            }
            final contacts = snapshot.data;
            return contacts == null || contacts.isEmpty
                ? const Center(
                    child: Text("No contacts"),
                  )
                : ListView.builder(
                    itemCount: contacts.length,
                    padding: const EdgeInsets.all(15),
                    itemBuilder: (context, index) {
                      final contact = contacts[index];
                      return ListTile(
                        onTap: () {
                          Navigator.pushNamed(context, '/info',
                              arguments: contact);
                        },
                        leading: CircleAvatar(
                          backgroundColor: Colors.primaries[
                              Random().nextInt(Colors.primaries.length)],
                          child: Text(
                            contact.firstName[0].toUpperCase(),
                            style: const TextStyle(
                              fontSize: 22,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        title: Text("${contact.firstName} ${contact.lastName}"),
                      );
                    },
                  );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/create',
            arguments: contactsController),
        child: const Icon(Icons.add),
      ),
    );
  }
}
