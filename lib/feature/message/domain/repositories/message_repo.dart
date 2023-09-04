import 'dart:io';

import 'package:chat_app/core/_core_exports.dart';
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
    required String receiverToken,
  });
}
