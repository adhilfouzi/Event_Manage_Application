import 'package:flutter/material.dart';
import 'package:project_event/Database/model/Budget_Model/budget_model.dart';
import 'package:project_event/screen/Body/widget/Scaffold/app_bar.dart';
import 'package:project_event/screen/Body/widget/box/textfield_blue.dart';
import 'package:project_event/screen/Body/widget/sub/date.dart';

class AddPayments extends StatelessWidget {
  late final PaymentModel payment1;
  AddPayments({super.key, required this.payment1});
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        actions: [
          AppAction(
              icon: Icons.done,
              onPressed: () {
                addPaymentclick(context);
                Navigator.pop(context);
              }),
        ],
        titleText: 'Add Payments',
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Form(
          key: _formKey,
          child: Column(children: [
            TextFieldBlue(
              textcontent: 'Name',
              controller: _pnameController,
              keyType: TextInputType.name,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Name is required';
                }
                return null; // Return null if the input is valid
              },
            ),
            TextFieldBlue(
              textcontent: 'Amount',
              controller: _budgetController,
              keyType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Amount is required';
                }
                return null; // Return null if the input is valid
              },
            ),
            TextFieldBlue(textcontent: 'Note', controller: _noteController),
            Date(
              controller: _dateController,
            )
          ]),
        ),
      ),
    );
  }

  final _pnameController = TextEditingController();
  final _budgetController = TextEditingController();
  final _noteController = TextEditingController();
  final _dateController = TextEditingController();

  Future<void> addPaymentclick(mtx) async {
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      final pname = _pnameController.text;
      final amount = _budgetController.text;
      final note = _noteController.text;
      final date = _dateController.text;

      payment1 =
          PaymentModel(name: pname, pyamount: amount, date: date, note: note);

      ScaffoldMessenger.of(mtx).showSnackBar(
        const SnackBar(
          content: Text("Successfully added"),
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.all(10),
          backgroundColor: Colors.greenAccent,
          duration: Duration(seconds: 2),
        ),
      );
    } else {
      ScaffoldMessenger.of(mtx).showSnackBar(
        const SnackBar(
          content: Text("Fill the  Name"),
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.all(10),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        ),
      );
    }
  }
}
