import 'package:chat_app/core/_core_exports.dart';
import 'package:chat_app/feature/message/presentation/view/widgets/chat_body_widget.dart';
import 'package:chat_app/feature/message/presentation/view/widgets/chat_page_app_bar.dart';
import 'package:chat_app/feature/message/presentation/view/widgets/send_button.dart';
import 'package:chat_app/feature/message/presentation/view_model/chat_view_model.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ChatViewModel messageViewModel, child) {
        return AppScaffold(
          appBar: ChatPageAppBar(userData: messageViewModel.messagePerson),
          body: Column(
            children: [
              Flexible(
                fit: FlexFit.tight,
                child: Container(
                  // color: Colors.amber,
                  // height: 600,
                  child: ListView.builder(
                    itemCount: messageViewModel.messageData.length,
                    shrinkWrap: true,
                    reverse: true,
                    controller: messageViewModel.scroolController,
                    // physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      // if (employerChatViewModel.messageData.length - 1 == index &&
                      //     employerChatViewModel.messageData.length == employerChatViewModel.pagelimit) {
                      //   employerChatViewModel.getChatMessages();
                      // }
                      return ChatBodyWidget(
                        message: messageViewModel.messageData[index],
                      );
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Flexible(
                      child: AppTextFormField.standart(
                        fillColor: Colors.white.withOpacity(.6),
                        hintText: "Send message...",
                        controller: messageViewModel.messageController,
                        suffixIcon: GestureDetector(
                            onTap: () {
                              messageViewModel.pickPictureFromGallery();
                            },
                            child: Icon(Icons.photo)),
                      ),
                    ),
                    // IconButton(
                    //   onPressed: () => employerChatViewModel.getImage(receiverToken: userData.messageToken!),
                    //   icon: const Icon(
                    //     Icons.photo,
                    //     color: AppColors.white,
                    //     size: 28,
                    //   ),
                    // ),
                    // IconButton(
                    //     onPressed: () {
                    //       Go.to.page(PageRoutes.cameraPage, arguments: userData.messageToken);
                    //     },
                    //     icon: Icon(
                    //       Icons.camera,
                    //       color: AppColors.white,
                    //     )),
                    SendButtonWidget(
                      onTap: () => messageViewModel.sendTextMessage(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
