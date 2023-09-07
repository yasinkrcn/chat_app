import 'package:dartz/dartz.dart';
import '../../../../core/_core_exports.dart';

abstract class SettingsRepo {
  Future<Either<Failure, void>> updateUserInformations({required UserModel user});
}
