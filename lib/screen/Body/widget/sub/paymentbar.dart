import 'package:flutter/material.dart';
import 'package:project_event/Core/Color/color.dart';
import 'package:project_event/Core/Color/font.dart';

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
    return Container(
      padding: const EdgeInsets.all(15),
      height: 130,
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
              style: readexPro(fontSize: 18, fontWeight: FontWeight.normal),
            ),
            const Divider(color: buttoncolor, thickness: 1),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Pending: ₹$pending',
                    style:
                        readexPro(fontSize: 18, fontWeight: FontWeight.normal)),
                Text('Paid: ₹$paid',
                    style:
                        readexPro(fontSize: 18, fontWeight: FontWeight.normal))
              ],
            )
          ]),
    );
  }
}
