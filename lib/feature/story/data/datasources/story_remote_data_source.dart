import 'package:chat_app/core/_core_exports.dart';
import 'package:chat_app/feature/story/data/models/story_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class StoryRemoteDataSource {
  Future<void> postStory({
    required StoryModel story,
  }) async {
    final storyData = FirebaseFirestore.instance.collection('stories');
    storyData.doc(sl<UserModel>().id).set(story.toMap());
  }
}
