class BudgetModel {
  int? id;
  final String name;
  final String category;
  final String? note;
  final String esamount;
  final int eventid;

  int? paid;
  int? pending;
  BudgetModel({
    this.id,
    required this.name,
    required this.category,
    this.note,
    required this.esamount,
    required this.eventid,
    this.paid,
    this.pending,
  });

  static BudgetModel fromMap(Map<String, Object?> map) {
    final id = map['id'] as int?;
    final name = map['name'] as String;
    final category = map['category'] as String;
    final note = map['note'] as String?;
    final esamount = map['esamount'] as String;
    final eventid = map['eventid'] is int
        ? map['eventid'] as int
        : (map['eventid'] is String
            ? int.tryParse(map['eventid'] as String) ?? 0
            : 0);
    final paid = map['paid'] as int?;
    final pending = map['pending'] as int?;
    return BudgetModel(
      id: id,
      name: name,
      category: category,
      note: note,
      esamount: esamount,
      eventid: eventid,
      paid: paid,
      pending: pending,
    );
  }
}
