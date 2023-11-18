class VendorsModel {
  int? id;
  final String name;
  final String? category;
  final String? note;
  final String esamount;

  final int eventid;
  final String clientname;
  final String? number;
  final String? email;
  final String? address;

  int? paid;
  int? pending;

  VendorsModel({
    required this.name,
    required this.category,
    required this.esamount,
    required this.eventid,
    required this.clientname,
    this.note,
    this.number,
    this.email,
    this.address,
    this.id,
    this.paid,
    this.pending,
  });

  static VendorsModel fromMap(Map<String, Object?> map) {
    final id = map['id'] as int?;
    final name = map['name'] as String;
    final category = map['category'] as String?;
    final note = map['note'] as String?;
    final esamount = map['esamount'] as String;
    final eventid = map['eventid'] as int;
    final clientname = map['clientname'] as String;
    final number = map['number'] as String?;
    final email = map['email'] as String?;
    final address = map['address'] as String?;
    final paid = map['paid'] as int?;
    final pending = map['pending'] as int?;

    return VendorsModel(
      id: id,
      name: name,
      category: category,
      note: note,
      esamount: esamount,
      eventid: eventid,
      clientname: clientname,
      number: number,
      email: email,
      address: address,
      paid: paid,
      pending: pending,
    );
  }
}
