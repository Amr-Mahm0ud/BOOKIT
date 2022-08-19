class UserModel {
  String? uid;
  String email;
  String name;
  String? password;
  String? photoUrl;

  UserModel({
    this.uid,
    required this.email,
    required this.name,
    this.password,
    this.photoUrl,
  });
}
