import 'package:get/get.dart';
import 'package:project_event/model/data_model/budget_model/budget_model.dart';
import 'package:project_event/model/data_model/event/event_model.dart';
import 'package:project_event/model/db_functions/fn_budgetmodel.dart';
import 'package:project_event/model/db_functions/fn_paymentdetail.dart';
import 'package:project_event/view/body_screen/budget_event/budget_screen.dart';

void delectYes(BudgetModel student, int step, Eventmodel eventModel) {
  deleteBudget(student.id, student.eventid);
  deletePayBudget(student.eventid, student.id);

  if (step == 2) {
    Get.offAll(
        transition: Transition.rightToLeftWithFade,
        //     allowSnapshotting: false,
        fullscreenDialog: true,
        Budget(
          eventid: student.eventid,
          eventModel: eventModel,
        ));
  } else if (step == 3) {
    Get.back();

    refreshBudgetData(student.eventid);
  }
}
