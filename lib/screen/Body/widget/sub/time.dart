import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project_event/Core/Color/color.dart';
import 'package:project_event/Core/Color/font.dart';

class Time extends StatefulWidget {
  final TextEditingController? controller;
  final String? textdate;
  final String? defaultdata;

  const Time({super.key, this.controller, this.textdate, this.defaultdata});

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
    return DateFormat('HH:mm').format(time);
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
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
          padding: const EdgeInsets.only(left: 15),
          child: Text(widget.textdate ?? 'Time', style: raleway()),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
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
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 10,
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
