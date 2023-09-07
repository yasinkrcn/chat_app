import 'dart:convert';

import 'package:chat_app/core/_core_exports.dart';
import 'package:chat_app/feature/auth/data/models/dks/user_dks.dart';

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
        id: json[UserDKS.id],
        userImage: json[UserDKS.userImage],
        name: json[UserDKS.name],
        number: json[UserDKS.number],
        email: json[UserDKS.email],
        messageToken: json[UserDKS.messageToken],
      );

  factory UserModel.fromFirestore(DocumentSnapshot documentSnapshot) {
    Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;
    return UserModel(
      id: data[UserDKS.id],
      userImage: data[UserDKS.userImage],
      name: data[UserDKS.name],
      number: data[UserDKS.number],
      email: data[UserDKS.email],
      messageToken: data[UserDKS.messageToken],
    );
  }

  Map<String, dynamic> toMap() => {
        UserDKS.id: id,
        UserDKS.userImage: userImage,
        UserDKS.name: name,
        UserDKS.number: number,
        UserDKS.email: email,
        UserDKS.messageToken: messageToken ?? "",
      };

  void assignData(UserModel other) {
    id = other.id;
    userImage = other.userImage;
    name = other.name;
    number = other.number;
    email = other.email;
    messageToken = other.messageToken;
  }
}
