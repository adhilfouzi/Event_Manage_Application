import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:project_event/Core/Color/color.dart';
import 'package:project_event/Core/Color/font.dart';
import 'package:project_event/Database/functions/fn_paymentdetail.dart';
import 'package:project_event/Database/model/Budget_Model/budget_model.dart';
import 'package:project_event/screen/Body/Screen/Edit/edit_budget.dart';
import 'package:project_event/screen/Body/widget/Scaffold/app_bar.dart';
import 'package:project_event/screen/Body/widget/Scaffold/bottomborderappbar.dart';
import 'package:project_event/screen/Body/widget/box/viewbox.dart';
import 'package:project_event/screen/Body/widget/sub/paymentbar.dart';

class BudgetView extends StatelessWidget {
  final BudgetModel budget;
  const BudgetView({super.key, required this.budget});

  @override
  Widget build(BuildContext context) {
    refreshPaymentTypeData(budget.id!, budget.eventid);
    return Scaffold(
      appBar: CustomAppBar(
        actions: [
          AppAction(icon: Icons.delete, onPressed: () {}),
          AppAction(
              icon: Icons.edit,
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => EditBudget(budgetdata: budget),
                ));
              }),
        ],
        titleText: ' ',
        bottom: const BottomBorderNull(),
      ),
      body: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(15),
          child: Column(children: [
            const SizedBox(height: 20),
            ViewBox(textcontent: 'Name ', controller: budget.name),
            ViewBox(textcontent: 'Category', controller: budget.category),
            ViewBox(textcontent: 'Note', controller: budget.note!),
            const SizedBox(height: 15),
            const SizedBox(height: 15),
            ViewBox(
                textcontent: 'Estimatrd Amount', controller: budget.esamount),
            const SizedBox(height: 5),
            PaymentsBar(),
            const SizedBox(height: 15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Payments', style: raleway()),
                  ],
                ),
                const SizedBox(height: 5),
                Container(
                  constraints:
                      const BoxConstraints(maxHeight: 140, minHeight: 0),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(color: buttoncolor, width: 1),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: ValueListenableBuilder(
                    valueListenable: budgetPaymentDetails,
                    builder: (context, value, child) {
                      log('length ${value.length.toString()}');
                      log(budget.id.toString());
                      if (value.isNotEmpty) {
                        return ListView.builder(
                          itemCount: value.length,
                          itemBuilder: (BuildContext context, int index) {
                            final data = value[index];
                            return ListTile(
                              onTap: () {
                                // Navigator.of(context).push(MaterialPageRoute(
                                //     builder: (context) =>
                                //         EditPayments(paydata: data)));
                              },
                              leading: Image.asset(
                                'assets/UI/icons/person.png',
                              ),
                              title: Text(
                                data.name,
                                style: raleway(color: Colors.black),
                              ),
                              trailing: Text(
                                "₹${data.pyamount}",
                                style: racingSansOne(
                                    color: Colors.black54,
                                    fontWeight: FontWeight.normal),
                              ),
                            );
                          },
                        );
                      } else {
                        return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset('assets/UI/icons/nodata.png',
                                  height: 70, width: 70),
                              const SizedBox(height: 10),
                              Text(
                                'No Payments Found',
                                style:
                                    raleway(fontSize: 13, color: Colors.black),
                              )
                            ]);
                      }
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
          ]),
        )
      ]),
    );
  }
}
