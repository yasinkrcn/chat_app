import 'package:chat_app/core/_core_exports.dart';
import 'package:chat_app/core/error/failures/failure.dart';
import 'package:chat_app/feature/story/data/datasources/story_remote_data_source.dart';
import 'package:chat_app/feature/story/data/models/story_model.dart';
import 'package:chat_app/feature/story/domain/repositories/story_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

class StoryRepositoryImpl implements StoryRepository {
  final StoryRemoteDataSource remoteDataSource;

  StoryRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, void>> postStory({required StoryModel story}) async {
    try {
      final result = await remoteDataSource.postStory(story: story);

      return Right(result);
    } catch (failure) {
      if (kDebugMode) {
        print(failure);
      }
      return Left(UserDataFetchFailure());
    }
  }
}
