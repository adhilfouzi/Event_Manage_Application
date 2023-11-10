import 'package:flutter/material.dart';
import 'package:project_event/Core/Color/font.dart';

class ViewBox extends StatelessWidget {
  final String textcontent;
  final String controller;

  const ViewBox(
      {super.key, required this.textcontent, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 15, right: 15),
      alignment: Alignment.centerLeft,
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          // crossAxisAlignment: ,
          children: [
            Expanded(
              child: Container(
                alignment: Alignment.centerLeft,
                child: Text('$textcontent : ',
                    style: raleway(
                      color: Colors.black,
                      fontSize: 16,
                    )),
              ),
            ),
            Expanded(
              child: Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  controller.isNotEmpty == true ? controller : '-',
                  style: readexPro(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
              ),
            )
          ]),
    );
  }
}
