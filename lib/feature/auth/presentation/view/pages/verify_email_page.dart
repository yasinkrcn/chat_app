import 'package:chat_app/core/_core_exports.dart';
import 'package:chat_app/feature/auth/presentation/view_model/verify_email_view_model.dart';

class VerifyEmailPage extends StatefulWidget {
  const VerifyEmailPage({super.key});

  @override
  State<VerifyEmailPage> createState() => _VerifyEmailPageState();
}

class _VerifyEmailPageState extends State<VerifyEmailPage> {
  @override
  void initState() {
    super.initState();

    sl<VerifyEmailViewModel>().verifyEmailInitState();
  }

  @override
  void dispose() {
    sl<VerifyEmailViewModel>().timerDispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, VerifyEmailViewModel prov, child) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: const Text("Email Doğrulama"),
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "E-mail adresinize doğrulama kodu gönderilmiştir.",
                  style: TextStyle(fontSize: 22),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 36,
                ),
                Visibility(
                  visible: prov.isActiveButton == false,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Text(
                      "Tekrar mail göndermek için "
                      "${prov.seconds}"
                      " saniye bekleyiniz.",
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                AppButton.standart(
                    isActive: prov.isActiveButton,
                    onTap: () {
                      prov.isActiveButton ? prov.sendVerificationEmail() : null;
                    },
                    buttonText: "Tekrar Gönder"),
                const SizedBox(
                  height: 16,
                ),
                AppButton.outline(
                    onTap: () {
                      FirebaseAuth.instance.signOut();
                      Go.to.page(PageRoutes.loginPage);
                    },
                    buttonText: "İptal Et"),
              ],
            ),
          ),
        );
      },
    );
  }
}
