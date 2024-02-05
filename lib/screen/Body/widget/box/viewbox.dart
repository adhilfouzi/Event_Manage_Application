import 'package:flutter/material.dart';
import 'package:project_event/core/color/font.dart';
import 'package:sizer/sizer.dart';

class ViewBox extends StatelessWidget {
  final String textcontent;
  final String controller;

  const ViewBox(
      {super.key, required this.textcontent, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          EdgeInsets.only(left: 1.5.h, right: 1.5.h, bottom: 0.5.h, top: 0),
      alignment: Alignment.centerLeft,
      child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          // crossAxisAlignment: ,
          children: [
            Expanded(
              child: Container(
                alignment: Alignment.centerLeft,
                child: Text('$textcontent : ',
                    style: raleway(
                      color: Colors.black,
                      fontSize: 10.sp,
                    )),
              ),
            ),
            Expanded(
              child: Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  controller.isNotEmpty == true ? controller : '-',
                  style: readexPro(
                    fontSize: 10.sp,
                    color: Colors.black,
                  ),
                ),
              ),
            )
          ]),
    );
  }
}

class ViewBoxAccommodation extends StatelessWidget {
  final String? textcontent;
  final String controller;

  const ViewBoxAccommodation(
      {super.key, this.textcontent, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          EdgeInsets.only(left: 1.5.h, right: 1.5.h, bottom: 0.5.h, top: 0),
      alignment: Alignment.centerLeft,
      child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Container(
                alignment: Alignment.centerLeft,
                child: Text('$textcontent : ',
                    style: raleway(
                      color: Colors.black,
                      fontSize: 12.sp,
                    )),
              ),
            ),
            Expanded(
              child: Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  controller.isNotEmpty == true ? controller : 'Accommodation',
                  style: readexPro(
                    fontSize: 12.sp,
                    color: Colors.black,
                  ),
                ),
              ),
            )
          ]),
    );
  }
}
