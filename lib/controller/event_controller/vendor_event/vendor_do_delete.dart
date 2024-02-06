import 'package:get/get.dart';
import 'package:project_event/model/data_model/event/event_model.dart';
import 'package:project_event/model/data_model/vendors/vendors_model.dart';
import 'package:project_event/model/db_functions/fn_paymentdetail.dart';
import 'package:project_event/model/db_functions/fn_vendormodel.dart';
import 'package:project_event/view/body_screen/vendor_event/vendors_screen.dart';

void deleteYes(VendorsModel student, int step, Eventmodel eventModel) {
  try {
    deleteVendor(student.id, student.eventid);
    deletePayVendor(student.eventid, student.id);

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

      refreshVendorData(student.eventid);
    }
  } catch (e) {
    // print('Error inserting data: $e');
  }
}
