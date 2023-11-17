import 'package:flutter/material.dart';

class FloatingPointx extends StatelessWidget {
  final Widget goto;
  const FloatingPointx({super.key, required this.goto});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
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
