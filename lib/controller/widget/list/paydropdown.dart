import 'package:flutter/material.dart';
import 'package:project_event/model/core/font/font.dart';
import 'package:project_event/model/db_functions/fn_paymodel.dart';
import 'package:sizer/sizer.dart';

class PayDown extends StatefulWidget {
  final ValueChanged<String> onChanged;
  final int? defaultdata;
  const PayDown({Key? key, required this.onChanged, this.defaultdata})
      : super(key: key);

  @override
  State<PayDown> createState() => _PayDownState();
}

class _PayDownState extends State<PayDown> {
  String? selectedPay;

  @override
  void initState() {
    super.initState();
    if (widget.defaultdata != null) {
      paymentTypeNotifier.value =
          widget.defaultdata == 0 ? PaymentType.budget : PaymentType.vendor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(1.h, 0.2.h, 1.h, 0.2.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: PaymentType.values.map((paymentType) {
              return Row(
                children: [
                  Radio<PaymentType>(
                    value: paymentType,
                    groupValue: paymentTypeNotifier.value,
                    onChanged: (value) {
                      setState(() {
                        paymentTypeNotifier.value = value!;
                      });
                      widget.onChanged(value.toString().split('.').last);
                    },
                  ),
                  Text(
                    paymentType.toString().split('.').last,
                    style: raleway(color: Colors.black),
                  ),
                ],
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
