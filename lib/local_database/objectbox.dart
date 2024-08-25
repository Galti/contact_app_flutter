import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

import 'models/contact_model.dart';
import 'objectbox.g.dart';

/// Provides access to the ObjectBox Store throughout the app.
///
/// Create this in the apps main function.
class ObjectBox {
  /// The Store of this app.
  late final Store _store;

  /// A Box of notes.
  late final Box<Contact> _contactsBox;

  ObjectBox._create(this._store) {
    _contactsBox = Box<Contact>(_store);

    // Add some demo data if the box is empty.
    if (_contactsBox.isEmpty()) {
      _putDemoData();
    }
  }

  /// Create an instance of ObjectBox to use throughout the app.
  static Future<ObjectBox> create() async {
    // Future<Store> openStore() {...} is defined in the generated objectbox.g.dart
    final store = await openStore(
      directory: p.join((await getApplicationDocumentsDirectory()).path, "contact_box"),
    );
    return ObjectBox._create(store);
  }

  void _putDemoData() async {
    final response = await rootBundle.loadString('assets/demo_contacts.json');
    final data = await json.decode(response);
    final contacts = data.map<Contact>((c) => Contact.fromJson(c)).toList();
    _contactsBox.putManyAsync(contacts);
  }

  Stream<List<Contact>> getContacts() {
    // Query for all notes, sorted by their date.
    // https://docs.objectbox.io/queries
    final builder = _contactsBox.query();
    // Build and watch the query,
    // set triggerImmediately to emit the query immediately on listen.
    return builder
        .watch(triggerImmediately: true)
        // Map it to a list of notes to be used by a StreamBuilder.
        .map((query) => query.find());
  }

  Future<void> addContact({
    String? contactId,
    required String phoneNumber,
    required String firstName,
    String? lastName,
    String? streetAddress1,
    String? streetAddress2,
    String? city,
    String? state,
    String? zipCode,
  }) =>
      _contactsBox.putAsync(
        Contact(
          contactId: contactId ?? const Uuid().toString(),
          firstName: firstName,
          lastName: lastName,
          phoneNumber: phoneNumber,
          streetAddress1: streetAddress1,
          streetAddress2: streetAddress2,
          city: city,
          state: state,
          zipCode: zipCode,
        ),
      );

  Future<void> updateContact(Contact contact) => _contactsBox.putAsync(contact);

  Future<void> removeContact(int id) => _contactsBox.removeAsync(id);
}
