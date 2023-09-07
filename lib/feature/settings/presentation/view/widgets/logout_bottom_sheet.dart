import 'package:chat_app/core/_core_exports.dart';

class LogOutBottomSheet extends StatelessWidget {
  const LogOutBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 36),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppText("Uygulamadan çıkmak istiyormusunuz.", style: AppTextStyles.medium20W600),
          AppSizedBox.h(24.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              AppButton.small(
                buttonText: "Evet",
                onTap: () {
                  sl<LoginViewModel>().logOut();
                },
              ),
              AppButton.smallOutline(
                buttonText: "Hayır",
                onTap: () => Go.to.back(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
