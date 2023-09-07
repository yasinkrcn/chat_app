import 'package:chat_app/core/_core_exports.dart';
import 'package:chat_app/feature/message/presentation/view/widgets/message_card_widget.dart';
import 'package:chat_app/feature/message/presentation/view_model/chat_view_model.dart';

import 'package:chat_app/feature/message/presentation/view_model/message_view_model.dart';

class MessagePage extends StatelessWidget {
  const MessagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
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
                            //TODO:

                            sl<ChatViewModel>().startMessage(
                              targetUser: chatUserList[index],
                            );
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
    );
  }
}
