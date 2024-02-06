import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

class Todate extends StatefulWidget {
  final TextEditingController? controller1; // Controller for the first date
  final TextEditingController? controller2; // Controller for the second date
  final String? defaultdata;
  const Todate(
      {super.key, this.controller1, this.controller2, this.defaultdata});

  @override
  State<Todate> createState() => _TodateState();
}

class _TodateState extends State<Todate> {
  DateTime? selectedDate1;
  DateTime? selectedDate2;

  @override
  void initState() {
    super.initState();

    if (widget.defaultdata != null) {
      selectedDate1 = _parseDate(widget.defaultdata!);
    } else {
      selectedDate1 = DateTime.now();
    }
    selectedDate2 = DateTime.now(); // Set initial value for the second date

    if (widget.controller1 != null) {
      widget.controller1!.text = _formatDate(selectedDate1!);
    }
    if (widget.controller2 != null) {
      widget.controller2!.text = _formatDate(selectedDate2!);
    }
  }

  DateTime _parseDate(String date) {
    try {
      return DateFormat('dd-MMMM-yyyy', 'en_US').parse(date);
    } catch (e) {
      // print("Error parsing date: $e");
      return DateTime.now();
    }
  }

  String _formatDate(DateTime date) {
    return DateFormat('dd-MMMM-yyyy', 'en_US').format(date);
  }

  Future<void> _selectDate(BuildContext context, bool isFirstDate) async {
    DateTime picked = (await showDatePicker(
          context: context,
          initialDate: isFirstDate ? selectedDate1! : selectedDate2!,
          firstDate: isFirstDate
              ? DateTime(2000)
              : _parseDate(widget.controller1!.text),
          lastDate: DateTime.now(),
        )) ??
        (isFirstDate ? selectedDate1! : selectedDate2!);

    setState(() {
      if (isFirstDate) {
        selectedDate1 = picked;
        if (widget.controller1 != null) {
          widget.controller1!.text = _formatDate(selectedDate1!);
          if (selectedDate2!.isBefore(selectedDate1!)) {
            selectedDate2 = picked; // Update selectedDate2 if needed
            widget.controller2!.text = _formatDate(selectedDate2!);
          }
        }
      } else {
        // Ensure selectedDate2 is after or equal to selectedDate1
        if (picked.isBefore(selectedDate1!)) {
          picked = selectedDate1!;
        }
        selectedDate2 = picked;
        if (widget.controller2 != null) {
          widget.controller2!.text = _formatDate(selectedDate2!);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            readOnly: true,
            controller: widget.controller1,
            decoration: const InputDecoration(
                // ... (Your existing decoration properties)
                ),
            onTap: () => _selectDate(context, true),
          ),
        ),
        SizedBox(width: 2.w), // Add some spacing between the date fields
        Expanded(
          child: TextFormField(
            readOnly: true,
            controller: widget.controller2,
            decoration: const InputDecoration(
                // ... (Your existing decoration properties)
                ),
            onTap: () => _selectDate(context, false),
          ),
        ),
      ],
    );
  }
}
