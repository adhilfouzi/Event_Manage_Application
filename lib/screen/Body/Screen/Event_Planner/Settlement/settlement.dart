import 'package:flutter/material.dart';
import 'package:project_event/Core/Color/font.dart';
import 'package:project_event/Database/functions/fn_paymentdetail.dart';
import 'package:project_event/Database/functions/fn_paymodel.dart';
import 'package:project_event/screen/Body/Screen/Event_Planner/Settlement/budget_settelment.dart';
import 'package:project_event/screen/Body/Screen/Event_Planner/Settlement/income_settelment.dart';
import 'package:project_event/screen/Body/Screen/Event_Planner/Settlement/vendor_settlement.dart';
import 'package:project_event/screen/Body/widget/Scaffold/app_bar.dart';

class Settlement extends StatelessWidget {
  final int eventID;

  const Settlement({super.key, required this.eventID});
  @override
  Widget build(BuildContext context) {
    refreshPaymentData(eventID);
    refreshmainbalancedata(eventID);
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 150,
          backgroundColor: Colors.transparent,
          actions: [
            AppAction(icon: Icons.search, onPressed: () {}),
            AppAction(icon: Icons.more_vert, onPressed: () {}),
          ],
          title: Text(
            'Settlement',
            style: racingSansOne(
                fontWeight: FontWeight.w500, fontSize: 22, color: Colors.black),
          ),
          bottom: PreferredSize(
            preferredSize: const Size(double.infinity, 40),
            child: Column(
              children: [
                Container(
                  height: 80,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: ValueListenableBuilder(
                    valueListenable: mainbalance,
                    builder: (context, value, child) {
                      return Card(
                        elevation: 4,
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Expenses',
                                    style: readexPro(
                                        fontWeight: FontWeight.normal),
                                  ),
                                  Text(
                                    '₹${value.paid.toString()}',
                                    style: readexPro(
                                        color: Colors.red,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            ),
                            const VerticalDivider(
                              endIndent: 15,
                              indent: 15,
                              width: 1,
                              thickness: 2,
                              color: Colors.black,
                            ),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Credit',
                                    style: readexPro(
                                        fontWeight: FontWeight.normal),
                                  ),
                                  Text(
                                    '₹${value.pending.toString()}',
                                    style: readexPro(
                                        color: Colors.green,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            ),
                            const VerticalDivider(
                              endIndent: 15,
                              indent: 15,
                              width: 1,
                              thickness: 2,
                              color: Colors.black,
                            ),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Balance',
                                    style: readexPro(
                                        fontWeight: FontWeight.normal),
                                  ),
                                  Text(
                                    '₹${value.total.toString()}',
                                    style: readexPro(
                                        color: Colors.green,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                const TabBar(
                  tabs: [
                    Tab(text: 'Budget'),
                    Tab(text: 'Vendor'),
                    Tab(text: 'Income'),
                  ],
                  unselectedLabelColor: Colors.black45,
                  labelColor: Colors.black,
                  dividerColor: Colors.transparent,
                  indicatorColor: Colors.black,
                ),
              ],
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: TabBarView(
            children: [
              BudgetSettlement(
                eventID: eventID,
              ),
              VendorSettlement(
                eventID: eventID,
              ),
              IncomeSettlement(
                eventID: eventID,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
