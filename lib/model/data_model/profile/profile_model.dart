class ProfileModel {
  int? id;
  final String? imagex;
  final String name;
  final String email;
  final String phone;
  final String? address;
  final String password;
  ProfileModel({
    this.id,
    this.imagex,
    required this.name,
    required this.email,
    required this.phone,
    this.address,
    required this.password,
  });
  static ProfileModel fromMap(Map<String, Object?> map) {
    final id = map['id'] as int;
    final imagex = map['imagex'] as String?;
    final name = map['name'] as String;
    final email = map['email'] as String;
    final phone = map['phone'] as String;
    final address = map['address'] as String?;
    final password = map['password'] as String;

    return ProfileModel(
      id: id,
      name: name,
      email: email,
      phone: phone,
      address: address,
      imagex: imagex,
      password: password,
    );
  }
}
