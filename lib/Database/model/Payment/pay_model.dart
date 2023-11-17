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
  final int eventid;

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
    required this.eventid,
  });
  static PaymentModel fromMap(Map<String, Object?> map) {
    final id = map['id'] as int?;
    final name = map['name'] as String;
    final paytype = map['paytype'] as int;
    final paytypename = map['paytypename'] as String;
    final pyamount = map['pyamount'] as String;
    final note = map['note'] as String?;
    final date = map['date'] as String;
    final time = map['time'] as String;
    final payid = map['payid'] as int;
    final eventid = map['eventid'] is int
        ? map['eventid'] as int
        : (map['eventid'] is String
            ? int.tryParse(map['eventid'] as String) ?? 0
            : 0);
    return PaymentModel(
        id: id,
        name: name,
        paytype: paytype,
        paytypename: paytypename,
        pyamount: pyamount,
        note: note,
        date: date,
        time: time,
        payid: payid,
        eventid: eventid);
  }
}

class IncomeModel {
  final int? id;
  final String name;
  final String pyamount;
  final String? note;
  final String date;
  final String time;
  final int eventid;
  IncomeModel({
    this.id,
    required this.name,
    required this.pyamount,
    this.note,
    required this.date,
    required this.time,
    required this.eventid,
  });
  static IncomeModel fromMap(Map<String, Object?> map) {
    final id = map['id'] as int?;
    final name = map['name'] as String;
    final pyamount = map['pyamount'] as String;
    final note = map['note'] as String?;
    final date = map['date'] as String;
    final time = map['time'] as String;
    final eventid = map['eventid'] is int
        ? map['eventid'] as int
        : (map['eventid'] is String
            ? int.tryParse(map['eventid'] as String) ?? 0
            : 0);
    return IncomeModel(
        id: id,
        name: name,
        pyamount: pyamount,
        date: date,
        time: time,
        eventid: eventid,
        note: note);
  }
}
