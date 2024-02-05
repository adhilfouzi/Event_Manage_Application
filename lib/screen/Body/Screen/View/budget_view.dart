import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_event/database/functions/fn_paymentdetail.dart';
import 'package:project_event/database/model/budget_model/budget_model.dart';
import 'package:project_event/database/model/event/event_model.dart';
import 'package:project_event/screen/body/screen/edit/edit_budget.dart';
import 'package:project_event/screen/body/screen/search/budget_search.dart';
import 'package:project_event/screen/body/widget/box/viewbox.dart';
import 'package:project_event/screen/body/widget/scaffold/app_bar.dart';
import 'package:project_event/screen/body/widget/scaffold/bottomborderappbar.dart';
import 'package:project_event/screen/body/widget/sub/paymentbar.dart';
import 'package:project_event/screen/body/widget/sub/payments.dart';

import 'package:sizer/sizer.dart';

class BudgetView extends StatelessWidget {
  final Eventmodel eventModel;

  final BudgetModel budget;
  const BudgetView({super.key, required this.budget, required this.eventModel});

  @override
  Widget build(BuildContext context) {
    refreshPaymentTypeData(budget.id!, budget.eventid);
    refreshbalancedata(budget.id!, budget.eventid, 0, budget.esamount);

    return Scaffold(
      appBar: CustomAppBar(
        actions: [
          AppAction(
              icon: Icons.delete,
              onPressed: () {
                dodeletebudget(context, budget, 2, eventModel);
              }),
          AppAction(
              icon: Icons.edit,
              onPressed: () {
                Get.to(
                    transition: Transition.rightToLeftWithFade,
                    EditBudget(budgetdata: budget, eventModel: eventModel));
              }),
        ],
        titleText: ' ',
        bottom: const BottomBorderNull(),
      ),
      body: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(2.h),
          child: Column(children: [
            SizedBox(height: 2.h),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(2.h),
              decoration: BoxDecoration(
                color: const Color.fromRGBO(216, 239, 225, 1),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 3,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Column(
                children: [
                  ViewBox(textcontent: 'Name ', controller: budget.name),
                  ViewBoxAccommodation(
                      textcontent: 'Category', controller: budget.category),
                  ViewBox(textcontent: 'Note', controller: budget.note!),
                  SizedBox(height: 2.h),
                  PaymentsBar(
                      eAmount: budget.esamount.toString(),
                      pending: budget.pending.toString(),
                      paid: budget.paid.toString()),
                  SizedBox(height: 2.h),
                  Payments(valueListenable: budgetPaymentDetails),
                ],
              ),
            ),
          ]),
        )
      ]),
    );
  }
}
