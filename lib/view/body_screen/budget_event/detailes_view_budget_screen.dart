import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_event/controller/event_controller/budget_event/budget_do_delect.dart';
import 'package:project_event/model/db_functions/fn_paymentdetail.dart';
import 'package:project_event/model/data_model/budget_model/budget_model.dart';
import 'package:project_event/model/data_model/event/event_model.dart';
import 'package:project_event/view/body_screen/budget_event/edit_budget_screen.dart';

import 'package:project_event/controller/widget/box/viewbox.dart';
import 'package:project_event/controller/widget/scaffold/app_bar.dart';
import 'package:project_event/controller/widget/scaffold/bottomborderappbar.dart';
import 'package:project_event/controller/widget/sub/paymentbar_widget.dart';
import 'package:project_event/controller/widget/sub/view_payment_per_person_screen.dart';

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
                doDeleteBudget(budget, 2, eventModel);
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
