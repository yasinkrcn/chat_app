import 'package:chat_app/core/_core_exports.dart';
import 'package:chat_app/feature/auth/presentation/view/widgets/user_register_photo.dart';
import 'package:chat_app/feature/settings/presentation/view_model/settings_view_model.dart';

class ProfileSettingsPage extends StatelessWidget {
  const ProfileSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: const CommonAppBar(
        title: "Profil Ayarları",
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Consumer(
            builder: (context, SettingsViewModel settingsViewModel, child) {
              return Column(
                children: [
                  AppSizedBox.h(16),
                  Align(
                    alignment: Alignment.center,
                    child: UserRegistrationAddPhotoWidget(
                      viewModel: settingsViewModel,
                      isUpdate: true,
                      imageUrl: sl<UserModel>().userImage,
                    ),
                  ),
                  AppSizedBox.h(8),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: AppText(
                      "İsim",
                      style: AppTextStyles.semibold16W500,
                    ),
                  ),
                  AppSizedBox.h(8),
                  AppTextFormField.standart(
                    controller: settingsViewModel.nameController,
                  ),
                  AppSizedBox.h(16.h),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: AppText(
                      "Telefon Numarası",
                      style: AppTextStyles.semibold16W500,
                    ),
                  ),
                  AppSizedBox.h(8),
                  AppTextFormField.standart(
                    controller: settingsViewModel.phoneController,
                  ),
                  AppSizedBox.h(102.h),
                  AppButton.standart(
                    onTap: () => settingsViewModel.updateUserData(),
                    buttonText: "Güncelle",
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
