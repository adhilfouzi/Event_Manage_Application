import 'package:flutter/material.dart';

import 'package:project_event/screen/Body/Screen/Report/report_buget.dart';
import 'package:project_event/screen/Body/Screen/Report/report_guests.dart';
import 'package:project_event/screen/Body/Screen/Report/report_task.dart';
import 'package:project_event/screen/Body/Screen/Report/report_vendors.dart';

final List<Map<String, dynamic>> cardData = [
  {
    'color': const Color.fromRGBO(227, 100, 136, 1),
    'image': const AssetImage('assets/UI/icons/Task List.png'),
    'text': 'Task List',
    'link': 'TaskList()',
    'report': () => const RpTaskList(),
  },
  {
    'color': const Color.fromRGBO(234, 28, 140, 1),
    'image': const AssetImage('assets/UI/icons/Guests.png'),
    'text': 'Guests',
    'link': 'Guests()',
    'report': () => const RpGuests(),
  },
  {
    'color': const Color.fromRGBO(211, 234, 43, 1),
    'image': const AssetImage('assets/UI/icons/budget.png'),
    'text': 'Budget',
    'link': 'Budget()',
    'report': () => const RpBudget(),
  },
  {
    'color': const Color.fromRGBO(250, 166, 68, 1),
    'image': const AssetImage('assets/UI/icons/vendors.png'),
    'text': 'Vendors',
    'link': 'const Vendors()',
    'report': () => const RpVendors(),
  },
  {
    'color': const Color.fromRGBO(129, 236, 114, 1),
    'image': const AssetImage('assets/UI/icons/report.png'),
    'text': 'Report',
    'link': 'Report()',
  },
  {
    'color': const Color.fromRGBO(67, 229, 181, 1),
    'image': const AssetImage('assets/UI/icons/settlement.png'),
    'text': 'Settlement',
    'link': 'Settlement()',
  },
];
