import 'package:flutter/material.dart';
import 'package:project_event/Core/Color/font.dart';

import 'package:project_event/screen/Body/widget/Scaffold/app_bar.dart';

import 'package:sizer/sizer.dart';

class Transaction extends StatefulWidget {
  final int profileid;

  const Transaction({super.key, required this.profileid});

  @override
  State<Transaction> createState() => _TransactionState();
}

class _TransactionState extends State<Transaction> {
  // late TabController tabController;
  // @override
  // void initState() {
  //   super.initState();
  //   tabController = TabController(length: 3, vsync: this);
  // }
  // final TextEditingController _dateController = TextEditingController();
  // final TextEditingController _todateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // tabController.index;
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 20.h,
          backgroundColor: Colors.transparent,
          actions: [
            AppAction(
              icon: Icons.search,
              onPressed: () {
                setState(() {
                  // var indexcount = tabController.index;
                  // if (indexcount == 0) {
                  //   Navigator.of(context).push(MaterialPageRoute(
                  //     builder: (context) => const BudgetSettlementSearch(),
                  //   ));
                  // } else if (indexcount == 1) {
                  //   Navigator.of(context).push(MaterialPageRoute(
                  //     builder: (context) => const VendorSettlementSearch(),
                  //   ));
                  // } else if (indexcount == 2) {
                  //   Navigator.of(context).push(MaterialPageRoute(
                  //     builder: (context) => const IncomeSearch(),
                  //   ));
                  // }
                });
              },
            ),
            SizedBox(
              width: 2.w,
            )
          ],
          title: Text(
            'Transaction history',
            style: racingSansOne(
                fontWeight: FontWeight.w500,
                fontSize: 20.sp,
                color: Colors.black),
          ),
          bottom: PreferredSize(
            preferredSize: Size(double.infinity, 0.h),
            child: Column(
              children: [
                // Todate(
                //   controller1: _dateController,
                //   controller2: _todateController,
                // ),
                TabBar(
                  // controller: tabController,
                  tabs: const [
                    Tab(text: 'Report'),
                    Tab(text: 'Expence'),
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
          // child: TabBarView(
          //   controller: tabController,
          //   children: [
          //     Hero(
          //       tag: 'budget_settlement_body', // Unique tag
          //       child: BudgetSettlement(
          //         eventID: widget.eventID,
          //       ),
          //     ),
          //     Hero(
          //       tag: 'vendor_settlement_body', // Unique tag
          //       child: VendorSettlement(
          //         eventID: widget.eventID,
          //       ),
          //     ),
          //     Hero(
          //       tag: 'income_settlement_body', // Unique tag
          //       child: IncomeSettlement(
          //         eventID: widget.eventID,
          //       ),
          //     ),
          //   ],
          // ),
        ),
      ),
    );
  }
}
