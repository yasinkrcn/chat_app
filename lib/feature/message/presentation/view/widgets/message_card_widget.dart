import '../../../../../core/_core_exports.dart';

class MessageCardWidget extends StatelessWidget {
  final String imageUrl;
  final String username;
  const MessageCardWidget({
    super.key,
    required this.imageUrl,
    required this.username,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 16, right: 16, top: 16),
      height: 102,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: Colors.grey.shade300),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            AppProfileImage.circle(imageUrl: imageUrl, size: 64),
            SizedBox(
              width: 16.w,
            ),
            AppText(
              username.length > 20 ? "${username.substring(0, 20)}..." : username,
              style: AppTextStyles.medium18W500,
            ),
            const Spacer(),
            const Icon(Icons.send, color: AppColors.primaryColor),
          ],
        ),
      ),
    );
  }
}
