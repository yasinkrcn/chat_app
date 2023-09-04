import 'package:dartz/dartz.dart';
import 'package:chat_app/core/_core_exports.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserCredential>> createUserWithEmailAndPassword(
      {required String email, required String password});

  Future<Either<Failure, void>> saveUserInfo({required UserModel userModel});

  Future<Either<Failure, UserCredential>> loginWithEmailAndPassword({required String email, required String password});

  Future<Either<Failure, void>> signOut();

  Future<Either<Failure, UserModel>> getUsers({required String userId});

  Future<Either<Failure, void>> userDelete({
    required String userId,
  });

  Future<Either<Failure, void>> sendEmailVerificationCode();
}
