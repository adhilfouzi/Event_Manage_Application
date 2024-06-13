import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:project_event/controller/event_controller/settlement_event/income_controller/income_delete_conformation.dart';
import 'package:project_event/model/core/color/color.dart';

import 'package:project_event/model/db_functions/fn_incomemodel.dart';
import 'package:project_event/model/db_functions/fn_paymentdetail.dart';
import 'package:project_event/model/db_functions/fn_paymodel.dart';
import 'package:project_event/model/data_model/payment/pay_model.dart';
import 'package:project_event/controller/widget/box/textfield_blue.dart';
import 'package:project_event/controller/widget/scaffold/app_bar.dart';
import 'package:project_event/controller/widget/sub/date_widget.dart';
import 'package:project_event/controller/widget/sub/fn_time.dart';

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
                  doDeleteIncome(widget.paydata);
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
                  ),
                  SizedBox(
                    height: 3.h,
                  ),
                  Padding(
                    padding: EdgeInsets.all(2.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            style: ButtonStyle(
                              padding: WidgetStateProperty.all(
                                EdgeInsets.symmetric(
                                    vertical: 1.5.h, horizontal: 4.h),
                              ),
                              shape: WidgetStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(13.0),
                                ),
                              ),
                              backgroundColor:
                                  WidgetStateProperty.all(buttoncolor),
                            ),
                            onPressed: () {
                              editPaymentclick(context);
                            },
                            child: Text(
                              'Edit Income',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
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
      Get.back();
    }
  }
}
