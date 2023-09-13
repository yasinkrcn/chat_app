import 'dart:io';

import 'package:chat_app/core/_core_exports.dart';
import 'package:chat_app/feature/story/data/models/story_model.dart';
import 'package:chat_app/feature/story/domain/repositories/story_repo.dart';

class StoryViewModel extends ChangeNotifier {
  final storyRepository = sl<StoryRepository>();
  File get _imageFile => imageFile!;

  File? imageFile;
  void ddddd() async {
    print(_imageFile.path);
    await imageFile?.delete();
    notifyListeners();
  }

  Future<void> sendStoryDataToFirebase() async {
    var res = await sl<AuthRepository>().getImageUrlFromFirebase(imageFile: imageFile!, imageLocation: "stories");

    res.fold((failure) {
      showCustomMessenger(CustomMessengerState.ERROR, failure.message);
    }, (storyUrl) async {
      final story = StoryModel(
        sentTime: Timestamp.now(),
        storySender: sl<UserModel>().name,
        storyUrl: storyUrl,
      );

      var res = await storyRepository.postStory(story: story);

      res.fold(
        (failure) => showCustomMessenger(CustomMessengerState.ERROR, failure.message),
        (data) {
          showCustomMessenger(CustomMessengerState.SUCCESS, "Story oluşturuldu.");
        },
      );
    });
  }
}
