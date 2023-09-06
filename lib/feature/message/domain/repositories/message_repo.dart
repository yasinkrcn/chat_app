import 'dart:io';

import 'package:chat_app/core/_core_exports.dart';
import 'package:chat_app/feature/message/data/models/chat_model.dart';
import 'package:dartz/dartz.dart';

abstract class MessageRepo {
  Future<Either<Failure, List<UserModel>>> fetchMessageUsers();

  Future<Either<Failure, String>> sendImage({
    required String receiverToken,
    required String chatRoomId,
    required File? imageFile,
  });

  Future<Either<Failure, void>> sendTextMessage({
    required String message,
    required String chatRoomId,
  });

  Future<Either<Failure, List<ChatModel>>> fetchMessages({
    required String chatRoomId,
    required Timestamp? lastMessageTime,
  });

  Future<Either<Failure, void>> sendFirebaseNotification({
    required String senderName,
    required String message,
    required String receiverToken,
  });
}
