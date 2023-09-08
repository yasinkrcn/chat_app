import 'package:chat_app/core/_core_exports.dart';
import 'package:chat_app/feature/home/presentation/view/widgets/story_card.dart';
import 'package:chat_app/feature/home/presentation/view_model/home_view_model.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: const CommonAppBar(title: "Ana Sayfa"),
      body: Consumer(
        builder: (context, HomeViewModel homeViewModel, child) {
          return Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.symmetric(vertical: 16),
            height: 108,
            child: AppWidgetBuilderByState(
              response: homeViewModel.users,
              builder: (users) {
                return ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    // StoryCard(imageUrl: sl<UserModel>().userImage!),

                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: StoryCard(
                        onTap: () => Go.to.page(PageRoutes.storyAddPage),
                        imageUrl: sl<UserModel>().userImage!,
                        name: sl<UserModel>().name!,
                        isMe: true,
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: users.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: StoryCard(
                            imageUrl: users[index].userImage!,
                            name: users[index].name!,
                          ),
                        );
                      },
                    ),
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }
}
