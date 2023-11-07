class GuestModel {
  int? id;
  final String gname;
  final String sex;
  final String? note;
  bool status;
  final String? number;
  final int eventid;

  final String? email;
  final String? address;

  GuestModel(
      {required this.status,
      required this.gname,
      required this.sex,
      required this.eventid,
      this.number,
      this.email,
      this.id,
      this.note,
      this.address});

  static GuestModel fromMap(Map<String, Object?> map) {
    final id = map['id'] as int?;
    final gname = map['gname'] as String;
    final sex = map['sex'] as String;
    final note = map['note'] as String?;
    final status =
        map['status'] is int ? map['status'] == 1 : map['status'] as bool;
    final eventid = map['eventid'] as int;
    final number = map['number'] as String?;
    final email = map['email'] as String?;
    final address = map['address'] as String?;

    return GuestModel(
        id: id,
        status: status,
        gname: gname,
        sex: sex,
        eventid: eventid,
        address: address,
        email: email,
        note: note,
        number: number);
  }
}
