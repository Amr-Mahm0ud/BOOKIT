class UserModel {
  String? uid;
  String email;
  String name;
  String? password;

  UserModel({
    this.uid,
    required this.email,
    required this.name,
    this.password,
  });
}
