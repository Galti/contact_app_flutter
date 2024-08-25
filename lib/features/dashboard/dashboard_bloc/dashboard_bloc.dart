import 'package:contact_app_flutter/main.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../enums/loadable_bloc_status.dart';
import 'dashboard_event.dart';
import 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc() : super(const DashboardState()) {
    on<InitRequested>(_onInitRequested);
    on<ContactRemoved>(_onContactRemoved);
  }

  Future<void> _onInitRequested(
    InitRequested event,
    Emitter<DashboardState> emit,
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
    Emitter<DashboardState> emit,
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
}
