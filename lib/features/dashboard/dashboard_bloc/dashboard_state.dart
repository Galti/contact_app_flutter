import 'package:equatable/equatable.dart';

import '../../../../enums/loadable_bloc_status.dart';
import '../../../local_database/models/contact_model.dart';

class DashboardState extends Equatable {
  final LoadableBlocStatus status;

  final List<Contact> contacts;

  const DashboardState({
    this.status = LoadableBlocStatus.initial,
    this.contacts = const [],
  });

  DashboardState copyWith({
    LoadableBlocStatus? status,
    List<Contact>? contacts,
  }) {
    return DashboardState(
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
