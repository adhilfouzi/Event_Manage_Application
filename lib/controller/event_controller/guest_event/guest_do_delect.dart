import 'package:get/get.dart';
import 'package:project_event/model/data_model/event/event_model.dart';
import 'package:project_event/model/data_model/guest_model/guest_model.dart';
import 'package:project_event/model/db_functions/fn_guestmodel.dart';
import 'package:project_event/view/body_screen/guest_event/guest_report/guests_done_rp.dart';
import 'package:project_event/view/body_screen/guest_event/guest_report/guests_pending_rp.dart';
import 'package:project_event/view/body_screen/guest_event/guests_screen.dart';

void deleteYes(GuestModel student, int step, Eventmodel eventModel) {
  deleteGuest(student.id, student.eventid);

  if (step == 2) {
    Get.offAll(
        transition: Transition.rightToLeftWithFade,
        //     allowSnapshotting: false,
        fullscreenDialog: true,
        Guests(
          eventModel: eventModel,
          eventid: student.eventid,
        ));
  } else if (step == 1) {
    Get.back();
    refreshguestdata(student.eventid);
  } else if (step == 3) {
    Get.offAll(PendingRpGuests(eventModel: eventModel));
  } else if (step == 4) {
    Get.offAll(DoneRpGuests(eventModel: eventModel));
  }
}
