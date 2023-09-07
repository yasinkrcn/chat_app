import 'package:chat_app/feature/settings/data/datasources/settings_remote_data_source.dart';
import 'package:chat_app/feature/settings/domain/repositories/settings_repo.dart';
import 'package:dartz/dartz.dart';

import '../../../../../core/_core_exports.dart';

class SettingsRepoImpl implements SettingsRepo {
  final SettingsRemoteDataSource settingsRemoteDataSource;

  SettingsRepoImpl(this.settingsRemoteDataSource);

  @override
  Future<Either<Failure, void>> updateUserInformations({required UserModel user}) async {
    try {
      await settingsRemoteDataSource.updateUserInformations(user: user);
      return const Right(null);
    } catch (failure) {
      if (kDebugMode) {
        print(failure);
      }
      return Left(UserDataFetchFailure());
    }
  }
}
