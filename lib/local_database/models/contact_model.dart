import 'package:objectbox/objectbox.dart';
import 'package:uuid/uuid.dart';

import '../objectbox.g.dart';

@Entity()
class Contact {
  @Id()
  int id;
  String contactId;
  String phoneNumber;
  String firstName;
  String? lastName;
  String? streetAddress1;
  String? streetAddress2;
  String? city;
  String? state;
  String? zipCode;

  Contact({
    this.id = 0,
    required this.contactId,
    required this.phoneNumber,
    required this.firstName,
    this.lastName,
    this.streetAddress1,
    this.streetAddress2,
    this.city,
    this.state,
    this.zipCode,
  });

  static Contact fromJson(Map<String, dynamic> json) => Contact(
        contactId: const Uuid().toString(),
        phoneNumber: json['phoneNumber'],
        firstName: json['firstName'],
        lastName: json['lastName'],
        streetAddress1: json['streetAddress1'],
        streetAddress2: json['streetAddress2'],
        city: json['city'],
        state: json['state'],
        zipCode: json['zipCode'],
      );
}
