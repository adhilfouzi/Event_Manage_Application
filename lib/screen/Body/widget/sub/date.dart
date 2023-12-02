import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project_event/Core/Color/color.dart';
import 'package:project_event/Core/Color/font.dart';
import 'package:sizer/sizer.dart';

class Date extends StatefulWidget {
  final TextEditingController? controller;
  final String? textdate;
  final String? defaultdata;

  const Date({
    super.key,
    this.controller,
    this.textdate,
    this.defaultdata,
  });

  @override
  State<Date> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Date> {
  DateTime? selectedDate;
  @override
  void initState() {
    super.initState();

    if (widget.defaultdata != null) {
      selectedDate = _parseDate(widget.defaultdata!);
    } else {
      selectedDate = DateTime.now();
    }

    if (widget.controller != null) {
      widget.controller!.text = _formatDate(selectedDate!);
    }
  }

  DateTime _parseDate(String date) {
    try {
      return DateFormat('dd-MMMM-yyyy', 'en_US').parse(date);
    } catch (e) {
      print("Error parsing date: $e");
      return DateTime.now();
    }
  }

  String _formatDate(DateTime date) {
    return DateFormat('dd-MMMM-yyyy', 'en_US').format(date);
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = (await showDatePicker(
          context: context,
          initialDate: selectedDate!,
          firstDate: DateTime(2000),
          lastDate: DateTime(2101),
        )) ??
        selectedDate!;

    setState(() {
      selectedDate = picked;
      if (widget.controller != null) {
        widget.controller!.text = _formatDate(selectedDate!);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(left: 2.h),
          child: Text(widget.textdate ?? 'Date', style: raleway()),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(1.h, 0.5.h, 1.h, 0.5.h),
          child: TextFormField(
            readOnly: true,
            controller: widget.controller,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(40.0),
                borderSide: BorderSide(
                  color: graylight,
                  width: 0.4.w,
                ),
              ),
              filled: true, // Set filled to true
              fillColor: Colors.black12,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(40.0),
                borderSide: BorderSide(
                  color: Colors.black,
                  width: 0.4.w,
                ),
              ),
              iconColor: buttoncolor,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 1.h,
                vertical: 1.h,
              ),
              suffixIcon: IconButton(
                icon: Icon(Icons.calendar_month,
                    size: 20.sp, color: buttoncolor[700]),
                onPressed: () => _selectDate(context),
              ),
              hintText: _formatDate(selectedDate!),
              hintStyle: const TextStyle(
                color: Color.fromRGBO(0, 0, 0, 0.5),
                fontFamily: 'ReadexPro',
              ),
            ),
          ),
        ),
      ],
    );
  }
}
