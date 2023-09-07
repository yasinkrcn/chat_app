import 'package:chat_app/core/_core_exports.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenSize.init(context);
    return AppScaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AppText("data"),
          SizedBox.shrink(),
          // Expanded(child: Lottie.asset(AssetPaths().auth)),
          ShadowContainer(child: Consumer(
            builder: (context, LoginViewModel loginController, child) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    'Hoşgeldiniz',
                    style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  AppText(
                    'Hesap bilgilerinizi giriniz !',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: Colors.grey.shade700),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  AppTextFormField.standart(
                    hintText: 'E-mail',
                    controller: loginController.emailController,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  AppTextFormField.obscure(
                    hintText: 'Şifre',
                    controller: loginController.passwordController,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: GestureDetector(
                      onTap: () {
                        Go.to.page(PageRoutes.forgotPasswordPage);
                      },
                      child: Text(
                        'Şifremi unuttum?',
                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: Colors.grey.shade800),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  AppButton.standart(
                      onTap: () {
                        loginController.login();
                      },
                      buttonText: 'Giriş Yap'),
                  const SizedBox(
                    height: 22,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Hesabınız yok mu? ',
                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: Colors.grey.shade600),
                      ),
                      GestureDetector(
                        onTap: () {
                          Go.to.page(PageRoutes.registerPage);
                        },
                        child: const Text(
                          'Kayıt Ol',
                          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: AppColors.orange),
                        ),
                      ),
                    ],
                  )
                ],
              );
            },
          )),
        ],
      ),
    );
  }
}
