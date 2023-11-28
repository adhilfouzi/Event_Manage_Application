import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:project_event/Database/functions/fn_incomemodel.dart';
import 'package:project_event/Database/model/Payment/pay_model.dart';
import 'package:project_event/screen/Body/widget/Scaffold/app_bar.dart';
import 'package:project_event/screen/Body/widget/box/textfield_blue.dart';
import 'package:project_event/screen/Body/widget/sub/date.dart';
import 'package:project_event/screen/Body/widget/sub/time.dart';
import 'package:sizer/sizer.dart';

class AddIncome extends StatefulWidget {
  final int eventID;

  const AddIncome({
    Key? key,
    required this.eventID,
  }) : super(key: key);

  @override
  State<AddIncome> createState() => _AddIncomeState();
}

class _AddIncomeState extends State<AddIncome> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: CustomAppBar(
          actions: [
            AppAction(
                icon: Icons.done,
                onPressed: () {
                  addincomeclick(context);
                }),
          ],
          titleText: 'Add Income',
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(1.h),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
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
                    _budgetController.value = _budgetController.value.copyWith(
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
                TextFieldBlue(textcontent: 'Note', controller: _noteController),
                Date(
                  controller: _dateController,
                ),
                Time(
                  controller: _timeController,
                )
              ],
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

  Future<void> addincomeclick(mtx) async {
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      final datas = IncomeModel(
        name: _pnameController.text,
        pyamount: _budgetController.text,
        date: _dateController.text,
        time: _timeController.text,
        note: _noteController.text,
        eventid: widget.eventID,
      );
      await addincome(datas);
      setState(() {
        Navigator.pop(context);
        _pnameController.clear();
        _budgetController.clear();
        _noteController.clear();
        _dateController.clear();
        _timeController.clear();
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
