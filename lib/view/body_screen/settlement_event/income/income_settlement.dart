import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_event/model/core/color/color.dart';
import 'package:project_event/model/core/font/font.dart';
import 'package:project_event/model/db_functions/fn_incomemodel.dart';
import 'package:project_event/view/body_screen/settlement_event/income/edit_income_screen.dart';

import 'package:sizer/sizer.dart';

class IncomeSettlement extends StatelessWidget {
  final int eventID;

  const IncomeSettlement({super.key, required this.eventID});

  @override
  Widget build(BuildContext context) {
    refreshincomedata(eventID);
    return SafeArea(
      child: Scaffold(
        body: ValueListenableBuilder(
          valueListenable: incomePaymentList,
          builder: (context, value, child) {
            if (value.isNotEmpty) {
              return ListView.builder(
                itemCount: value.length,
                itemBuilder: (BuildContext context, int index) {
                  final data = value[index];
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 4,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: buttoncolor, width: 1),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: ListTile(
                        onTap: () {
                          Get.to(
                              transition: Transition.rightToLeftWithFade,
                              EditIncome(paydata: data));
                        },
                        leading: Image.asset(
                          'assets/UI/icons/person.png',
                        ),
                        title: Text(
                          data.name,
                          style: raleway(color: Colors.black),
                        ),
                        subtitle: Text(
                          'Paid on ${data.date} ${data.time}',
                          style: readexPro(
                            color: Colors.black45,
                            fontSize: 6.sp,
                          ),
                        ),
                        trailing: Text(
                          "₹${data.pyamount}",
                          style: racingSansOne(
                              color: Colors.black54,
                              fontWeight: FontWeight.normal),
                        ),
                      ),
                    ),
                  );
                },
              );
            } else {
              return Center(
                child: Text(
                  'No Income Payment available',
                  style: TextStyle(fontSize: 15.sp),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
