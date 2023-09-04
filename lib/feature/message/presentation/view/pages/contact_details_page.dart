import 'package:chat_app/core/_core_exports.dart';

class ContactDetailsPage extends StatelessWidget {
  final UserModel userData;
  const ContactDetailsPage({super.key, required this.userData});

  @override
  Widget build(BuildContext context) {
    ScreenSize.init(context);
    return AppScaffold(
      appBar: CommonAppBar(
        title: userData.name,
        actions: const Icon(
          Icons.more_vert_rounded,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            AppSizedBox.h(16),
            Align(
              alignment: Alignment.center,
              child: AppProfileImage.circle(
                size: 136,
                imageUrl: userData.userImage!,
              ),
            ),
            AppSizedBox.h(16),
            AppText(
              userData.number!,
              style: TextStyle(fontSize: 20, color: Colors.grey.shade600, fontWeight: FontWeight.w600),
            ),
            AppSizedBox.h(16),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ContactActionButton(
                  icon: Icons.phone,
                  text: "Sesli",
                ),
                ContactActionButton(
                  icon: Icons.video_call,
                  text: "Görüntülü",
                ),
                ContactActionButton(
                  icon: Icons.search,
                  text: "Ara",
                ),
              ],
            ),
            const Divider(
              color: AppColors.primaryColor,
              height: 36,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    "İdeolojime Ters",
                    style: AppTextStyles.medium18W500,
                  ),
                  AppText(
                    "23 Ekim",
                    style: AppTextStyles.medium16W500.copyWith(color: AppColors.primaryColor),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ContactActionButton extends StatelessWidget {
  final String text;
  final IconData icon;
  const ContactActionButton({
    super.key,
    required this.text,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          icon,
          color: AppColors.primaryColor,
          size: 36,
        ),
        AppSizedBox.h(6),
        AppText(
          text,
          style: const TextStyle(color: AppColors.primaryColor, fontSize: 20),
        ),
      ],
    );
  }
}
