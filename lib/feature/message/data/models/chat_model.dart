import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class ChatModel {
  ChatModel({
    this.message,
    this.sendby,
    this.time,
    this.type,
  });

  String? message;
  final String? sendby;
  final Timestamp? time;
  final String? type;

  String toJson() => json.encode(toMap());

  factory ChatModel.fromSnapshot(DocumentSnapshot snapshot) => ChatModel(
        message: snapshot["message"],
        sendby: snapshot["sendby"],
        time: snapshot["time"],
        type: snapshot["type"],
      );

  Map<String, dynamic> toMap() => {
        "message": message,
        "sendby": sendby,
        "time": time,
        "type": type,
      };
}
