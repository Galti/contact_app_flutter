import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../enums/loadable_bloc_status.dart';
import '../../router_config.dart';
import '../../widgets/contact_list_item.dart';
import 'dashboard_bloc/dashboard_bloc.dart';
import 'dashboard_bloc/dashboard_event.dart';
import 'dashboard_bloc/dashboard_state.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contacts'),
      ),
      body: BlocProvider(
        create: (context) => DashboardBloc()
          ..add(
            const InitRequested(),
          ),
        child: BlocBuilder<DashboardBloc, DashboardState>(
          builder: (context, state) {
            return state.status != LoadableBlocStatus.success
                ? const Center(
                    child: CircularProgressIndicator.adaptive(),
                  )
                : SingleChildScrollView(
                    child: Column(
                      children: state.contacts
                          .map(
                            (c) => ContactListItem(
                              contact: c,
                              onDelete: () {
                                context.read<DashboardBloc>().add(ContactRemoved(id: c.id));
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Contact Removed!'),
                                  ),
                                );
                              },
                              onTap: () {
                                AddContactRoute($extra: c).push(context);
                              },
                            ),
                          )
                          .toList(),
                    ),
                  );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          const AddContactRoute().push(context);
        },
        label: const Text('Add'),
        icon: const Icon(Icons.add),
      ),
    );
  }
}
