import 'package:dartz/dartz.dart';
import 'package:chat_app/core/_core_exports.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, UserCredential>> createUserWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      final user = await remoteDataSource.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      return Right(user);
    } catch (failure) {
      if (kDebugMode) {
        print(failure);
      }

      return Left(UserRegistrationFailure());
    }
  }

  @override
  Future<Either<Failure, UserModel>> getUsers({required String userId}) async {
    try {
      final result = await remoteDataSource.getUserInfo(userId: userId);

      return Right(result);
    } catch (failure) {
      if (kDebugMode) {
        print(failure);
      }
      return Left(UserDataFetchFailure());
    }
  }

  @override
  Future<Either<Failure, UserCredential>> loginWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      final result = await remoteDataSource.loginWithEmailAndPassword(email: email, password: password);

      return Right(result);
    } catch (failure) {
      if (kDebugMode) {
        print(failure);
      }
      return Left(UserLoginFailure());
    }
  }

  @override
  Future<Either<Failure, void>> signOut() async {
    try {
      await remoteDataSource.logOut();

      return const Right(null);
    } catch (failure) {
      if (kDebugMode) {
        print(failure);
      }
      return Left(ConnectionErrorFailure());
    }
  }

  @override
  Future<Either<Failure, void>> userDelete({required String userId}) async {
    try {
      final result = await remoteDataSource.deleteUser(userId: userId);

      return Right(result);
    } catch (failure) {
      if (kDebugMode) {
        print(failure);
      }
      return Left(UserDeleteFailure());
    }
  }

  @override
  Future<Either<Failure, void>> saveUserInfo({required UserModel userModel}) async {
    try {
      await remoteDataSource.saveUserInfo(userModel: userModel);

      return const Right(null);
    } catch (failure) {
      if (kDebugMode) {
        print(failure);
      }
      return Left(ConnectionErrorFailure());
    }
  }

  @override
  Future<Either<Failure, void>> sendEmailVerificationCode() async {
    try {
      await remoteDataSource.sendEmailVerificationCode();

      return const Right(null);
    } catch (failure) {
      if (kDebugMode) {
        print(failure);
      }
      return Left(ConnectionErrorFailure());
    }
  }
}
