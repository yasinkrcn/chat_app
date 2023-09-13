import 'package:chat_app/core/_core_exports.dart';
import 'package:chat_app/feature/story/data/models/story_model.dart';
import 'package:dartz/dartz.dart';

abstract class StoryRepository {
  Future<Either<Failure, void>> postStory({
    required StoryModel story,
  });
}
