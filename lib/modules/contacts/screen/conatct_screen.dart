import 'package:digital_lync/modules/contacts/components/contact_details_screen.dart';
import 'package:digital_lync/modules/contacts/components/contacts_list.dart';
import 'package:digital_lync/modules/contacts/provider/contact_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<ContactProvider>(builder: (context, value, _) {
        return value.isSelected
            ? const ContactListScreen()
            : const ContactDetailsScreen();
      }),
    );
  }
}
