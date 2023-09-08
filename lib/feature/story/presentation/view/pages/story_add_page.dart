import 'package:chat_app/core/_core_exports.dart';
import 'package:chat_app/feature/story/presentation/view/widgets/dotted_border_container.dart';
import 'package:chat_app/feature/story/presentation/view/widgets/story_add_and_show.dart';
import 'package:chat_app/feature/story/presentation/view_model/story_view_model.dart';

class StoryAddPage extends StatelessWidget {
  const StoryAddPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: Consumer(
        builder: (context, StoryViewModel storyViewModel, child) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 24, top: 16, bottom: 24),
                child: DottedBorder(
                  height: ScreenSize().getHeightPercent(.8),
                  width: double.infinity,
                  child: StoryAddAndShow(
                    imageFile: storyViewModel.imageFile,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: AppButton.standart(onTap: () {}, buttonText: "Devam Et"),
              )
            ],
          );
        },
      ),
    );
  }
}
