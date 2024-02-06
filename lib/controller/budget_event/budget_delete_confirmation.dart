import 'dart:developer';

import 'package:get/get.dart';
import 'package:project_event/model/data_model/budget_model/budget_model.dart';
import 'package:project_event/model/data_model/event/event_model.dart';
import 'package:project_event/model/db_functions/fn_budgetmodel.dart';
import 'package:project_event/model/db_functions/fn_paymentdetail.dart';
import 'package:project_event/view/body_screen/budget_event/budget_report/rp_done_budget_screen.dart';
import 'package:project_event/view/body_screen/budget_event/budget_report/rp_pending_buget_screen.dart';
import 'package:project_event/view/body_screen/budget_event/budget_screen.dart';

void delectYes(BudgetModel student, int step, Eventmodel eventModel) {
  deleteBudget(student.id, student.eventid);
  deletePayBudget(student.eventid, student.id);
  refreshBudgetData(student.eventid);

  log('final $step');
  if (step == 2) {
    Get.offAll(
        transition: Transition.rightToLeftWithFade,
        fullscreenDialog: true,
        Budget(eventid: student.eventid, eventModel: eventModel));
  } else if (step == 3) {
    Get.back();
    refreshBudgetData(student.eventid);
  } else if (step == 4) {
    Get.offAll(PendingRpBudget(eventModel: eventModel));
  } else if (step == 5) {
    Get.offAll(DoneRpBudget(eventModel: eventModel));
  }
}
