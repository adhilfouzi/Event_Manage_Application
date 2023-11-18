import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:project_event/Database/functions/fn_budgetmodel.dart';
import 'package:project_event/Database/functions/fn_paymentdetail.dart';
import 'package:project_event/Database/functions/fn_paymodel.dart';
import 'package:project_event/Database/functions/fn_vendormodel.dart';
import 'package:project_event/Database/model/Payment/pay_model.dart';
import 'package:project_event/screen/Body/widget/List/paydropdown.dart';
import 'package:project_event/screen/Body/widget/Scaffold/app_bar.dart';
import 'package:project_event/screen/Body/widget/box/textfield_blue.dart';
import 'package:project_event/screen/Body/widget/sub/date.dart';
import 'package:project_event/screen/Body/widget/sub/time.dart';

class EditPayments extends StatefulWidget {
  final PaymentModel paydata;

  const EditPayments({super.key, required this.paydata});

  @override
  State<EditPayments> createState() => _EditPaymentsState();
}

class _EditPaymentsState extends State<EditPayments> {
  final _formKey = GlobalKey<FormState>();
  List searchResults = [];
  late int payid;
  @override
  void initState() {
    super.initState();
    _pnameController.text = widget.paydata.name;
    _budgetController.text = widget.paydata.pyamount;
    _noteController.text = widget.paydata.note!;
    _dateController.text = widget.paydata.date;
    _timeController.text = widget.paydata.time;
    payid = widget.paydata.payid;
    searchController.text = widget.paydata.paytypename;
    paymentTypeNotifier.value =
        widget.paydata.paytype == 0 ? PaymentType.budget : PaymentType.vendor;
  }

  @override
  Widget build(BuildContext context) {
    refreshPaymentpayid(widget.paydata.eventid);

    return Scaffold(
      appBar: CustomAppBar(
        actions: [
          AppAction(
              icon: Icons.delete,
              onPressed: () {
                dodeletepayment(context, widget.paydata);
              }),
          AppAction(
              icon: Icons.done,
              onPressed: () {
                editPaymentclick(context);
              }),
        ],
        titleText: 'Edit Payments',
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Form(
          key: _formKey,
          child: ValueListenableBuilder(
            valueListenable: paymentTypeNotifier,
            builder: (context, value, child) {
              log(paymentTypeNotifier.value.toString());
              return Column(children: [
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
                PayDown(
                    defaultdata: widget.paydata.paytype,
                    onChanged: (String? status) {
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

                    paymentTypeNotifier.value == PaymentType.budget
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
                  constraints:
                      const BoxConstraints(maxHeight: 300, minHeight: 0),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemBuilder: (context, index) => GestureDetector(
                      onTap: () {
                        searchController.text = searchResults[index].name;

                        setState(() {
                          payid = searchResults[index].id;
                          log(payid.toString());
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
                    return null;
                  },
                ),
                TextFieldBlue(textcontent: 'Note', controller: _noteController),
                Date(
                  defaultdata: _dateController.text,
                  controller: _dateController,
                ),
                Time(
                  defaultdata: _timeController.text,
                  controller: _timeController,
                )
              ]);
            },
          ),
        ),
      ),
    );
  }

  final TextEditingController _pnameController = TextEditingController();
  final TextEditingController searchController = TextEditingController();
  final TextEditingController _budgetController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  Future<void> editPaymentclick(mtx) async {
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      final int paytype =
          paymentTypeNotifier.value == PaymentType.budget ? 0 : 1;

      if (paymentTypeNotifier.value == PaymentType.budget) {
        // Check if the payid is in budgetpayid
        if (!budgetpayid.value.contains(payid)) {
          ScaffoldMessenger.of(mtx).showSnackBar(
            const SnackBar(
              content: Text("Make Proper Item Name"),
              behavior: SnackBarBehavior.floating,
              margin: EdgeInsets.all(10),
              backgroundColor: Colors.red,
              duration: Duration(seconds: 2),
            ),
          );
          return;
        }

        // Check if the paytypename is in budgetlist
        if (!budgetlist.value
            .any((budget) => budget.name == searchController.text)) {
          ScaffoldMessenger.of(mtx).showSnackBar(
            const SnackBar(
              content: Text("Make Proper Item Name"),
              behavior: SnackBarBehavior.floating,
              margin: EdgeInsets.all(10),
              backgroundColor: Colors.red,
              duration: Duration(seconds: 2),
            ),
          );
          return;
        }
      } else if (paymentTypeNotifier.value == PaymentType.vendor) {
        // Check if the payid is in vendorpayid
        if (!vendorpayid.value.contains(payid)) {
          ScaffoldMessenger.of(mtx).showSnackBar(
            const SnackBar(
              content: Text("Make Proper Item Name"),
              behavior: SnackBarBehavior.floating,
              margin: EdgeInsets.all(10),
              backgroundColor: Colors.red,
              duration: Duration(seconds: 2),
            ),
          );
          return;
        }

        // Check if the paytypename is in vendortlist
        if (!vendortlist.value
            .any((vendor) => vendor.name == searchController.text)) {
          ScaffoldMessenger.of(mtx).showSnackBar(
            const SnackBar(
              content: Text("Make Proper Item Name"),
              behavior: SnackBarBehavior.floating,
              margin: EdgeInsets.all(10),
              backgroundColor: Colors.red,
              duration: Duration(seconds: 2),
            ),
          );
          return;
        }
      }
      log(" payid: ${(paymentTypeNotifier.value == PaymentType.budget ? 0 : 1).toString()}");
      await editPayment(
          widget.paydata.id,
          _pnameController.text,
          paytype,
          searchController.text,
          _budgetController.text,
          _noteController.text,
          _dateController.text,
          _timeController.text,
          payid,
          widget.paydata.eventid);
      await refreshBudgetData(widget.paydata.eventid);
      await refreshVendorData(widget.paydata.eventid);
      Navigator.pop(mtx);
    }
  }
}

void dodeletepayment(rtx, PaymentModel student) {
  try {
    showDialog(
      context: rtx,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete'),
          content: Text('Do You Want delete Payment by ${student.name} ?'),
          actions: [
            TextButton(
                onPressed: () {
                  delectpayYes(context, student);
                },
                child: const Text('Yes')),
            TextButton(
                onPressed: () {
                  Navigator.pop(rtx);
                },
                child: const Text('No'))
          ],
        );
      },
    );
  } catch (e) {
    print('Error deleting data: $e');
  }
}

void delectpayYes(
  ctx,
  PaymentModel student,
) {
  try {
    deletePayment(student.id, student.eventid, student.payid);
    Navigator.of(ctx).pop();
    Navigator.of(ctx).pop();

    ScaffoldMessenger.of(ctx).showSnackBar(
      const SnackBar(
        content: Text("Successfully Deleted"),
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(10),
        backgroundColor: Colors.grey,
        duration: Duration(seconds: 2),
      ),
    );
  } catch (e) {
    print('Error inserting data: $e');
  }
}
