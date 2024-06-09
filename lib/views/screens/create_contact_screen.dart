import 'package:contacts_with_sqlite/controllers/contacts_controller.dart';
import 'package:flutter/material.dart';

class CreateContactScreen extends StatefulWidget {
  final ContactsController contactsController;

  const CreateContactScreen({super.key, required this.contactsController});

  @override
  State<CreateContactScreen> createState() => _CreateContactScreenState();
}

class _CreateContactScreenState extends State<CreateContactScreen> {
  final _formKey = GlobalKey<FormState>();

  String firstName = '';
  String lastName = '';
  String phoneNumber = '';

  bool isLoading = false;

  void addContact() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      Navigator.pushNamed(context, '/');
      setState(() {
        isLoading = true;
      });
      await widget.contactsController
          .addContact(firstName, lastName, int.tryParse(phoneNumber)!);
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 215, 215, 215),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 3, 137, 50),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.close),
        ),
        title: const Text(
          "Create contact",
          style: TextStyle(fontSize: 18),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: FilledButton(
              onPressed: () {
                addContact();
              },
              child: isLoading
                  ? const SizedBox(
                      width: 13,
                      height: 13,
                      child: CircularProgressIndicator(
                        color: Color.fromARGB(255, 255, 255, 255),
                        strokeWidth: 3,
                      ),
                    )
                  : const Text(
                      "Save",
                      style: TextStyle(
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                    ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.only(bottom: 20),
                  child: CircleAvatar(
                    backgroundColor: Color.fromARGB(255, 61, 152, 0),
                    radius: 60,
                    child: Text(
                      "S",
                      style: TextStyle(fontSize: 50, color: Colors.black),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      icon: Icon(Icons.person),
                      label: Text(
                        "First name",
                        style: TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                      ),
                      border: OutlineInputBorder(),
                    ),
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.name,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Enter first name";
                      }
                      return null;
                    },
                    onSaved: (newValue) {
                      firstName = newValue ?? '';
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      icon: Icon(
                        Icons.person,
                        color: Colors.transparent,
                      ),
                      label: Text(
                        "Last name",
                        style: TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                      ),
                      border: OutlineInputBorder(),
                    ),
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.name,
                    onSaved: (newValue) {
                      lastName = newValue ?? '';
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      icon: Icon(Icons.phone),
                      label: Text(
                        "Phone",
                        style: TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                      ),
                      border: OutlineInputBorder(),
                    ),
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Enter phone number";
                      } else if (int.tryParse(value) == null) {
                        return "Phone number is not correct";
                      }
                      return null;
                    },
                    onSaved: (newValue) {
                      phoneNumber = newValue ?? '';
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
