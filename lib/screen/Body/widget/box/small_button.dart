import 'package:flutter/material.dart';
import 'package:project_event/Core/Color/color.dart';

class SmallButton extends StatelessWidget {
  final String textdata;
  const SmallButton({super.key, required this.textdata});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {},
      style: ButtonStyle(
          backgroundColor:
              MaterialStatePropertyAll(appbarcolor.withOpacity(0.2))),
      child: Text(
        textdata,
        style: const TextStyle(color: Colors.black, fontSize: 12),
      ),
    );
  }
}
