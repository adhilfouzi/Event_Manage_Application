import 'package:flutter/material.dart';
import 'package:project_event/Core/Color/font.dart';
import 'package:project_event/screen/Body/widget/List/list.dart';

class SexDown extends StatefulWidget {
  final ValueChanged<String?>? onChanged;

  const SexDown({super.key, this.onChanged});

  @override
  State<SexDown> createState() => _SexDownState();
}

class _SexDownState extends State<SexDown> {
  String? selectedSex;

  @override
  void initState() {
    super.initState();
    selectedSex = 'Male';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 2, 10, 2),
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
