import 'package:contacts_with_sqlite/models/contact.dart';
import 'package:contacts_with_sqlite/repositories/contacts_repository.dart';

class ContactsController {
  final contactsRepository = ContactsRepository();

  List<Contact> _list = [];

  Future<List<Contact>> get list async {
    _list = await contactsRepository.getContacts();

    return [..._list];
  }

  Future<void> addContact(
      String firstName, String lastName, int phoneNumber) async {
    await contactsRepository.addContact(firstName, lastName, phoneNumber);
  }

  Future<void> deleteContact(int id) async {
    await contactsRepository.deleteContact(id);
  }
}
