import 'dart:convert';

class UserModel {
  UserModel({
    this.id,
    this.name,
    this.surname,
    this.email,
  });

  String? id;
  String? name;
  String? surname;
  String? email;

  factory UserModel.fromJson(String str) => UserModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserModel.fromMap(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        name: json["name"],
        surname: json["surname"],
        email: json["email"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "surname": surname,
        "email": email,
      };
}
