import 'package:chat_app/core/_core_exports.dart';
import 'package:chat_app/feature/auth/presentation/view_model/login_view_model.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: const CommonAppBar(
        title: "Şifremi Unuttum",
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox.shrink(),
          // Expanded(child: Lottie.asset(AssetPaths().forgotPassword)),
          ShadowContainer(child: Consumer(
            builder: (context, LoginViewModel prov, child) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Şifreni mi Unuttun?',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    'Şifrenizi sıfırlamak için e-posta adresinizi giriniz.',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: Colors.grey.shade700),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  AppTextFormField.standart(
                    hintText: 'E-posta adresiniz',
                    controller: prov.emailController,
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  AppButton.standart(
                      onTap: () {
                        prov.resetPassword();
                      },
                      buttonText: 'Devam Et'),
                ],
              );
            },
          )),
        ],
      ),
    );
  }
}
