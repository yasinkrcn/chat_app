import 'package:chat_app/core/_core_exports.dart';
import 'package:chat_app/feature/message/data/models/chat_model.dart';
import 'package:chat_app/feature/message/presentation/view/widgets/show_image_widget.dart';

// ignore: must_be_immutable
class ChatBodyWidget extends StatelessWidget {
  ChatModel message;

  ChatBodyWidget({
    Key? key,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScreenSize.init(context);
    DateTime? time = message.time!.toDate();

    String convertedTime = "${time.hour}:${time.minute.toString().length == 1 ? "0${time.minute}" : time.minute}";
    return message.type == "text"
        ? Container(
            width: ScreenSize().getWidthPercent(1),
            alignment:
                message.sendby == FirebaseAuth.instance.currentUser!.uid ? Alignment.centerRight : Alignment.centerLeft,
            child: message.sendby == FirebaseAuth.instance.currentUser!.uid
                ? Container(
                    constraints: BoxConstraints(maxWidth: ScreenSize().getWidthPercent(1) - 72),
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
                    margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: AppColors.primaryColor,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          message.message ?? "",
                          style: AppTextStyles.medium16W500.copyWith(color: AppColors.white),
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        Text(
                          convertedTime,
                          style: AppTextStyles.medium12W500.copyWith(color: AppColors.white),
                        ),
                      ],
                    ),
                  )
                : Container(
                    constraints: BoxConstraints(maxWidth: ScreenSize().getWidthPercent(1) - 72),
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
                    margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: AppColors.blue,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          message.message ?? "",
                          style: AppTextStyles.medium16W500.copyWith(color: AppColors.white),
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        Text(
                          convertedTime,
                          style: AppTextStyles.medium12W500.copyWith(color: AppColors.white),
                        ),
                      ],
                    ),
                  ),
          )
        : Container(
            height: 400,
            width: 200,
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            alignment:
                message.sendby == FirebaseAuth.instance.currentUser!.uid ? Alignment.centerRight : Alignment.centerLeft,
            child: InkWell(
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => ShowImage(
                    imageUrl: message.message ?? "",
                  ),
                ),
              ),
              child: Container(
                height: ScreenSize().getWidthPercent(1),
                width: ScreenSize().getWidthPercent(.6),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Container(
                  height: 380,
                  width: 180,
                  alignment: message.message != "" ? null : Alignment.center,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: CachedNetworkImage(
                      imageUrl: message.message ?? "",
                      placeholder: (context, url) {
                        return const Center(child: CircularProgressIndicator.adaptive());
                      },
                      errorWidget: (context, url, error) {
                        return const Icon(Icons.error);
                      },
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          );
  }
}
