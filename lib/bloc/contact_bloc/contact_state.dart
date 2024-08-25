import 'package:equatable/equatable.dart';

import '../../../../../enums/loadable_bloc_status.dart';
import '../../../../local_database/models/contact_model.dart';

class ContactState extends Equatable {
  final LoadableBlocStatus status;

  final List<Contact> contacts;

  const ContactState({
    this.status = LoadableBlocStatus.initial,
    this.contacts = const [],
  });

  ContactState copyWith({
    LoadableBlocStatus? status,
    List<Contact>? contacts,
  }) {
    return ContactState(
      status: status ?? this.status,
      contacts: contacts ?? this.contacts,
    );
  }

  @override
  List<Object?> get props => [
        status,
        contacts,
      ];
}
