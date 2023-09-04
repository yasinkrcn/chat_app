import 'dart:convert';

import 'package:chat_app/core/_core_exports.dart';

class UserModel {
  UserModel({
    this.id,
    this.userImage,
    this.name,
    this.number,
    this.email,
    this.messageToken,
  });

  String? id;
  String? userImage;
  String? name;
  String? number;
  String? email;
  String? messageToken;

  factory UserModel.fromJson(String str) => UserModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserModel.fromMap(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        userImage: json["userImage"],
        name: json["name"],
        number: json["number"],
        email: json["email"],
        messageToken: json["messageToken"],
      );

  factory UserModel.fromFirestore(DocumentSnapshot documentSnapshot) {
    Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;
    return UserModel(
      id: data["id"],
      userImage: data["userImage"],
      name: data["name"],
      number: data["number"],
      email: data["email"],
      messageToken: data["messageToken"],
    );
  }

  Map<String, dynamic> toMap() => {
        "id": id,
        "userImage": userImage,
        "name": name,
        "number": number,
        "email": email,
        "messageToken": messageToken,
      };
}
