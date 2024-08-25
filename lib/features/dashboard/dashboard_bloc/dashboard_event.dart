import 'package:equatable/equatable.dart';

sealed class DashboardEvent extends Equatable {
  const DashboardEvent();

  @override
  List<Object> get props => [];
}

class InitRequested extends DashboardEvent {
  const InitRequested();
}

class ContactRemoved extends DashboardEvent {
  final int id;

  const ContactRemoved({required this.id});
}
