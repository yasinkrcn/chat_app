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
      margin: const EdgeInsets.all(4),
      height: 102,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.primaryColor),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            Container(
              height: 66,
              width: 66,
              decoration: const BoxDecoration(color: AppColors.primaryColor, shape: BoxShape.circle),
              child: Padding(
                padding: const EdgeInsets.all(1.0),
                child: ClipOval(
                  child:
                      SizedBox(height: 64, width: 64, child: CachedNetworkImage(fit: BoxFit.cover, imageUrl: imageUrl)),
                ),
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            AppText(
              username.length > 20 ? "${username.substring(0, 20)}..." : username,
              style: AppTextStyles.medium18W500,
            ),
            const Spacer(),
            Transform.rotate(angle: -0.2, child: const Icon(Icons.send, color: AppColors.primaryColor)),
          ],
        ),
      ),
    );
  }
}
