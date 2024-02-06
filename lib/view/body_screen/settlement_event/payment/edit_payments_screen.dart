import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:project_event/controller/event_controller/settlement_event/payment_controller/payment_delete_conformation.dart';
import 'package:project_event/model/db_functions/fn_budgetmodel.dart';
import 'package:project_event/model/db_functions/fn_paymentdetail.dart';
import 'package:project_event/model/db_functions/fn_paymodel.dart';
import 'package:project_event/model/db_functions/fn_vendormodel.dart';
import 'package:project_event/model/data_model/payment/pay_model.dart';
import 'package:project_event/controller/widget/box/textfield_blue.dart';
import 'package:project_event/controller/widget/list/paydropdown.dart';
import 'package:project_event/controller/widget/scaffold/app_bar.dart';
import 'package:project_event/controller/widget/sub/date_widget.dart';
import 'package:project_event/controller/widget/sub/fn_time.dart';

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
                  doDeletePayment(widget.paydata);
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
          Get.snackbar('Warning', "Make Proper Item Name",
              colorText: Colors.black,
              backgroundColor: Colors.redAccent,
              snackPosition: SnackPosition.BOTTOM,
              instantInit: false,
              duration: const Duration(milliseconds: 1100),
              dismissDirection: DismissDirection.startToEnd);
          return;
        }

        // Check if the paytypename is in budgetlist
        if (!budgetlist.value
            .any((budget) => budget.name == searchController.text)) {
          Get.snackbar('Warning', "Make Proper Item Name",
              colorText: Colors.black,
              backgroundColor: Colors.redAccent,
              snackPosition: SnackPosition.BOTTOM,
              instantInit: false,
              duration: const Duration(milliseconds: 1100),
              dismissDirection: DismissDirection.startToEnd);
          return;
        }
      } else if (paymentTypeNotifier.value == PaymentType.vendor) {
        // Check if the payid is in vendorpayid
        if (!vendorpayid.value.contains(payid)) {
          Get.snackbar('Warning', "Make Proper Item Name",
              colorText: Colors.black,
              backgroundColor: Colors.redAccent,
              snackPosition: SnackPosition.BOTTOM,
              instantInit: false,
              duration: const Duration(milliseconds: 1100),
              dismissDirection: DismissDirection.startToEnd);
          return;
        }

        // Check if the paytypename is in vendortlist
        if (!vendortlist.value
            .any((vendor) => vendor.name == searchController.text)) {
          Get.snackbar('Warning', "Make Proper Item Name",
              colorText: Colors.black,
              backgroundColor: Colors.redAccent,
              snackPosition: SnackPosition.BOTTOM,
              instantInit: false,
              duration: const Duration(milliseconds: 1100),
              dismissDirection: DismissDirection.startToEnd);
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
      Get.back();
    }
  }
}
