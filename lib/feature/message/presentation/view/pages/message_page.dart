import 'package:chat_app/core/_core_exports.dart';
import 'package:chat_app/feature/message/presentation/view/widgets/message_card_widget.dart';

import 'package:chat_app/feature/message/presentation/view_model/message_view_model.dart';

class MessagePage extends StatelessWidget {
  const MessagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: AppScaffold(
        appBar: const CommonAppBar(title: "Mesajlar"),
        body: Consumer(
          builder: (context, MessageViewModel messageViewModel, child) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0) - const EdgeInsets.only(bottom: 16),
                    child: AppTextFormField.standart(
                      hintText: "Ara",
                      suffixIcon: const Icon(Icons.search_rounded),
                    ),
                  ),
                  AppWidgetBuilderByState(
                    response: messageViewModel.chatUserList,
                    builder: (chatUserList) {
                      return ListView.builder(
                        physics: const ClampingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: chatUserList.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () async {
                              // sl<MessageViewModel>().chatRoomId = messageViewModel.chatRoomId(
                              //     user1: FirebaseAuth.instance.currentUser!.uid, user2: chatUserList[index].id!);

                              // sl<MessageViewModel>().openNewChat();

                              // Go.to.page(PageRoutes.chatPage, arguments: chatUserList[index]);

                              // sl<MessageViewModel>().getChatMessages();
                            },
                            child: MessageCardWidget(
                              imageUrl: chatUserList[index].userImage!,
                              username: chatUserList[index].name!,
                            ),
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
