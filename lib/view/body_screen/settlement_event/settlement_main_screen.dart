import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_event/model/core/font/font.dart';
import 'package:project_event/model/db_functions/fn_paymentdetail.dart';
import 'package:project_event/model/db_functions/fn_paymodel.dart';
import 'package:project_event/model/data_model/event/event_model.dart';
import 'package:project_event/view/body_screen/settlement_event/payment/add_payments_screen.dart';
import 'package:project_event/view/body_screen/settlement_event/income/add_income_screen.dart';
import 'package:project_event/view/body_screen/settlement_event/payment/view_budget_payment_screen.dart';
import 'package:project_event/view/body_screen/settlement_event/income/income_settlement.dart';
import 'package:project_event/view/body_screen/settlement_event/payment/view_vendor_payment_screen.dart';
import 'package:project_event/view/body_screen/event/event_view_screen.dart';
import 'package:project_event/view/body_screen/settlement_event/search/search_budget_settlement_screen.dart';
import 'package:project_event/view/body_screen/settlement_event/search/search_income_settlement_screen.dart';
import 'package:project_event/view/body_screen/vendor_event/search_vendor_settlement_screen.dart';
import 'package:project_event/controller/widget/scaffold/app_bar.dart';

import 'package:sizer/sizer.dart';

class Settlement extends StatefulWidget {
  final int eventID;
  final Eventmodel eventModel;

  const Settlement(
      {super.key, required this.eventID, required this.eventModel});

  @override
  State<Settlement> createState() => _SettlementState();
}

class _SettlementState extends State<Settlement> with TickerProviderStateMixin {
  late TabController tabController;
  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    refreshPaymentData(widget.eventID);
    refreshmainbalancedata(widget.eventID);
    tabController.index;
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Get.offAll(
                  transition: Transition.leftToRightWithFade,
                  //     allowSnapshotting: false,
                  fullscreenDialog: true,
                  ViewEvent(eventModel: widget.eventModel))),
          toolbarHeight: 20.h,
          backgroundColor: Colors.transparent,
          actions: [
            AppAction(
              icon: Icons.search,
              onPressed: () {
                setState(() {
                  var indexcount = tabController.index;
                  if (indexcount == 0) {
                    Get.to(
                        transition: Transition.rightToLeftWithFade,
                        const BudgetSettlementSearch());
                  } else if (indexcount == 1) {
                    Get.to(
                        transition: Transition.rightToLeftWithFade,
                        const VendorSettlementSearch());
                  } else if (indexcount == 2) {
                    Get.to(
                        transition: Transition.rightToLeftWithFade,
                        const IncomeSearch());
                  }
                });
              },
            ),
            SizedBox(
              width: 2.w,
            )
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
                TabBar(
                  controller: tabController,
                  tabs: const [
                    Tab(text: 'Budget'),
                    Tab(text: 'Vendor'),
                    Tab(text: 'Income'),
                  ],
                  unselectedLabelColor: Colors.black45,
                  labelColor: Colors.black,
                  dividerColor: Colors.transparent,
                  indicatorColor: Colors.black,
                  // onTap: (index) {
                  //   print("Tab tapped: $index");

                  //   tabController.index = index;
                  // },
                ),
              ],
            ),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(1.h),
          child: TabBarView(
            controller: tabController,
            children: [
              Hero(
                tag: 'budget_settlement_body', // Unique tag
                child: BudgetSettlement(
                  eventID: widget.eventID,
                ),
              ),
              Hero(
                tag: 'vendor_settlement_body', // Unique tag
                child: VendorSettlement(
                  eventID: widget.eventID,
                ),
              ),
              Hero(
                tag: 'income_settlement_body', // Unique tag
                child: IncomeSettlement(
                  eventID: widget.eventID,
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: const Color(0xFF80B3FF),
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
          onPressed: () {
            var indexcount = tabController.index;
            if (indexcount == 0) {
              Get.to(
                  transition: Transition.rightToLeftWithFade,
                  AddPayments(eventID: widget.eventID));
            } else if (indexcount == 1) {
              Get.to(
                  transition: Transition.rightToLeftWithFade,
                  AddPayments(eventID: widget.eventID));
            } else if (indexcount == 2) {
              Get.to(
                  transition: Transition.rightToLeftWithFade,
                  AddIncome(
                    eventID: widget.eventID,
                  ));
            }
          },
        ),
      ),
    );
  }
}
