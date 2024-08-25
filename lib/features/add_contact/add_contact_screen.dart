import 'package:contact_app_flutter/bloc/contact_bloc/contact_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../bloc/contact_bloc/contact_bloc.dart';
import '../../local_database/models/contact_model.dart';

class AddContactScreen extends StatefulWidget {
  final Contact? contact;

  const AddContactScreen({super.key, this.contact});

  @override
  State<AddContactScreen> createState() => _AddContactScreenState();
}

class _AddContactScreenState extends State<AddContactScreen> {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final str1Controller = TextEditingController();
  final str2Controller = TextEditingController();
  final cityController = TextEditingController();
  final stateController = TextEditingController();
  final zipController = TextEditingController();

  @override
  void initState() {
    super.initState();
    firstNameController.text = widget.contact?.firstName ?? '';
    lastNameController.text = widget.contact?.lastName ?? '';
    phoneNumberController.text = widget.contact?.phoneNumber ?? '';
    str1Controller.text = widget.contact?.streetAddress1 ?? '';
    str2Controller.text = widget.contact?.streetAddress2 ?? '';
    cityController.text = widget.contact?.city ?? '';
    stateController.text = widget.contact?.state ?? '';
    zipController.text = widget.contact?.zipCode ?? '';
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    phoneNumberController.dispose();
    str1Controller.dispose();
    str2Controller.dispose();
    cityController.dispose();
    stateController.dispose();
    zipController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.contact != null ? 'Edit contact' : 'Create contact'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              const SizedBox(height: 8),
              TextField(
                controller: firstNameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'First name',
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: lastNameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Last name',
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: phoneNumberController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Phone number',
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: str1Controller,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Address 1',
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: str2Controller,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Address 2',
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: cityController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'City',
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: stateController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'State',
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: zipController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'ZIP code',
                ),
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          if (widget.contact == null) {
            return handleContactCreate();
          }

          handleContactUpdate();
        },
        label: Text(widget.contact == null ? 'Create' : 'Save'),
        // icon: const Icon(Icons.add),
      ),
    );
  }

  void handleContactCreate() {
    if (firstNameController.text.isNotEmpty && phoneNumberController.text.isNotEmpty) {
      context.read<ContactBloc>().add(
            ContactCreated(
              phoneNumber: phoneNumberController.text,
              firstName: firstNameController.text,
              lastName: lastNameController.text,
              streetAddress1: str1Controller.text,
              streetAddress2: str2Controller.text,
              city: cityController.text,
              state: stateController.text,
              zipCode: zipController.text,
            ),
          );
      context.pop();
    }
  }

  void handleContactUpdate() {
    if (widget.contact != null && firstNameController.text.isNotEmpty && phoneNumberController.text.isNotEmpty) {
      final contact = widget.contact!.copyWith(
        phoneNumber: phoneNumberController.text,
        firstName: firstNameController.text,
        lastName: lastNameController.text,
        streetAddress1: str1Controller.text,
        streetAddress2: str2Controller.text,
        city: cityController.text,
        state: stateController.text,
        zipCode: zipController.text,
      );

      context.read<ContactBloc>().add(ContactUpdated(contact: contact));
      context.pop();
    }
  }
}
