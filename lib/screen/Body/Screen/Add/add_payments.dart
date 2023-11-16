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

class AddPayments extends StatefulWidget {
  final int eventID;

  const AddPayments({
    Key? key,
    required this.eventID,
  }) : super(key: key);

  @override
  State<AddPayments> createState() => _AddPaymentsState();
}

class _AddPaymentsState extends State<AddPayments> {
  final _formKey = GlobalKey<FormState>();
  List searchResults = [];
  int payid = 999999999999999;

  @override
  void initState() {
    super.initState();
    refreshBudgetData(widget.eventID);
    refreshVendorData(widget.eventID);
    paymentTypeNotifier = ValueNotifier(PaymentType.budget);
  }

  @override
  Widget build(BuildContext context) {
    // _paytypeController.text =
    //     paymentTypeNotifier.value.toString().split('.').last;

    refreshPaymentpayid(widget.eventID);
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
                PayDown(onChanged: (String? status) {
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
                  controller: _dateController,
                ),
                Time(
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
  // final TextEditingController _paytypeController = TextEditingController();
  final TextEditingController searchController = TextEditingController();
  final TextEditingController _budgetController = TextEditingController();

  final TextEditingController _noteController = TextEditingController();

  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  //final TextEditingController _categoryController = TextEditingController();

  Future<void> addPaymentclick(mtx) async {
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
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

      final datas = PaymentModel(
        name: _pnameController.text,
        pyamount: _budgetController.text,
        date: _dateController.text,
        paytype: paymentTypeNotifier.value == PaymentType.budget ? 0 : 1,
        paytypename: searchController.text,
        time: _timeController.text,
        payid: payid,
        note: _noteController.text,
        eventid: widget.eventID,
      );
      log(" payid: ${(paymentTypeNotifier.value == PaymentType.budget ? 0 : 1).toString()}");
      await addPayment(datas);
      setState(() {
        Navigator.pop(context);
        _pnameController.clear();
        _budgetController.clear();
        _noteController.clear();
        _dateController.clear();
        _timeController.clear();
        searchController.clear();
      });
      ScaffoldMessenger.of(mtx).showSnackBar(
        const SnackBar(
          content: Text("Successfully added"),
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.all(10),
          backgroundColor: Colors.greenAccent,
          duration: Duration(seconds: 2),
        ),
      );
    }
  }
}
