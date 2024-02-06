import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:project_event/model/db_functions/fn_budgetmodel.dart';
import 'package:project_event/model/data_model/budget_model/budget_model.dart';
import 'package:project_event/controller/widget/box/textfield_blue.dart';
import 'package:project_event/controller/services/categorydropdown_widget.dart';
import 'package:project_event/controller/widget/scaffold/app_bar.dart';

import 'package:sizer/sizer.dart';

class AddBudget extends StatefulWidget {
  final int eventid;

  const AddBudget({super.key, required this.eventid});

  @override
  State<AddBudget> createState() => _AddBudgetState();
}

class _AddBudgetState extends State<AddBudget> {
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
                  addGuestclick(context);
                }),
          ],
          titleText: 'Add Budget',
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(1.h),
          child: Form(
            key: _formKey,
            child: Column(children: [
              TextFieldBlue(
                textcontent: 'Name',
                controller: _nameController,
                keyType: TextInputType.name,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Name is required';
                  }
                  return null;
                },
              ),
              CategoryDown(
                onCategorySelected: (String value) {
                  _categoryController.text = value;
                },
              ),
              TextFieldBlue(textcontent: 'Note', controller: _noteController),
              TextFieldBlue(
                onChanged: (value) {
                  String numericValue = value.replaceAll(RegExp(r'[^0-9]'), '');
                  final formatValue = _formatCurrency(numericValue);
                  _budgetController.value = _budgetController.value.copyWith(
                    text: formatValue,
                    selection:
                        TextSelection.collapsed(offset: formatValue.length),
                  );
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Estimated Amount is required';
                  }
                  return null;
                },
                keyType: TextInputType.number,
                textcontent: 'Estimated Amount',
                controller: _budgetController,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
              ),
            ]),
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

  final _budgetController = TextEditingController();
  final _nameController = TextEditingController();
  final _categoryController = TextEditingController();
  final _noteController = TextEditingController();
  Future<void> addGuestclick(mtx) async {
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      final name = _nameController.text.toUpperCase().trimLeft().trimRight();
      final category = _categoryController.text;
      final note = _noteController.text.trimLeft().trimRight();
      final budget = _budgetController.text.trimLeft().trimRight();
      final budgetdata = BudgetModel(
          name: name,
          category: category,
          eventid: widget.eventid,
          esamount: budget,
          note: note,
          paid: 0,
          pending: int.parse(budget.replaceAll(RegExp(r'[^0-9]'), '')),
          status: 0);
      await addBudget(budgetdata);
      refreshBudgetData(widget.eventid);
      Get.back();
      ;
    }
  }
}
