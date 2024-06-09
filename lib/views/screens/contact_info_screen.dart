import 'package:contacts_with_sqlite/controllers/contacts_controller.dart';
import 'package:contacts_with_sqlite/models/contact.dart';
import 'package:flutter/material.dart';

class ContactInfoScreen extends StatefulWidget {
  final Contact contact;
  const ContactInfoScreen({super.key, required this.contact});

  @override
  State<ContactInfoScreen> createState() => _ContactInfoScreenState();
}

class _ContactInfoScreenState extends State<ContactInfoScreen> {
  final contactsController = ContactsController();

  void deleteContact(Contact contact) async {
    final response = await showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: const Text(
              "Delete",
              style: TextStyle(fontSize: 17),
            ),
            content: Text(
              "are you want delete ${contact.firstName} ? ",
              style: TextStyle(fontSize: 15),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context, false);
                },
                child: const Text(
                  "Cancel",
                  style: TextStyle(color: Color.fromARGB(255, 207, 0, 0)),
                ),
              ),
              FilledButton(
                onPressed: () {
                  Navigator.pop(context, true);
                },
                child: const Text("Yes"),
              )
            ],
          );
        });

    if (response) {
      await contactsController.deleteContact(contact.id);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 225, 224, 224),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 227, 227, 227),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.edit,
              color: Color.fromARGB(255, 0, 57, 201),
            ),
          ),
          IconButton(
            onPressed: () => deleteContact(widget.contact),
            icon: const Icon(
              Icons.delete,
              color: Color.fromARGB(255, 201, 20, 0),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          CircleAvatar(
            backgroundColor: Color.fromARGB(255, 151, 151, 151),
            radius: 70,
            child: Text(
              widget.contact.firstName[0].toUpperCase(),
              style: const TextStyle(
                  fontSize: 70, color: Color.fromARGB(255, 0, 0, 0)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30),
            child: Text(
              "${widget.contact.firstName} ${widget.contact.lastName}",
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 100,
                width: MediaQuery.of(context).size.width * 0.3,
                child: const Column(
                  children: [
                    CircleAvatar(
                      backgroundColor: Color.fromARGB(255, 171, 171, 171),
                      radius: 25,
                      child: Icon(Icons.phone),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Call",
                      style: TextStyle(fontWeight: FontWeight.w500),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 100,
                width: MediaQuery.of(context).size.width * 0.3,
                child: const Column(
                  children: [
                    CircleAvatar(
                      backgroundColor: Color.fromARGB(255, 171, 171, 171),
                      radius: 25,
                      child: Icon(Icons.message),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Message",
                      style: TextStyle(fontWeight: FontWeight.w500),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 100,
                width: MediaQuery.of(context).size.width * 0.3,
                child: const Column(
                  children: [
                    CircleAvatar(
                      backgroundColor: Color.fromARGB(255, 171, 171, 171),
                      radius: 25,
                      child: Icon(Icons.video_call),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Set up",
                      style: TextStyle(fontWeight: FontWeight.w500),
                    )
                  ],
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Container(
              height: 130,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 171, 171, 171),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 18, bottom: 10),
                    child: Text(
                      "Contact info",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.call),
                    title: Text("+${widget.contact.phoneNumber.toString()}"),
                    subtitle: const Text("Mobile"),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
