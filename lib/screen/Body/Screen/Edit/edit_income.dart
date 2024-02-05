import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:project_event/database/functions/fn_incomemodel.dart';
import 'package:project_event/database/functions/fn_paymentdetail.dart';
import 'package:project_event/database/functions/fn_paymodel.dart';
import 'package:project_event/database/model/payment/pay_model.dart';
import 'package:project_event/screen/body/widget/box/textfield_blue.dart';
import 'package:project_event/screen/body/widget/scaffold/app_bar.dart';
import 'package:project_event/screen/body/widget/sub/date.dart';
import 'package:project_event/screen/body/widget/sub/time.dart';

import 'package:sizer/sizer.dart';

class EditIncome extends StatefulWidget {
  final IncomeModel paydata;

  const EditIncome({super.key, required this.paydata});

  @override
  State<EditIncome> createState() => _EditIncomeState();
}

class _EditIncomeState extends State<EditIncome> {
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
                  dodeleteincome(context, widget.paydata);
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
                    textcontent: 'Name',
                    controller: _pnameController,
                    keyType: TextInputType.name,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Name is required';
                      }
                      return null;
                    },
                  ),
                  TextFieldBlue(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Name is required';
                      }
                      return null;
                    },
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
  final TextEditingController _budgetController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  Future<void> editPaymentclick(mtx) async {
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      await editincome(
          widget.paydata.id,
          _pnameController.text,
          _budgetController.text,
          _noteController.text,
          _dateController.text,
          _timeController.text,
          widget.paydata.eventid);
      Navigator.pop(mtx);
    }
  }
}

void dodeleteincome(rtx, IncomeModel student) {
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
  IncomeModel student,
) {
  try {
    deleteincome(student.id, student.eventid);
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
