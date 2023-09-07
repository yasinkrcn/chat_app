import 'package:chat_app/core/_core_exports.dart';
import 'package:chat_app/feature/settings/presentation/view/widgets/settings_item.dart';
import 'package:chat_app/feature/settings/presentation/view_model/settings_view_model.dart';
import '../widgets/logout_bottom_sheet.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: CommonAppBar(
          title: "Ayarlar",
          actions: GestureDetector(
            onTap: () {
              showModalBottomSheet<void>(
                context: context,
                builder: (BuildContext context) {
                  return const LogOutBottomSheet();
                },
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(20),
                  ),
                ),
              );
            },
            child: const Icon(
              Icons.exit_to_app_rounded,
              size: 36,
            ),
          )),
      body: SingleChildScrollView(
        child: Consumer(
          builder: (context, LoginViewModel viewModel, child) {
            return Column(
              children: [
                AppSizedBox.h(16),
                AppProfileImage.circle(
                  size: 150,
                  imageUrl: sl<UserModel>().userImage!,
                ),
                AppSizedBox.h(16),
                AppText(
                  sl<UserModel>().name ?? "null",
                  style: AppTextStyles.medium18W500,
                ),
                AppSizedBox.h(16),
                SettingsItem(
                  text: "Profil Ayarları",
                  onTap: () => Go.to.page(PageRoutes.profileSettingsPage),
                ),
                // AppButton.standart(
                //     onTap: () {
                //       sl<LoginViewModel>().fetchUserInfo();
                //     },
                //     buttonText: "buttonText"),
                // AppButton.standart(
                //     onTap: () {
                //       sl<LoginViewModel>().aaaaaaa();
                //     },
                //     buttonText: "ddddddddddd")
              ],
            );
          },
        ),
      ),
    );
  }
}
