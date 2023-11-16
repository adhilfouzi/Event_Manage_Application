import 'package:flutter/material.dart';
import 'package:project_event/Core/Color/font.dart';
import 'package:project_event/Database/functions/fn_paymodel.dart';
import 'package:project_event/screen/Body/Screen/Add/add_payments.dart';
import 'package:project_event/screen/Body/Screen/Event_Planner/Settlement/budget_settelment.dart';
import 'package:project_event/screen/Body/Screen/Event_Planner/Settlement/vendor_settlement.dart';
import 'package:project_event/screen/Body/widget/Scaffold/app_bar.dart';
import 'package:project_event/screen/Body/widget/Scaffold/floatingpointx.dart';

class Settlement extends StatelessWidget {
  final int eventID;

  const Settlement({super.key, required this.eventID});
  @override
  Widget build(BuildContext context) {
    refreshPaymentData(eventID);
    return DefaultTabController(
      length: 2,
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
                  child: Card(
                    elevation: 4,
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Expenses',
                                style: readexPro(fontWeight: FontWeight.normal),
                              ),
                              Text(
                                '₹72,000',
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
                                style: readexPro(fontWeight: FontWeight.normal),
                              ),
                              Text(
                                '₹100,000',
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
                                style: readexPro(fontWeight: FontWeight.normal),
                              ),
                              Text(
                                '+₹32,000',
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
                  ),
                ),
                const TabBar(
                  tabs: [
                    Tab(text: 'Budget'),
                    Tab(text: 'Vendor'),
                  ],
                  unselectedLabelColor: Colors.black,
                  dividerColor: Colors.transparent,
                ),
              ],
            ),
          ),
        ),
        body: const Padding(
          padding: EdgeInsets.all(10.0),
          child: TabBarView(
            children: [BudgetSettlement(), VendorSettlement()],
          ),
        ),
        floatingActionButton: FloatingPointx(
            goto: AddPayments(
          eventID: eventID,
        )),
      ),
    );
  }
}
