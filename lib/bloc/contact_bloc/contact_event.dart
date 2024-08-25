import 'package:equatable/equatable.dart';

import '../../local_database/models/contact_model.dart';

sealed class ContactEvent extends Equatable {
  const ContactEvent();

  @override
  List<Object> get props => [];
}

class InitRequested extends ContactEvent {
  const InitRequested();
}

class ContactRemoved extends ContactEvent {
  final int id;

  const ContactRemoved({required this.id});
}

class ContactCreated extends ContactEvent {
  final String phoneNumber;
  final String firstName;
  final String? lastName;
  final String? streetAddress1;
  final String? streetAddress2;
  final String? city;
  final String? state;
  final String? zipCode;

  const ContactCreated({
    required this.phoneNumber,
    required this.firstName,
    this.lastName,
    this.streetAddress1,
    this.streetAddress2,
    this.city,
    this.state,
    this.zipCode,
  });
}

class ContactUpdated extends ContactEvent {
  final Contact contact;

  const ContactUpdated({required this.contact});
}
