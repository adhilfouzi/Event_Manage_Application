import 'package:flutter/material.dart';
import 'package:project_event/Core/Color/color.dart';
import 'package:project_event/Core/Color/font.dart';

class StatusBar extends StatefulWidget {
  final String textcontent1;
  final Function(bool) onStatusChange;
  final String textcontent2;

  const StatusBar({
    super.key,
    required this.textcontent1,
    required this.textcontent2,
    required this.onStatusChange,
  });

  @override
  State<StatusBar> createState() => _StatusBarState();
}

class _StatusBarState extends State<StatusBar> {
  bool statusdata = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.only(left: 15),
          child: Text('Status', style: raleway()),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
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
              const SizedBox(width: 10),
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
    padding: const MaterialStatePropertyAll(EdgeInsets.symmetric(vertical: 12)),
    side: MaterialStateProperty.all(BorderSide.none),
    backgroundColor: MaterialStateProperty.all(buttoncolor[300]),
  );
  ButtonStyle two = ButtonStyle(
    padding: const MaterialStatePropertyAll(EdgeInsets.symmetric(vertical: 12)),
    side: MaterialStateProperty.all(
        const BorderSide(color: buttoncolor, width: 2.0)),
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
    padding: const MaterialStatePropertyAll(EdgeInsets.symmetric(vertical: 12)),
    side: MaterialStateProperty.all(BorderSide.none),
    backgroundColor: MaterialStateProperty.all(buttoncolor[300]),
  );
}

ButtonStyle secandcr() {
  return ButtonStyle(
    padding: const MaterialStatePropertyAll(EdgeInsets.symmetric(vertical: 12)),
    side: MaterialStateProperty.all(
        const BorderSide(color: buttoncolor, width: 2.0)),
    shape: MaterialStateProperty.all(RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(30.0),
    )),
  );
}
