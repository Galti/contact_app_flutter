import 'package:flutter/material.dart';

import '../local_database/models/contact_model.dart';

class ContactListItem extends StatelessWidget {
  final Contact contact;
  final VoidCallback onDelete;
  final VoidCallback onTap;

  const ContactListItem({
    super.key,
    required this.contact,
    required this.onDelete,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(contact.contactId),
      onDismissed: (_) {
        onDelete();
      },
      background: Container(color: Colors.red),
      child: ListTile(
        onTap: onTap,
        leading: CircleAvatar(
          backgroundColor: Colors.blueAccent,
          child: Text(
            contact.firstName[0],
            style: const TextStyle(color: Colors.white, fontSize: 22),
          ),
        ),
        title: Text(
          '${contact.firstName} ${contact.lastName}',
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
