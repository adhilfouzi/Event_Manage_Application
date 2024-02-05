import 'package:flutter/material.dart';
import 'package:project_event/core/color/font.dart';
import 'package:project_event/screen/body/widget/list/list.dart';
import 'package:sizer/sizer.dart';

class SexDown extends StatefulWidget {
  final ValueChanged<String?>? onChanged;
  final String? defaultdata;
  const SexDown({super.key, this.onChanged, this.defaultdata});

  @override
  State<SexDown> createState() => _SexDownState();
}

class _SexDownState extends State<SexDown> {
  String? selectedSex;

  @override
  void initState() {
    super.initState();
    selectedSex = widget.defaultdata ?? 'Male';
    if (selectedSex!.isEmpty) {
      selectedSex = 'Male';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(1.h, 0.2.h, 1.h, 0.2.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Sex', style: raleway()),
          Row(
            children: sex.map((sexOption) {
              return Row(
                children: [
                  Radio<String>(
                    value: sexOption['text']!,
                    groupValue: selectedSex,
                    onChanged: (value) {
                      setState(() {
                        selectedSex = value;
                      });
                      widget.onChanged!(value);
                    },
                  ),
                  Text(
                    sexOption['text']!,
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
