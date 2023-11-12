import 'package:flutter/material.dart';
import 'package:project_event/Core/Color/font.dart';
import 'package:project_event/screen/Body/widget/List/list.dart';

class PayDown extends StatefulWidget {
  final ValueChanged<String?>? onChanged;
  final String? defaultdata;
  const PayDown({super.key, this.onChanged, this.defaultdata});

  @override
  State<PayDown> createState() => _PayDownState();
}

class _PayDownState extends State<PayDown> {
  String? selectedPay;

  @override
  void initState() {
    super.initState();
    selectedPay = widget.defaultdata ?? 'Budget';
    if (selectedPay!.isEmpty) {
      selectedPay = 'Budget';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 2, 10, 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Text('Budget', style: raleway()),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: pay.map((payOption) {
              return Row(
                children: [
                  Radio<String>(
                    value: payOption['text']!,
                    groupValue: selectedPay,
                    onChanged: (value) {
                      setState(() {
                        selectedPay = value;
                      });
                      widget.onChanged!(value);
                    },
                  ),
                  Text(
                    payOption['text']!,
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
