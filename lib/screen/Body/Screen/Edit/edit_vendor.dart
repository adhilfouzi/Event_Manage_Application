import 'package:flutter/material.dart';
import 'package:project_event/screen/Body/Screen/Add/add_payments.dart';
import 'package:project_event/screen/Body/widget/List/dropdowncategory.dart';
import 'package:project_event/screen/Body/widget/Scaffold/app_bar.dart';
import 'package:project_event/screen/Body/widget/box/textfield_blue.dart';
import 'package:project_event/screen/Body/widget/sub/contact.dart';
import 'package:project_event/screen/Body/widget/sub/paymentbar.dart';
import 'package:project_event/screen/Body/widget/sub/payments.dart';

class EditVendor extends StatelessWidget {
  EditVendor({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        actions: [
          AppAction(icon: Icons.contacts, onPressed: () {}),
          AppAction(icon: Icons.delete, onPressed: () {}),
          AppAction(icon: Icons.done, onPressed: () {}),
        ],
        titleText: 'Add Task',
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10.0),
        child: Column(children: [
          TextFieldBlue(textcontent: 'Name', controller: _nameController),
          CategoryDown(
            onCategorySelected: (String value) {
              _categoryController.text = value;
            },
          ),
          TextFieldBlue(textcontent: 'Note', controller: _noteController),
          TextFieldBlue(
              textcontent: 'Estimatrd Amount', controller: _budgetController),
          PaymentsBar(),
          Contact(acontroller: _acontroller, econtroller: _econtroller),
          Payments(goto: AddPayments()),
        ]),
      ),
    );
  }

  final _nameController = TextEditingController();
  final _categoryController = TextEditingController();
  final _noteController = TextEditingController();
  final _acontroller = TextEditingController();
  final _econtroller = TextEditingController();
  final _budgetController = TextEditingController();
}
