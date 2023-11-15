import 'package:flutter/material.dart';

ValueNotifier<String> raylist = ValueNotifier<String>('Budget');

class PaymentModel {
  int? id;
  final String name;
  final int paytype;
  final String paytypename;
  final String pyamount;
  final String? note;
  final String date;

  final String time;
  final int payid;

  PaymentModel({
    this.id,
    required this.name,
    required this.pyamount,
    this.note,
    required this.date,
    required this.paytype,
    required this.paytypename,
    required this.time,
    required this.payid,
  });
}
