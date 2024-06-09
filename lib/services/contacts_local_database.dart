import 'package:contacts_with_sqlite/models/contact.dart';
import 'package:contacts_with_sqlite/services/local_database.dart';
import 'package:flutter/foundation.dart';

class ContactsLocalDatabase {
  final _localDatabase = LocalDatabase();
  final _tableName = "contacts";

  Future<List<Contact>> getContacts() async {
    final db = await _localDatabase.database;
    final rows = await db.query(_tableName);

    List<Contact> contacts = [];
    for (var row in rows) {
      contacts.add(Contact.fromMap(row));
    }
    return contacts;
  }

  Future<void> addContact(
    String firstName,
    String lastName,
    int phoneNumber,
  ) async {
    final db = await _localDatabase.database;

    try {
      db.insert(_tableName, {
        "first_name": firstName,
        "last_name": lastName,
        "phone_number": phoneNumber,
      });
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<void> editContact(int id, Map<String, dynamic> contact) async {
    final db = await _localDatabase.database;
    await db.update(_tableName, contact, where: "id = ?", whereArgs: [id]);
  }

  Future<void> deleteNote(int id) async {
    final db = await _localDatabase.database;
    await db.delete(_tableName, where: "id = ?", whereArgs: [id]);
  }
}
