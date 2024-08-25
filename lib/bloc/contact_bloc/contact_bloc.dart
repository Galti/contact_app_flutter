import 'package:contact_app_flutter/main.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../enums/loadable_bloc_status.dart';
import 'contact_event.dart';
import 'contact_state.dart';

class ContactBloc extends Bloc<ContactEvent, ContactState> {
  ContactBloc() : super(const ContactState()) {
    on<InitRequested>(_onInitRequested);
    on<ContactRemoved>(_onContactRemoved);
    on<ContactCreated>(_onContactCreated);
    on<ContactUpdated>(_onContactUpdated);
  }

  Future<void> _onInitRequested(
    InitRequested event,
    Emitter<ContactState> emit,
  ) async {
    emit(state.copyWith(status: LoadableBlocStatus.loading));
    try {
      final contacts = await objectbox.getContacts().first;
      await Future.delayed(const Duration(seconds: 1));
      emit(
        state.copyWith(
          status: LoadableBlocStatus.success,
          contacts: contacts,
        ),
      );
    } catch (e) {
      // TODO handle if needed
    }
  }

  Future<void> _onContactRemoved(
    ContactRemoved event,
    Emitter<ContactState> emit,
  ) async {
    // emit(state.copyWith(status: LoadableBlocStatus.loading));
    try {
      final hasRemoved = await objectbox.removeContact(event.id);
      await Future.delayed(const Duration(seconds: 1));

      if (hasRemoved) {
        final contacts = await objectbox.getContacts().first;
        emit(
          state.copyWith(
            status: LoadableBlocStatus.success,
            contacts: contacts,
          ),
        );
      }
    } catch (e) {
      // TODO handle if needed
    }
  }

  Future<void> _onContactCreated(
    ContactCreated event,
    Emitter<ContactState> emit,
  ) async {
    emit(state.copyWith(status: LoadableBlocStatus.loading));
    try {
      await objectbox.addContact(
        phoneNumber: event.phoneNumber,
        firstName: event.firstName,
        lastName: event.lastName,
        streetAddress1: event.streetAddress1,
        streetAddress2: event.streetAddress2,
        city: event.city,
        state: event.state,
        zipCode: event.zipCode,
      );
      await Future.delayed(const Duration(seconds: 2));

      final contacts = await objectbox.getContacts().first;
      emit(
        state.copyWith(
          status: LoadableBlocStatus.success,
          contacts: contacts,
        ),
      );
    } catch (e) {
      // TODO handle if needed
    }
  }

  Future<void> _onContactUpdated(
    ContactUpdated event,
    Emitter<ContactState> emit,
  ) async {
    emit(state.copyWith(status: LoadableBlocStatus.loading));
    try {
      await objectbox.updateContact(event.contact);
      await Future.delayed(const Duration(seconds: 2));

      final contacts = await objectbox.getContacts().first;
      emit(
        state.copyWith(
          status: LoadableBlocStatus.success,
          contacts: contacts,
        ),
      );
    } catch (e) {
      // TODO handle if needed
    }
  }
}
