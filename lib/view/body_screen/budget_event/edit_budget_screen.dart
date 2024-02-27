import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:project_event/controller/event_controller/budget_event/budget_do_delect.dart';
import 'package:project_event/model/core/color/color.dart';

import 'package:project_event/model/db_functions/fn_budgetmodel.dart';
import 'package:project_event/model/data_model/budget_model/budget_model.dart';
import 'package:project_event/model/data_model/event/event_model.dart';
import 'package:project_event/model/getx/snackbar/getx_snackbar.dart';
import 'package:project_event/view/body_screen/budget_event/budget_report/rp_done_budget_screen.dart';
import 'package:project_event/view/body_screen/budget_event/budget_report/rp_pending_buget_screen.dart';
import 'package:project_event/view/body_screen/budget_event/budget_screen.dart';

import 'package:project_event/controller/widget/box/textfield_blue.dart';
import 'package:project_event/controller/services/categorydropdown_widget.dart';
import 'package:project_event/controller/widget/scaffold/app_bar.dart';

import 'package:sizer/sizer.dart';

class EditBudget extends StatefulWidget {
  final Eventmodel eventModel;
  final int step;

  final BudgetModel budgetdata;
  const EditBudget(
      {super.key,
      required this.budgetdata,
      required this.eventModel,
      required this.step});

  @override
  State<EditBudget> createState() => _EditBudgetState();
}

class _EditBudgetState extends State<EditBudget> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext ctx) {
    log('EditBudget :${widget.step}');
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: CustomAppBar(
          actions: [
            AppAction(
                icon: Icons.delete,
                onPressed: () {
                  log(widget.step.toString());
                  doDeleteBudget(
                      widget.budgetdata, widget.step, widget.eventModel);
                }),
          ],
          titleText: 'Edit Budget',
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(1.h),
          child: Form(
            key: _formKey,
            child: Column(children: [
              TextFieldBlue(
                textcontent: 'Name',
                controller: _nameController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return ' name is required';
                  }
                  return null; // Return null if the input is valid
                },
              ),
              CategoryDown(
                defaultdata: _categoryController.text,
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
                          padding: MaterialStateProperty.all(
                            EdgeInsets.symmetric(
                                vertical: 1.5.h, horizontal: 4.h),
                          ),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(13.0),
                            ),
                          ),
                          backgroundColor:
                              MaterialStateProperty.all(buttoncolor),
                        ),
                        onPressed: () {
                          editGuestclick(context, widget.budgetdata,
                              widget.step, widget.eventModel);
                        },
                        child: Text(
                          'Update Budget',
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

  @override
  void initState() {
    super.initState();
    _budgetController.text = widget.budgetdata.esamount;
    _nameController.text = widget.budgetdata.name;
    _categoryController.text = widget.budgetdata.category;
    _noteController.text = widget.budgetdata.note!;
  }

  Future<void> editGuestclick(BuildContext ctx, BudgetModel budget, int step,
      Eventmodel eventModel) async {
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      await editBudget(
          budget.id,
          _nameController.text.toUpperCase().trimLeft().trimRight(),
          _categoryController.text,
          _noteController.text.trimLeft().trimRight(),
          _budgetController.text.trimLeft().trimRight(),
          budget.paid,
          budget.pending,
          budget.eventid,
          budget.status);
      if (step == 2) {
        Get.offAll(
            transition: Transition.rightToLeftWithFade,
            fullscreenDialog: true,
            Budget(eventid: budget.eventid, eventModel: eventModel));
      } else if (step == 3) {
        Get.back();
        refreshBudgetData(budget.eventid);
      } else if (step == 4) {
        Get.offAll(PendingRpBudget(eventModel: eventModel));
      } else if (step == 5) {
        Get.offAll(DoneRpBudget(eventModel: eventModel));
      }
      SnackbarModel.successSnack(message: "Successfully edited");
    } else {
      SnackbarModel.errorSnack();
    }
  }
}
