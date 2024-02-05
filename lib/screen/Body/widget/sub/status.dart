import 'package:flutter/material.dart';
import 'package:project_event/core/color/color.dart';
import 'package:project_event/core/color/font.dart';
import 'package:sizer/sizer.dart';

class StatusBar extends StatefulWidget {
  final String textcontent1;
  final Function(bool) onStatusChange;
  final String textcontent2;
  final bool? defaultdata;

  const StatusBar({
    super.key,
    required this.textcontent1,
    required this.textcontent2,
    required this.onStatusChange,
    this.defaultdata,
  });

  @override
  State<StatusBar> createState() => _StatusBarState();
}

class _StatusBarState extends State<StatusBar> {
  late bool statusdata;
  @override
  void initState() {
    super.initState();
    statusdata = widget.defaultdata ?? false;
    updateButtonStyles();
  }

  void updateButtonStyles() {
    one = statusdata == false ? firstcr() : secandcr();
    two = statusdata == true ? firstcr() : secandcr();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(left: 1.2.h),
          child: Text('Status', style: raleway()),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(1.h, 0.5.h, 1.h, 0.5.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: ElevatedButton(
                    style: one,
                    onPressed: () {
                      statusdata = false;
                      widget.onStatusChange(statusdata);
                      oneclick();
                    },
                    child: Text(
                      widget.textcontent1,
                      style: readexPro(),
                    )),
              ),
              SizedBox(width: 1.h),
              Expanded(
                child: ElevatedButton(
                    style: two,
                    onPressed: () {
                      statusdata = true;
                      widget.onStatusChange(statusdata);
                      twoclick();
                    },
                    child: Text(
                      widget.textcontent2,
                      style: readexPro(),
                    )),
              ),
            ],
          ),
        ),
      ],
    );
  }

  ButtonStyle one = ButtonStyle(
    padding: MaterialStatePropertyAll(EdgeInsets.symmetric(vertical: 1.h)),
    side: MaterialStateProperty.all(BorderSide.none),
    backgroundColor: MaterialStateProperty.all(buttoncolor[300]),
  );
  ButtonStyle two = ButtonStyle(
    padding: MaterialStatePropertyAll(EdgeInsets.symmetric(vertical: 1.h)),
    side:
        MaterialStateProperty.all(BorderSide(color: buttoncolor, width: 0.2.h)),
    shape: MaterialStateProperty.all(RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(30.0),
    )),
  );

  void oneclick() {
    setState(() {
      one = firstcr();
      two = secandcr();
    });
  }

  void twoclick() {
    setState(() {
      two = firstcr();
      one = secandcr();
    });
  }
}

ButtonStyle firstcr() {
  return ButtonStyle(
    padding: MaterialStatePropertyAll(EdgeInsets.symmetric(vertical: 1.h)),
    side: MaterialStateProperty.all(BorderSide.none),
    backgroundColor: MaterialStateProperty.all(buttoncolor[300]),
  );
}

ButtonStyle secandcr() {
  return ButtonStyle(
    padding: MaterialStatePropertyAll(EdgeInsets.symmetric(vertical: 1.h)),
    side: MaterialStateProperty.all(
        const BorderSide(color: buttoncolor, width: 2.0)),
    shape: MaterialStateProperty.all(RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(30.0),
    )),
  );
}
