import 'package:dartz/dartz.dart';

import '../../../../../error/failures/failure.dart';
import '../entities/shared_preferences_keys.dart';



abstract class SharedPreferencesRepository {
  Future<Either<Failure, String>> getDataFromKey(SharedPreferencesKeys key);
  Future<Either<Failure, void>> removeDataFromKey(SharedPreferencesKeys key);
  Future<Either<Failure, void>> saveDataFromKey(SharedPreferencesKeys key, String data);
}
