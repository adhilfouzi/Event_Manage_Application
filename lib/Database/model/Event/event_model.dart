class Eventmodel {
  int? id;
  final String eventname;
  final String? budget;
  final String location;
  final String? about;
  final String startingDay;
  final String startingTime;
  final String? clientname;
  final String? phoneNumber;
  final String? emailId;
  final String? address;
  final String imagex;
  int favorite;

  Eventmodel({
    required this.eventname,
    required this.location,
    required this.startingDay,
    required this.imagex,
    required this.startingTime,
    required this.favorite,
    this.id,
    this.clientname,
    this.phoneNumber,
    this.budget,
    this.emailId,
    this.address,
    this.about,
  });
  static Eventmodel fromMap(Map<String, Object?> map) {
    final id = map['id'] as int;
    final eventname = map['eventname'] as String;
    final budget = map['budget'] as String?;
    final location = map['location'] as String;
    final about = map['about'] as String?;
    final startingDay = map['startingDay'] as String;
    final clientname = map['clientname'] as String?;
    final startingTime = map['startingTime'] as String;
    final phoneNumber = map['phoneNumber'] as String?;
    final emailId = map['emailId'] as String?;
    final address = map['address'] as String?;
    final imagex = map['imagex'] as String;
    final favorite = map['favorite'] is int
        ? map['favorite'] as int
        : (map['favorite'] is String
            ? int.tryParse(map['favorite'] as String) ?? 0
            : 0);

    return Eventmodel(
        id: id,
        eventname: eventname,
        phoneNumber: phoneNumber,
        about: about,
        address: address,
        budget: budget,
        clientname: clientname,
        emailId: emailId,
        location: location,
        startingDay: startingDay,
        imagex: imagex,
        startingTime: startingTime,
        favorite: favorite);
  }
}
