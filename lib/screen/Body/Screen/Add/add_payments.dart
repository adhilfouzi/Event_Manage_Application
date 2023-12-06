import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
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
import 'package:sizer/sizer.dart';

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
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
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
          padding: EdgeInsets.all(1.h),
          child: Form(
            key: _formKey,
            child: ValueListenableBuilder(
              valueListenable: paymentTypeNotifier,
              builder: (context, value, child) {
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
      await addPayment(datas);
      await refreshBudgetData(widget.eventID);
      await refreshVendorData(widget.eventID);
      await refreshmainbalancedata(widget.eventID);

      // if (paymentTypeNotifier.value == PaymentType.budget) {
      // } else if (paymentTypeNotifier.value == PaymentType.vendor) {}
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
        SnackBar(
          content: const Text("Successfully added"),
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.all(1.h),
          backgroundColor: Colors.greenAccent,
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }
}
