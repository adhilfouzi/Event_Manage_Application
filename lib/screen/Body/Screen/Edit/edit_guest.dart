import 'package:flutter/material.dart';
import 'package:project_event/screen/Body/Screen/Add/add_companions.dart';
import 'package:project_event/screen/Body/widget/List/dropdownsex.dart';
import 'package:project_event/screen/Body/widget/Scaffold/app_bar.dart';
import 'package:project_event/screen/Body/widget/box/textfield_blue.dart';
import 'package:project_event/screen/Body/widget/sub/compamions.dart';
import 'package:project_event/screen/Body/widget/sub/contact.dart';
import 'package:project_event/screen/Body/widget/sub/status.dart';

class EditGuest extends StatelessWidget {
  EditGuest({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        actions: [
          AppAction(icon: Icons.contacts, onPressed: () {}),
          AppAction(icon: Icons.done, onPressed: () {}),
        ],
        titleText: 'Edit Guest',
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10.0),
        child: Column(children: [
          TextFieldBlue(textcontent: 'Name', controller: _nameController),
          SexDown(onChanged: (String? status) {
            _sexController.text = status ?? 'Male';
          }),
          TextFieldBlue(textcontent: 'Note', controller: _noteController),
          StatusBar(
            onStatusChange: (bool status) {
              _statusController.text = status.toString();
            },
            textcontent1: 'Not sent',
            textcontent2: 'Invitation sent',
          ),
          Contact(acontroller: _acontroller, econtroller: _econtroller),
          Compamions(goto: AddCompanions())
        ]),
      ),
    );
  }

  final _statusController = TextEditingController();
  final _sexController = TextEditingController();
  final _nameController = TextEditingController();
  final _noteController = TextEditingController();
  final _econtroller = TextEditingController();
  final _acontroller = TextEditingController();
}
