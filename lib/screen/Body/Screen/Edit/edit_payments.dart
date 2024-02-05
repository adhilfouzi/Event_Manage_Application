import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:project_event/database/functions/fn_budgetmodel.dart';
import 'package:project_event/database/functions/fn_paymentdetail.dart';
import 'package:project_event/database/functions/fn_paymodel.dart';
import 'package:project_event/database/functions/fn_vendormodel.dart';
import 'package:project_event/database/model/payment/pay_model.dart';
import 'package:project_event/screen/body/widget/box/textfield_blue.dart';
import 'package:project_event/screen/body/widget/list/paydropdown.dart';
import 'package:project_event/screen/body/widget/scaffold/app_bar.dart';
import 'package:project_event/screen/body/widget/sub/date.dart';
import 'package:project_event/screen/body/widget/sub/time.dart';

import 'package:sizer/sizer.dart';

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
    refreshBudgetData(widget.paydata.eventid);
    refreshVendorData(widget.paydata.eventid);
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

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
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
          padding: EdgeInsets.all(1.h),
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
                      setState(() {});
                    },
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  Container(
                    constraints: BoxConstraints(maxHeight: 15.h, minHeight: 0),
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemBuilder: (context, index) => GestureDetector(
                        onTap: () {
                          searchController.text = searchResults[index].name;

                          setState(() {
                            payid = searchResults[index].id;
                          });
                        },
                        child: Container(
                          margin: EdgeInsets.all(1.h),
                          padding: EdgeInsets.all(0.5.h),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(searchResults[index].name),
                              Text(
                                  'Pending: ₹${searchResults[index].pending.toString()}'),
                            ],
                          ),
                        ),
                      ),
                      itemCount: searchResults.length,
                    ),
                  ),
                  TextFieldBlue(
                    onChanged: (value) {
                      String numericValue =
                          value.replaceAll(RegExp(r'[^0-9]'), '');
                      final formatValue = _formatCurrency(numericValue);
                      _budgetController.value =
                          _budgetController.value.copyWith(
                        text: formatValue,
                        selection:
                            TextSelection.collapsed(offset: formatValue.length),
                      );
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Amount is required';
                      }
                      return null;
                    },
                    keyType: TextInputType.number,
                    textcontent: 'Amount',
                    controller: _budgetController,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                  ),
                  TextFieldBlue(
                      textcontent: 'Note', controller: _noteController),
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
      ),
    );
  }

  String _formatCurrency(String value) {
    if (value.isNotEmpty) {
      final format = NumberFormat("#,##0", "en_US");
      return format.format(int.parse(value));
    } else {
      return value;
    }
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
            SnackBar(
              content: const Text("Make Proper Item Name"),
              behavior: SnackBarBehavior.floating,
              margin: EdgeInsets.all(1.h),
              backgroundColor: Colors.red,
              duration: const Duration(seconds: 2),
            ),
          );
          return;
        }

        // Check if the paytypename is in budgetlist
        if (!budgetlist.value
            .any((budget) => budget.name == searchController.text)) {
          ScaffoldMessenger.of(mtx).showSnackBar(
            SnackBar(
              content: const Text("Make Proper Item Name"),
              behavior: SnackBarBehavior.floating,
              margin: EdgeInsets.all(1.h),
              backgroundColor: Colors.red,
              duration: const Duration(seconds: 2),
            ),
          );
          return;
        }
      } else if (paymentTypeNotifier.value == PaymentType.vendor) {
        // Check if the payid is in vendorpayid
        if (!vendorpayid.value.contains(payid)) {
          ScaffoldMessenger.of(mtx).showSnackBar(
            SnackBar(
              content: const Text("Make Proper Item Name"),
              behavior: SnackBarBehavior.floating,
              margin: EdgeInsets.all(1.h),
              backgroundColor: Colors.red,
              duration: const Duration(seconds: 2),
            ),
          );
          return;
        }

        // Check if the paytypename is in vendortlist
        if (!vendortlist.value
            .any((vendor) => vendor.name == searchController.text)) {
          ScaffoldMessenger.of(mtx).showSnackBar(
            SnackBar(
              content: const Text("Make Proper Item Name"),
              behavior: SnackBarBehavior.floating,
              margin: EdgeInsets.all(1.h),
              backgroundColor: Colors.red,
              duration: const Duration(seconds: 2),
            ),
          );
          return;
        }
      }
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
      await refreshmainbalancedata(widget.paydata.eventid);
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
    // print('Error deleting data: $e');
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
      SnackBar(
        content: const Text("Successfully Deleted"),
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(1.h),
        backgroundColor: Colors.grey,
        duration: const Duration(seconds: 2),
      ),
    );
  } catch (e) {
    // print('Error inserting data: $e');
  }
}
