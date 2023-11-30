import 'package:flutter/material.dart';
import 'package:project_event/Core/Color/color.dart';
import 'package:project_event/Core/Color/font.dart';
import 'package:project_event/Database/functions/fn_budgetmodel.dart';
import 'package:project_event/Database/functions/fn_guestmodel.dart';
import 'package:project_event/Database/functions/fn_taskmodel.dart';
import 'package:project_event/Database/functions/fn_vendormodel.dart';
import 'package:project_event/Database/model/Event/event_model.dart';
import 'package:project_event/screen/Body/Screen/Report/Budget/done_budget.dart';
import 'package:project_event/screen/Body/Screen/Report/Budget/pending_buget.dart';
import 'package:project_event/screen/Body/Screen/Report/Guest_Rp/guests_done_rp.dart';
import 'package:project_event/screen/Body/Screen/Report/Guest_Rp/guests_pending_rp.dart';
import 'package:project_event/screen/Body/Screen/Report/Task/done_taskRp.dart';
import 'package:project_event/screen/Body/Screen/Report/Task/pending_taskRp.dart';
import 'package:project_event/screen/Body/Screen/Report/Vendor/done_vendor.dart';
import 'package:project_event/screen/Body/Screen/Report/Vendor/pending_vendors.dart';
import 'package:project_event/screen/Body/Screen/main/Event/viewevent.dart';
import 'package:project_event/screen/Body/widget/Scaffold/app_bar.dart';
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
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
              builder: (context) => ViewEvent(eventModel: eventModel)),
          (route) => false,
        );
        return false;
      },
      child: Scaffold(
        appBar: CustomAppBar(
          leading: () {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => ViewEvent(eventModel: eventModel),
              ),
              (route) => false,
            );
          },
          actions: [],
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
                          image: AssetImage('assets/UI/icons/Task List.png'),
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
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        DoneRpTaskList(eventModel: eventModel),
                                  ),
                                );
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
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => PendingRpTaskList(
                                        eventModel: eventModel),
                                  ),
                                );
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
                          image: AssetImage('assets/UI/icons/Guests.png'),
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
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        DoneRpGuests(eventModel: eventModel),
                                  ),
                                );
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
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        PendingRpGuests(eventModel: eventModel),
                                  ),
                                );
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
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        DoneRpBudget(eventModel: eventModel),
                                  ),
                                );
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
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        PendingRpBudget(eventModel: eventModel),
                                  ),
                                );
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
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => DoneRpVendorList(
                                        eventModel: eventModel),
                                  ),
                                );
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
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => PendingRpVendorList(
                                        eventModel: eventModel),
                                  ),
                                );
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
