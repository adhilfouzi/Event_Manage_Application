class Eventmodel {
  String? id;
  final String eventname;
  final String? budget;
  final String location;
  final String? about;
  final String startingDay;
  final String? endingDay;
  final String startingTime;
  final String? endingTime;
  final String? clientname;
  final String? phoneNumber;
  final String? emailId;
  final String? address;
  final String imagex;

  Eventmodel({
    required this.eventname,
    required this.location,
    required this.startingDay,
    required this.imagex,
    required this.startingTime,
    this.clientname,
    this.phoneNumber,
    this.budget,
    this.emailId,
    this.endingDay,
    this.endingTime,
    this.address,
    this.about,
    this.id,
  }) {
    id = DateTime.now().millisecondsSinceEpoch.toString();
  }

  static Eventmodel fromMap(Map<String, Object?> map) {
    final id = map['id'] as String?;
    final eventname = map['eventname'] as String;
    final budget = map['budget'] as String?;
    final location = map['location'] as String;
    final about = map['about'] as String?;
    final startingDay = map['startingDay'] as String;
    final endingDay = map['endingDay'] as String?;
    final clientname = map['clientname'] as String?;
    final endingTime = map['endingTime'] as String?;
    final startingTime = map['startingTime'] as String;
    final phoneNumber = map['phoneNumber'] as String?;
    final emailId = map['emailId'] as String?;
    final address = map['address'] as String?;
    final imagex = map['imagex'] as String;

    return Eventmodel(
      id: id,
      eventname: eventname,
      phoneNumber: phoneNumber,
      about: about,
      address: address,
      budget: budget,
      clientname: clientname,
      emailId: emailId,
      endingDay: endingDay,
      endingTime: endingTime,
      location: location,
      startingDay: startingDay,
      imagex: imagex,
      startingTime: startingTime,
    );
  }
}
