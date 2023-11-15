import 'package:flutter/material.dart';
import 'package:project_event/Database/functions/fn_budgetmodel.dart';
import 'package:project_event/Database/functions/fn_vendormodel.dart';
import 'package:project_event/Database/model/Budget_Model/budget_model.dart';
import 'package:project_event/screen/Body/widget/List/paydropdown.dart';
import 'package:project_event/screen/Body/widget/Scaffold/app_bar.dart';
import 'package:project_event/screen/Body/widget/box/textfield_blue.dart';
import 'package:project_event/screen/Body/widget/sub/date.dart';
import 'package:project_event/screen/Body/widget/sub/time.dart';

class AddPayments extends StatefulWidget {
  final int eventID;

  const AddPayments({
    super.key,
    required this.eventID,
  });

  @override
  State<AddPayments> createState() => _AddPaymentsState();
}

class _AddPaymentsState extends State<AddPayments> {
  final _formKey = GlobalKey<FormState>();
  List searchResults = [];

  @override
  Widget build(BuildContext context) {
    _paytypeController.text = "Budget";
    refreshBudgetData(widget.eventID);
    refreshVendorData(widget.eventID);
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
              textcontent: 'Receiver Name',
              controller: _pnameController,
              keyType: TextInputType.name,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Name is required';
                }
                return null;
              },
            ),
            PayDown(onChanged: (String? status) {
              _paytypeController.text = status ?? 'Budget';
              searchResults = [];
              setState(() {});
            }),
            TextFieldBlue(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Item Name is required';
                }
                return null;
              },
              textcontent: 'Item Name',
              controller: searchController,
              onChanged: (p0) {
                searchResults.clear();

                raylist.value == 'Budget'
                    ? searchResults = budgetlist.value
                        .where((budgetModel) => budgetModel.name
                            .toLowerCase()
                            .contains(p0.toLowerCase()))
                        .toList()
                    : searchResults = vendortlist.value
                        .where((element) => element.name
                            .toLowerCase()
                            .contains(p0.toLowerCase()))
                        .toList();
                setState(() {
                  // payid = searchResults[index].name;
                });
              },
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              constraints: const BoxConstraints(maxHeight: 300, minHeight: 0),
              child: ListView.builder(
                shrinkWrap: true,
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () {
                    searchController.text = searchResults[index].name;

                    searchResults = [];
                    setState(() {
                      payid = searchResults[index].id;
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.all(5),
                    padding: const EdgeInsets.all(10),
                    child: Text(searchResults[index].name),
                  ),
                ),
                itemCount: searchResults.length,
              ),
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
            ),
            Time(
              controller: _timeController,
            )
          ]),
        ),
      ),
    );
  }

  final TextEditingController _pnameController = TextEditingController();
  final TextEditingController _paytypeController = TextEditingController();
  final TextEditingController searchController = TextEditingController();
  final TextEditingController _budgetController = TextEditingController();

  final TextEditingController _noteController = TextEditingController();

  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  late int payid;
  //final TextEditingController _categoryController = TextEditingController();

  Future<void> addPaymentclick(mtx) async {
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      final String pname = _pnameController.text;
      final String amount = _budgetController.text;
      final String note = _noteController.text;
      final String date = _dateController.text;
      final int paytype = _paytypeController.text == 'Budget' ? 0 : 1;
      final String time = _timeController.text;
      final String paytypename = searchController.text;

      PaymentModel(
          name: pname,
          pyamount: amount,
          date: date,
          paytype: paytype,
          paytypename: paytypename,
          time: time,
          payid: payid,
          note: note);

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
          content: Text("Fill the  Missing"),
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.all(10),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        ),
      );
    }
  }
}
