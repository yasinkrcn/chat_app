import 'dart:io';

import 'package:chat_app/core/_core_exports.dart';
import 'package:chat_app/feature/message/data/datasources/message_remote_data_source.dart';
import 'package:chat_app/feature/message/domain/repositories/message_repo.dart';
import 'package:dartz/dartz.dart';

class MessageRepositoryImpl implements MessageRepo {
  final MessageRemoteDataSource messageRemoteDataSource;

  MessageRepositoryImpl(this.messageRemoteDataSource);

  @override
  Future<Either<Failure, List<UserModel>>> fetchMessageUsers() async {
    try {
      var result = await messageRemoteDataSource.fetchMessageUsers();

      return Right(result);
    } catch (failure) {
      if (kDebugMode) {
        print(failure);
      }
      return Left(ConnectionErrorFailure());
    }
  }

  @override
  Future<Either<Failure, String>> sendImage({
    required String receiverToken,
    required String chatRoomId,
    required File? imageFile,
  }) async {
    try {
      var result = await messageRemoteDataSource.sendImage(
        receiverToken: receiverToken,
        chatRoomId: chatRoomId,
        imageFile: imageFile,
      );

      return Right(result);
    } catch (failure) {
      if (kDebugMode) {
        print(failure);
      }
      return Left(ConnectionErrorFailure());
    }
  }

  @override
  Future<Either<Failure, void>> sendTextMessage({
    required String message,
    required String chatRoomId,
    required String receiverToken,
  }) async {
    try {
      var result = await messageRemoteDataSource.sendTextMessage(
        message: message,
        chatRoomId: chatRoomId,
        receiverToken: receiverToken,
      );

      return Right(result);
    } catch (failure) {
      if (kDebugMode) {
        print(failure);
      }
      return Left(ConnectionErrorFailure());
    }
  }
}
