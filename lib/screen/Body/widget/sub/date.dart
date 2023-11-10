import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project_event/Core/Color/color.dart';
import 'package:project_event/Core/Color/font.dart';

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
      return DateFormat('dd-MM-yyyy').parse(date);
    } catch (e) {
      print("Error parsing date: $e");
      return DateTime.now();
    }
  }

  String _formatDate(DateTime date) {
    return DateFormat('dd-MM-yyyy').format(date);
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
          padding: const EdgeInsets.only(left: 15),
          child: Text(widget.textdate ?? 'Date', style: raleway()),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: buttoncolor, width: 1),
              borderRadius: BorderRadius.circular(40.0),
            ),
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
                  icon: Icon(Icons.calendar_month,
                      size: 24, color: buttoncolor[700]),
                  onPressed: () => _selectDate(context),
                ),
                hintText: _formatDate(selectedDate!),
                hintStyle: const TextStyle(
                  color: Color.fromRGBO(0, 0, 0, 0.5),
                  fontFamily: 'ReadexPro',
                ),
                border: InputBorder.none,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
