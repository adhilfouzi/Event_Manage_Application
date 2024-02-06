import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_event/model/core/color/color.dart';
import 'package:project_event/model/core/font/font.dart';
import 'package:project_event/model/db_functions/fn_budgetmodel.dart';
import 'package:project_event/model/db_functions/fn_guestmodel.dart';
import 'package:project_event/model/db_functions/fn_taskmodel.dart';
import 'package:project_event/model/db_functions/fn_vendormodel.dart';
import 'package:project_event/model/data_model/event/event_model.dart';
import 'package:project_event/view/body_screen/event/event_view_screen.dart';
import 'package:project_event/view/body_screen/budget_event/budget_report/rp_done_budget_screen.dart';
import 'package:project_event/view/body_screen/budget_event/budget_report/rp_pending_buget_screen.dart';
import 'package:project_event/view/body_screen/guest_event/guest_report/guests_done_rp.dart';
import 'package:project_event/view/body_screen/guest_event/guest_report/guests_pending_rp.dart';
import 'package:project_event/view/body_screen/task_event/task_report/rp_done_task_screen.dart';
import 'package:project_event/view/body_screen/task_event/task_report/rp_pending_task_screen.dart';
import 'package:project_event/view/body_screen/vendor_event/vendor_report/rp_done_vendor_screen.dart';
import 'package:project_event/view/body_screen/vendor_event/vendor_report/rp_pending_vendors_screen.dart';
import 'package:project_event/controller/widget/scaffold/app_bar.dart';

import 'package:sizer/sizer.dart';

class Report extends StatelessWidget {
  final Eventmodel eventModel;

  final int eventid;

  const Report({super.key, required this.eventid, required this.eventModel});
  @override
  Widget build(BuildContext context) {
    refreshBudgetData(eventid);
    refreshVendorData(eventid);
    refreshEventtaskdata(eventid);
    refreshguestdata(eventid);
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        Get.offAll(
            transition: Transition.leftToRightWithFade,
            //     allowSnapshotting: false,
            fullscreenDialog: true,
            ViewEvent(eventModel: eventModel));
      },
      child: Scaffold(
        appBar: CustomAppBar(
          leading: () {
            Get.offAll(
                transition: Transition.leftToRightWithFade,
                //     allowSnapshotting: false,
                fullscreenDialog: true,
                ViewEvent(eventModel: eventModel));
          },
          actions: const [],
          titleText: 'Report',
        ),
        body: Padding(
          padding: EdgeInsets.all(1.h),
          child: Column(
            children: [
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 4,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: buttoncolor, width: 1),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    children: [
                      ListTile(
                        leading: Image(
                          image:
                              const AssetImage('assets/UI/icons/Task List.png'),
                          height: 10.h,
                        ),
                        title: Text(
                          'Task List',
                          style: raleway(color: Colors.black),
                        ),
                        subtitle: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () {
                                Get.to(
                                    transition: Transition.rightToLeftWithFade,
                                    DoneRpTaskList(eventModel: eventModel));
                              },
                              child: ValueListenableBuilder(
                                builder: (context, value, child) => Text(
                                  'Completed : ${value.length} ',
                                  style: readexPro(
                                    color: Colors.green,
                                    fontSize: 11.sp,
                                  ),
                                ),
                                valueListenable: doneRpTaskList,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Get.to(
                                    transition: Transition.rightToLeftWithFade,
                                    PendingRpTaskList(eventModel: eventModel));
                              },
                              child: ValueListenableBuilder(
                                  builder: (context, value, child) => Text(
                                        'Pending : ${value.length} ',
                                        style: readexPro(
                                          color: Colors.red,
                                          fontSize: 11.sp,
                                        ),
                                      ),
                                  valueListenable: pendingRpTaskList),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 4,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: buttoncolor, width: 1),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    children: [
                      ListTile(
                        leading: Image(
                          image: const AssetImage('assets/UI/icons/Guests.png'),
                          height: 10.h,
                        ),
                        title: Text(
                          'Guests',
                          style: raleway(color: Colors.black),
                        ),
                        subtitle: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () {
                                Get.to(
                                    transition: Transition.rightToLeftWithFade,
                                    DoneRpGuests(eventModel: eventModel));
                              },
                              child: ValueListenableBuilder(
                                  builder: (context, value, child) => Text(
                                        'Completed : ${value.length} ',
                                        style: readexPro(
                                          color: Colors.green,
                                          fontSize: 11.sp,
                                        ),
                                      ),
                                  valueListenable: guestDonelist),
                            ),
                            InkWell(
                              onTap: () {
                                Get.to(
                                    transition: Transition.rightToLeftWithFade,
                                    PendingRpGuests(eventModel: eventModel));
                              },
                              child: ValueListenableBuilder(
                                  builder: (context, value, child) => Text(
                                        'Pending : ${value.length} ',
                                        style: readexPro(
                                          color: Colors.red,
                                          fontSize: 11.sp,
                                        ),
                                      ),
                                  valueListenable: guestPendinglist),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 4,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: buttoncolor, width: 1),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    children: [
                      ListTile(
                        leading: Image(
                          image: const AssetImage('assets/UI/icons/budget.png'),
                          height: 10.h,
                        ),
                        title: Text(
                          'Budget',
                          style: raleway(color: Colors.black),
                        ),
                        subtitle: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () {
                                Get.to(
                                    transition: Transition.rightToLeftWithFade,
                                    DoneRpBudget(eventModel: eventModel));
                              },
                              child: ValueListenableBuilder(
                                  builder: (context, value, child) => Text(
                                        'Completed : ${value.length} ',
                                        style: readexPro(
                                          color: Colors.green,
                                          fontSize: 11.sp,
                                        ),
                                      ),
                                  valueListenable: budgetDonelist),
                            ),
                            InkWell(
                              onTap: () {
                                Get.to(
                                    transition: Transition.rightToLeftWithFade,
                                    PendingRpBudget(eventModel: eventModel));
                              },
                              child: ValueListenableBuilder(
                                  builder: (context, value, child) => Text(
                                        'Pending : ${value.length} ',
                                        style: readexPro(
                                          color: Colors.red,
                                          fontSize: 11.sp,
                                        ),
                                      ),
                                  valueListenable: budgetPendinglist),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 4,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: buttoncolor, width: 1),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    children: [
                      ListTile(
                        leading: Image(
                          image:
                              const AssetImage('assets/UI/icons/vendors.png'),
                          height: 10.h,
                        ),
                        title: Text(
                          'Vendors',
                          style: raleway(color: Colors.black),
                        ),
                        subtitle: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () {
                                Get.to(
                                    transition: Transition.rightToLeftWithFade,
                                    DoneRpVendorList(eventModel: eventModel));
                              },
                              child: ValueListenableBuilder(
                                  builder: (context, value, child) => Text(
                                        'Completed : ${value.length} ',
                                        style: readexPro(
                                          color: Colors.green,
                                          fontSize: 11.sp,
                                        ),
                                      ),
                                  valueListenable: vendorDonelist),
                            ),
                            InkWell(
                              onTap: () {
                                Get.to(
                                    transition: Transition.rightToLeftWithFade,
                                    PendingRpVendorList(
                                        eventModel: eventModel));
                              },
                              child: ValueListenableBuilder(
                                  builder: (context, value, child) => Text(
                                        'Pending : ${value.length} ',
                                        style: readexPro(
                                          color: Colors.red,
                                          fontSize: 11.sp,
                                        ),
                                      ),
                                  valueListenable: vendorPendinglist),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
