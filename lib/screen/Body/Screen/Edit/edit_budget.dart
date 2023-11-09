import 'package:flutter/material.dart';
import 'package:project_event/screen/Body/Screen/Add/add_payments.dart';
import 'package:project_event/screen/Body/widget/List/dropdowncategory.dart';
import 'package:project_event/screen/Body/widget/Scaffold/app_bar.dart';
import 'package:project_event/screen/Body/widget/box/textfield_blue.dart';
import 'package:project_event/screen/Body/widget/sub/paymentbar.dart';
import 'package:project_event/screen/Body/widget/sub/payments.dart';

class EditBudget extends StatelessWidget {
  EditBudget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        actions: [
          AppAction(icon: Icons.done, onPressed: () {}),
        ],
        titleText: 'Edit Budget',
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
          // Payments(goto: AddPayments())
        ]),
      ),
    );
  }

  final _budgetController = TextEditingController();

  final _nameController = TextEditingController();
  final _categoryController = TextEditingController();
  final _noteController = TextEditingController();
}
