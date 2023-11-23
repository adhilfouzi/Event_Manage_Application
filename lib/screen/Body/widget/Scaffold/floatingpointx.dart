import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class FloatingPointx extends StatelessWidget {
  final Widget goto;
  const FloatingPointx({super.key, required this.goto});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(3.h),
      child: FloatingActionButton(
        tooltip: 'increment',
        backgroundColor: const Color(0xFF80B3FF),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => goto));
        },
      ),
    );
  }
}
