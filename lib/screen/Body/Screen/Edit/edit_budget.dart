import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:project_event/Database/functions/fn_budgetmodel.dart';
import 'package:project_event/Database/model/Budget_Model/budget_model.dart';
import 'package:project_event/Database/model/Event/event_model.dart';
import 'package:project_event/screen/Body/Screen/Event_Planner/budget.dart';
import 'package:project_event/screen/Body/Screen/Search/budget_search.dart';
import 'package:project_event/screen/Body/widget/List/categorydropdown.dart';
import 'package:project_event/screen/Body/widget/Scaffold/app_bar.dart';
import 'package:project_event/screen/Body/widget/box/textfield_blue.dart';
import 'package:sizer/sizer.dart';

class EditBudget extends StatefulWidget {
  final Eventmodel eventModel;

  final BudgetModel budgetdata;
  const EditBudget(
      {super.key, required this.budgetdata, required this.eventModel});

  @override
  State<EditBudget> createState() => _EditBudgetState();
}

class _EditBudgetState extends State<EditBudget> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext ctx) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: CustomAppBar(
          actions: [
            AppAction(
                icon: Icons.delete,
                onPressed: () {
                  dodeletebudget(
                      context, widget.budgetdata, 2, widget.eventModel);
                }),
            AppAction(
                icon: Icons.done,
                onPressed: () {
                  editGuestclick(context, widget.budgetdata);
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

              // Payments(goto: AddPayments())
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

  Future<void> editGuestclick(BuildContext ctx, BudgetModel budget) async {
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      Navigator.of(ctx).pushReplacement(MaterialPageRoute(
          builder: (ctx) => Budget(
                eventid: budget.eventid,
                eventModel: widget.eventModel,
              )));

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
    }
  }
}
