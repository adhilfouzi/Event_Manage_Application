import 'package:flutter/material.dart';
import 'package:project_event/screen/Body/widget/Scaffold/app_bar.dart';
import 'package:project_event/screen/Body/widget/box/textfield_blue.dart';
import 'package:project_event/screen/Body/widget/sub/date.dart';
import 'package:project_event/screen/Body/widget/sub/status.dart';

class AddPayments extends StatelessWidget {
  AddPayments({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        actions: [
          AppAction(icon: Icons.done, onPressed: () {}),
        ],
        titleText: 'Add Payments',
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Column(children: [
          TextFieldBlue(textcontent: 'Name', controller: _pnameController),
          TextFieldBlue(textcontent: 'Amount', controller: _budgetController),
          TextFieldBlue(textcontent: 'Note', controller: _noteController),
          StatusBar(
            textcontent1: 'Pending',
            textcontent2: 'Paid',
            onStatusChange: (bool status) {
              _statusController.text = status.toString();
            },
          ),
          Date(
            controller: _dateController,
          )
        ]),
      ),
    );
  }

  final _statusController = TextEditingController();
  final _pnameController = TextEditingController();
  final _budgetController = TextEditingController();
  final _noteController = TextEditingController();
  final _dateController = TextEditingController();
}
