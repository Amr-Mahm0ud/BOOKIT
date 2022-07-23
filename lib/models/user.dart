class UserModel {
  String? uid;
  String email;
  String name;
  String phone;
  String? password;

  UserModel({
    this.uid,
    required this.email,
    required this.name,
    required this.phone,
    this.password,
  });
}
