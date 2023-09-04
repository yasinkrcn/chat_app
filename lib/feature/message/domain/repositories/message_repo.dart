import 'package:chat_app/core/_core_exports.dart';
import 'package:dartz/dartz.dart';

abstract class MessageRepo {
  Future<Either<Failure, List<UserModel>>> fetchMessageUsers();
}
