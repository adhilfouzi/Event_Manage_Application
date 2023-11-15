import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:project_event/Database/functions/fn_budgetmodel.dart';
import 'package:project_event/Database/model/Budget_Model/budget_model.dart';
import 'package:project_event/Database/model/Vendors/vendors_model.dart';
import 'package:project_event/screen/Body/widget/box/textfield_blue.dart';

class PayDropdown extends StatefulWidget {
  final ValueChanged<String> onCategorySelected;
  final String? defaultdata;
  final List<BudgetModel>? budgets;
  final List<VendorsModel>? vendors;

  const PayDropdown({
    super.key,
    required this.onCategorySelected,
    this.defaultdata,
    this.budgets,
    this.vendors,
  });

  @override
  State<PayDropdown> createState() => _PayDropdownState();
}

class _PayDropdownState extends State<PayDropdown> {
  late String selectedValue;
  final searchController = TextEditingController();

  @override
  void initState() {
    // print(widget.budgets);
    // print(widget.vendors);
    selectedValue = widget.budgets![0].name;
    super.initState();
    if (widget.budgets != null && widget.budgets!.isNotEmpty) {
      selectedValue = widget.budgets![0].name;
    } else if (widget.vendors != null && widget.vendors!.isNotEmpty) {
      selectedValue = widget.vendors![0].name;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: raylist,
      builder: (BuildContext context, dynamic value, Widget? child) {
        log(value.toString());
        log(raylist.toString());
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Selected Budget: $selectedValue'),
            SizedBox(height: 20),
            ValueListenableBuilder(
              valueListenable: budgetlist,
              builder: (context, value, child) {
                if (value.isNotEmpty) {
                  return TextFieldBlue(
                    textcontent: 'textcontent',
                    controller: searchController,
                    onChanged: (p0) {},
                  );
                } else {
                  return const Center(
                    child: Text(
                      'No Budget available',
                      style: TextStyle(fontSize: 18),
                    ),
                  );
                }
              },
            ),
          ],
        );
      },
    );
  }
}
