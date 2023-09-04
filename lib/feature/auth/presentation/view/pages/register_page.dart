import 'package:chat_app/core/_core_exports.dart';
import 'package:chat_app/feature/auth/presentation/view/widgets/shadow_container.dart';
import 'package:chat_app/feature/auth/presentation/view_model/register_view_model.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        backgroundColor: AppColors.white,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox.shrink(),
            // Expanded(child: Lottie.asset(AssetPaths().auth)),
            ShadowContainer(
              child: Consumer(builder: (context, RegisterViewModel registerController, child) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Hesap Oluştur',
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      'Lütfen hesap bilgilerinizi giriniz.',
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: Colors.grey.shade700),
                    ),
                    const SizedBox(
                      height: 28,
                    ),
                    AppTextFormField.standart(
                      hintText: 'Adınız',
                      controller: registerController.nameController,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    AppTextFormField.standart(
                      hintText: 'Soyadınız',
                      controller: registerController.surnameController,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    AppTextFormField.standart(
                      hintText: 'E-posta adresiniz',
                      controller: registerController.emailController,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    AppTextFormField.obscure(
                      hintText: 'Şifreniz',
                      controller: registerController.passwordController,
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    // Align(
                    //   alignment: Alignment.center,
                    //   child: Text(
                    //     'Kullanım Koşullarını okudum ve kabul ediyorum.',
                    //     style: TextStyle(
                    //         fontSize: 15,
                    //         fontWeight: FontWeight.w500,
                    //         color: Colors.grey.shade800),
                    //   ),
                    // ),

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Transform.scale(
                          scale: 1.3,
                          child: Checkbox(
                            value: registerController.isAccept,
                            checkColor: Colors.green,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                            fillColor: MaterialStateProperty.all(Colors.white),
                            activeColor: Colors.orange,
                            onChanged: (value) {
                              registerController.isTermsAndConditionAccept(value!);
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 12),
                          child: SizedBox(
                            width: ScreenSize().getWidthPercent(1) - 140,
                            child: RichText(
                              text: TextSpan(
                                  text: 'Kullanım koşullarını',
                                  style:
                                      const TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w500),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      registerController.privacyPolicy(context);
                                    },
                                  children: const <TextSpan>[
                                    TextSpan(
                                      text: ' okudum ve kabul ediyorum',
                                      style: TextStyle(color: Colors.grey, fontSize: 15, fontWeight: FontWeight.w500),
                                    )
                                  ]),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    AppButton.standart(
                        onTap: () {
                          registerController.register();
                        },
                        buttonText: 'Kayıt Ol'),
                    const SizedBox(
                      height: 22,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Hesabınız var mı? ',
                          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: Colors.grey.shade600),
                        ),
                        GestureDetector(
                          onTap: () {
                            Go.to.page(PageRoutes.loginPage);
                          },
                          child: const Text(
                            'Giriş Yap',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w500, color: Color.fromARGB(255, 255, 95, 2)),
                          ),
                        ),
                      ],
                    )
                  ],
                );
              }),
            ),
          ],
        ));
  }
}
