import 'package:flutter/material.dart';
import 'package:project_event/Database/model/Budget_Model/budget_model.dart';
import 'package:project_event/screen/Body/widget/List/paydropdown.dart';
import 'package:project_event/screen/Body/widget/Scaffold/app_bar.dart';
import 'package:project_event/screen/Body/widget/box/textfield_blue.dart';
import 'package:project_event/screen/Body/widget/sub/date.dart';

class AddPayments extends StatelessWidget {
  AddPayments({
    super.key,
  });
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
            PayDown(onChanged: (String? status) {
              _payController.text = status ?? 'Budget';
            }),
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

  final TextEditingController _pnameController = TextEditingController();
  final TextEditingController _budgetController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _payController = TextEditingController();

  Future<void> addPaymentclick(mtx) async {
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      final pname = _pnameController.text;
      final amount = _budgetController.text;
      final note = _noteController.text;
      final date = _dateController.text;
      var paymentmodel = _payController.text;

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
