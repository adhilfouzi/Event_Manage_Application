import 'package:flutter/material.dart';
import 'package:project_event/Core/Color/font.dart';
import 'package:project_event/Database/functions/fn_paymodel.dart';

class PayDown extends StatefulWidget {
  final ValueChanged<String> onChanged;
  final String? defaultdata;
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
    selectedPay = widget.defaultdata ?? 'Budget';
    paymentTypeNotifier = ValueNotifier(PaymentType.budget);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 2, 10, 2),
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
