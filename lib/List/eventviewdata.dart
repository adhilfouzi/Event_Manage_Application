// import 'package:flutter/material.dart';
// import 'package:project_event/Database/functions/fn_budgetmodel.dart';
// import 'package:project_event/Database/functions/fn_guestmodel.dart';
// import 'package:project_event/Database/functions/fn_taskmodel.dart';
// import 'package:project_event/Database/functions/fn_vendormodel.dart';
// import 'package:project_event/screen/Body/Screen/Report/Budget/done_budget.dart';
// import 'package:project_event/screen/Body/Screen/Report/Budget/pending_buget.dart';
// import 'package:project_event/screen/Body/Screen/Report/Guest_Rp/guests_done_rp.dart';
// import 'package:project_event/screen/Body/Screen/Report/Guest_Rp/guests_pending_rp.dart';
// import 'package:project_event/screen/Body/Screen/Report/Task/done_taskRp.dart';
// import 'package:project_event/screen/Body/Screen/Report/Task/pending_taskRp.dart';
// import 'package:project_event/screen/Body/Screen/Report/Vendor/done_vendor.dart';

// import 'package:project_event/screen/Body/Screen/Report/Vendor/pending_vendors.dart';
// import 'package:project_event/screen/Body/Screen/main/home_screen.dart';
// var data=eventdata;
// final List<Map<String, dynamic>> cardData = [
//   {
//     // 'color': const Color.fromRGBO(227, 100, 136, 1),
//     'image': const AssetImage('assets/UI/icons/Task List.png'),
//     'text': 'Task List',
//     // 'link': 'TaskList()',
//     'report': () => const DoneRpTaskList(),
//     'reportP': () => const PendingRpTaskList(),
//     'done': doneRpTaskList,
//     'pending': pendingRpTaskList
//   },
//   {
//     // 'color': const Color.fromRGBO(234, 28, 140, 1),
//     'image': const AssetImage('assets/UI/icons/Guests.png'),
//     'text': 'Guests',
//     // 'link': 'Guests()',
//     'report': () => const DoneRpGuests(),
//     'reportP': () => const PendingRpGuests(),
//     'done': guestDonelist,
//     'pending': guestPendinglist
//   },
//   {
//     // 'color': const Color.fromRGBO(211, 234, 43, 1),
//     'image': const AssetImage('assets/UI/icons/budget.png'),
//     'text': 'Budget',
//     // 'link': 'Budget()',
//     'report': () =>  DoneRpBudget(eventModel: eventdata.),
//     'reportP': () =>  PendingRpBudget(),
//     'done': budgetDonelist,
//     'pending': budgetPendinglist
//   },
//   {
//     // 'color': const Color.fromRGBO(250, 166, 68, 1),
//     'image': const AssetImage('assets/UI/icons/vendors.png'),
//     'text': 'Vendors',
//     // 'link': 'const Vendors()',
//     'report': () => const DoneRpVendorList(),
//     'reportP': () => const PendingRpVendorList(),
//     'done': vendorDonelist,
//     'pending': vendorPendinglist
//   },
//   {
//     // 'color': const Color.fromRGBO(129, 236, 114, 1),
//     'image': const AssetImage('assets/UI/icons/report.png'),
//     'text': 'Report',
//     // 'link': 'Report()',
//   },
//   {
//     // 'color': const Color.fromRGBO(67, 229, 181, 1),
//     'image': const AssetImage('assets/UI/icons/settlement.png'),
//     'text': 'Settlement',
//     // 'link': 'Settlement()',
//   },
// ];
