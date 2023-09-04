import 'package:dartz/dartz.dart';

import '../error/failures/failure.dart';

abstract class Usecase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

class NoParams {}
