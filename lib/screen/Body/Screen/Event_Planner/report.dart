import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_event/core/color/color.dart';
import 'package:project_event/core/color/font.dart';
import 'package:project_event/database/functions/fn_budgetmodel.dart';
import 'package:project_event/database/functions/fn_guestmodel.dart';
import 'package:project_event/database/functions/fn_taskmodel.dart';
import 'package:project_event/database/functions/fn_vendormodel.dart';
import 'package:project_event/database/model/event/event_model.dart';
import 'package:project_event/screen/body/screen/main/event/viewevent.dart';
import 'package:project_event/screen/body/screen/report/budget/done_budget.dart';
import 'package:project_event/screen/body/screen/report/budget/pending_buget.dart';
import 'package:project_event/screen/body/screen/report/guest_rp/guests_done_rp.dart';
import 'package:project_event/screen/body/screen/report/guest_rp/guests_pending_rp.dart';
import 'package:project_event/screen/body/screen/report/task/done_task_rp.dart';
import 'package:project_event/screen/body/screen/report/task/pending_task_rp.dart';
import 'package:project_event/screen/body/screen/report/vendor/done_vendor.dart';
import 'package:project_event/screen/body/screen/report/vendor/pending_vendors.dart';
import 'package:project_event/screen/body/widget/scaffold/app_bar.dart';

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
            //     allowSnapshotting: false,
            fullscreenDialog: true,
            ViewEvent(eventModel: eventModel));
      },
      child: Scaffold(
        appBar: CustomAppBar(
          leading: () {
            Get.offAll(
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
                                Get.to(DoneRpTaskList(eventModel: eventModel));
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
                                Get.to(DoneRpGuests(eventModel: eventModel));
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
                                Get.to(PendingRpGuests(eventModel: eventModel));
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
                                Get.to(DoneRpBudget(eventModel: eventModel));
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
                                Get.to(PendingRpBudget(eventModel: eventModel));
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
                                Get.to(PendingRpVendorList(
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
