import 'package:flutter/material.dart';
import 'package:project_event/Core/Color/color.dart';
import 'package:project_event/Core/Color/font.dart';

class PaymentsBar extends StatelessWidget {
  const PaymentsBar({super.key});

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
              'Balance: 0',
              style: readexPro(fontSize: 18, fontWeight: FontWeight.normal),
            ),
            const Divider(color: buttoncolor, thickness: 1),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Pending:0',
                    style:
                        readexPro(fontSize: 18, fontWeight: FontWeight.normal)),
                Text('Paid: 0000',
                    style:
                        readexPro(fontSize: 18, fontWeight: FontWeight.normal))
              ],
            )
          ]),
    );
  }
}
