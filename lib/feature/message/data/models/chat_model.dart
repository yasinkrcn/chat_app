import 'dart:convert';

import 'package:chat_app/feature/message/data/models/dks/chat_dks.dart';
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
        message: snapshot[ChatDKS.message],
        sendby: snapshot[ChatDKS.sendby],
        time: snapshot[ChatDKS.time],
        type: snapshot[ChatDKS.type],
      );

  Map<String, dynamic> toMap() => {
        ChatDKS.message: message,
        ChatDKS.sendby: sendby,
        ChatDKS.time: time,
        ChatDKS.type: type,
      };
}
