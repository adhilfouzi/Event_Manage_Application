import 'package:flutter/material.dart';
import 'package:project_event/Core/Color/font.dart';
import 'package:project_event/Database/functions/fn_paymentdetail.dart';
import 'package:project_event/Database/functions/fn_paymodel.dart';
import 'package:project_event/screen/Body/Screen/Event_Planner/Settlement/budget_settelment.dart';
import 'package:project_event/screen/Body/Screen/Event_Planner/Settlement/income_settelment.dart';
import 'package:project_event/screen/Body/Screen/Event_Planner/Settlement/vendor_settlement.dart';
import 'package:project_event/screen/Body/Screen/Search/settlement_search.dart';
import 'package:project_event/screen/Body/widget/Scaffold/app_bar.dart';
import 'package:sizer/sizer.dart';

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
          toolbarHeight: 16.h,
          backgroundColor: Colors.transparent,
          actions: [
            AppAction(
                icon: Icons.search,
                onPressed: () {
                  // var index = DefaultTabController.of(context).index;
                  // if (index == 1) {
                  //   Navigator.of(context).push(MaterialPageRoute(
                  //       builder: (context) =>
                  //           BudgetSettlement(eventID: eventID)));
                  // } else if (index == 2) {
                  //   Navigator.of(context).push(MaterialPageRoute(
                  //       builder: (context) =>
                  //           VendorSettlement(eventID: eventID)));
                  // } else if (index == 3) {
                  //   Navigator.of(context).push(MaterialPageRoute(
                  //       builder: (context) => const IncomeSearch()));
                  // }
                }),
            SizedBox(
              width: 2.h,
            )
            //  AppAction(icon: Icons.more_vert, onPressed: () {}),
          ],
          title: Text(
            'Settlement',
            style: racingSansOne(
                fontWeight: FontWeight.w500,
                fontSize: 20.sp,
                color: Colors.black),
          ),
          bottom: PreferredSize(
            preferredSize: Size(double.infinity, 4.h),
            child: Column(
              children: [
                Container(
                  height: 10.h,
                  padding: EdgeInsets.symmetric(horizontal: 1.5.h),
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
                                        fontSize: 11.sp,
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
                                        fontSize: 11.sp,
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
                                        fontSize: 11.sp,
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
          padding: EdgeInsets.all(1.h),
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
