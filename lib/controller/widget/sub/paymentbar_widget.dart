import 'package:flutter/material.dart';
import 'package:project_event/model/core/color/color.dart';
import 'package:project_event/model/core/font/font.dart';
import 'package:sizer/sizer.dart';

class PaymentsBar extends StatelessWidget {
  final String eAmount;
  final String pending;
  final String paid;

  const PaymentsBar(
      {super.key,
      required this.eAmount,
      required this.pending,
      required this.paid});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(1.h),
      child: Container(
        padding: EdgeInsets.all(1.5.h),
        height: 15.h,
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(color: buttoncolor, width: 1),
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Amount: ₹$eAmount',
                style:
                    readexPro(fontSize: 13.sp, fontWeight: FontWeight.normal),
              ),
              const Divider(color: buttoncolor, thickness: 1),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Pending: ₹$pending',
                      style: readexPro(
                          fontSize: 13.sp, fontWeight: FontWeight.normal)),
                  Text('Paid: ₹$paid',
                      style: readexPro(
                          fontSize: 13.sp, fontWeight: FontWeight.normal))
                ],
              )
            ]),
      ),
    );
  }
}
