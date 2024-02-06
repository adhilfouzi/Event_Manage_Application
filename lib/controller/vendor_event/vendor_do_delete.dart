import 'package:get/get.dart';
import 'package:project_event/model/data_model/event/event_model.dart';
import 'package:project_event/model/data_model/vendors/vendors_model.dart';
import 'package:project_event/model/db_functions/fn_paymentdetail.dart';
import 'package:project_event/model/db_functions/fn_vendormodel.dart';
import 'package:project_event/view/body_screen/vendor_event/vendor_report/rp_done_vendor_screen.dart';
import 'package:project_event/view/body_screen/vendor_event/vendor_report/rp_pending_vendors_screen.dart';
import 'package:project_event/view/body_screen/vendor_event/vendors_screen.dart';

void deleteYes(VendorsModel student, int step, Eventmodel eventModel) {
  try {
    deleteVendor(student.id, student.eventid);
    deletePayVendor(student.eventid, student.id);
    refreshVendorData(student.eventid);

    if (step == 2) {
      Get.offAll(
          transition: Transition.rightToLeftWithFade,
          //     allowSnapshotting: false,
          fullscreenDialog: true,
          Vendors(
            eventModel: eventModel,
            eventid: student.eventid,
          ));
    } else if (step == 1) {
      Get.back();
    } else if (step == 3) {
      Get.offAll(PendingRpVendorList(eventModel: eventModel));
    } else if (step == 4) {
      Get.offAll(DoneRpVendorList(eventModel: eventModel));
    }
  } catch (e) {
    // print('Error inserting data: $e');
  }
}
