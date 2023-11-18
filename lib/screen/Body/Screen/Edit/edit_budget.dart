import 'package:flutter/material.dart';
import 'package:project_event/Database/functions/fn_budgetmodel.dart';
import 'package:project_event/Database/model/Budget_Model/budget_model.dart';
import 'package:project_event/screen/Body/Screen/Search/budget_search.dart';
import 'package:project_event/screen/Body/widget/List/categorydropdown.dart';
import 'package:project_event/screen/Body/widget/Scaffold/app_bar.dart';
import 'package:project_event/screen/Body/widget/box/textfield_blue.dart';

class EditBudget extends StatefulWidget {
  final BudgetModel budgetdata;
  const EditBudget({super.key, required this.budgetdata});

  @override
  State<EditBudget> createState() => _EditBudgetState();
}

class _EditBudgetState extends State<EditBudget> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        actions: [
          AppAction(
              icon: Icons.delete,
              onPressed: () {
                dodeletebudget(context, widget.budgetdata);
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
        padding: const EdgeInsets.all(10.0),
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
              keyType: TextInputType.number,
              textcontent: 'Estimatrd Amount',
              controller: _budgetController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return ' Estimatrd Amount is required';
                }
                return null;
              },
            ),

            // Payments(goto: AddPayments())
          ]),
        ),
      ),
    );
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
      await editBudget(
          budget.id,
          _nameController.text.toUpperCase().trimLeft().trimRight(),
          _categoryController.text,
          _noteController.text.trimLeft().trimRight(),
          _budgetController.text.trimLeft().trimRight(),
          budget.paid,
          budget.pending,
          budget.eventid);

      refreshBudgetData(budget.eventid);
      ScaffoldMessenger.of(ctx).showSnackBar(
        const SnackBar(
          content: Text("Successfully Edited"),
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.all(10),
          backgroundColor: Colors.greenAccent,
          duration: Duration(seconds: 2),
        ),
      );
      Navigator.pop(ctx);
    } else {
      ScaffoldMessenger.of(ctx).showSnackBar(
        const SnackBar(
          content: Text("Fill the Name & Estimatrd Amount"),
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.all(10),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        ),
      );
    }
  }
}
