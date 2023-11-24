import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project_event/Core/Color/color.dart';
import 'package:project_event/Core/Color/font.dart';
import 'package:sizer/sizer.dart';

class Time extends StatefulWidget {
  final TextEditingController? controller;
  final String? textdate;
  final String? defaultdata;

  const Time({Key? key, this.controller, this.textdate, this.defaultdata})
      : super(key: key);

  @override
  State<Time> createState() => _TimeState();
}

class _TimeState extends State<Time> {
  late DateTime selectedTime;

  @override
  void initState() {
    super.initState();

    if (widget.defaultdata != null) {
      selectedTime = _parseTime(widget.defaultdata!);
    } else {
      selectedTime = DateTime.now();
    }

    if (widget.controller != null) {
      widget.controller!.text = _formatTime(selectedTime);
    }
  }

  DateTime _parseTime(String time) {
    try {
      return DateFormat('HH:mm').parse(time);
    } catch (e) {
      print("Error parsing time: $e");
      return DateTime.now();
    }
  }

  String _formatTime(DateTime time) {
    // Use 'hh:mm a' to display time in 12-hour format with AM/PM
    return DateFormat('hh:mm a').format(time);
  }

  Future<void> _selectTime(BuildContext context) async {
    // Set the dayPeriodTextColor for AM/PM color
    TimePickerThemeData timePickerTheme = TimePickerTheme.of(context);
    timePickerTheme =
        timePickerTheme.copyWith(dayPeriodTextColor: buttoncolor[700]);

    // Show the time picker
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(selectedTime),
    );

    if (picked != null) {
      setState(() {
        selectedTime = DateTime(
          selectedTime.year,
          selectedTime.month,
          selectedTime.day,
          picked.hour,
          picked.minute,
        );

        if (widget.controller != null) {
          widget.controller!.text = _formatTime(selectedTime);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(left: 2.h),
          child: Text(widget.textdate ?? 'Time', style: raleway()),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(1.h, 0.5.h, 1.h, 0.5.h),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: buttoncolor, width: 1),
              borderRadius: BorderRadius.circular(40.0),
            ),
            child: InkWell(
              onTap: () => _selectTime(context),
              child: TextFormField(
                readOnly: true,
                controller: widget.controller,
                decoration: InputDecoration(
                  iconColor: buttoncolor,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 1.h,
                    vertical: 1.h,
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.access_time,
                        size: 24, color: buttoncolor[700]),
                    onPressed: () => _selectTime(context),
                  ),
                  hintText: _formatTime(selectedTime),
                  hintStyle: const TextStyle(
                    color: Color.fromRGBO(0, 0, 0, 0.5),
                    fontFamily: 'ReadexPro',
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
