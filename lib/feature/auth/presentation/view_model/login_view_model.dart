import 'package:chat_app/core/_core_exports.dart';

class LoginViewModel extends ChangeNotifier {
  SharedPreferences prefs = sl<SharedPreferences>();
  SaveDataFromKey saveDataFromKey = sl<SaveDataFromKey>();
  RemoveDataFromKey removeDataFromKey = sl<RemoveDataFromKey>();
  AuthRepository authRepository = sl<AuthRepository>();

  final TextEditingController emailController = TextEditingController(text: "itncudybpdsmvkc@pretreer.com");
  final TextEditingController passwordController = TextEditingController(text: "121212");

  UserModel userInfo = UserModel();

  Future<void> fetchUserInfo() async {
    try {
      final res = await authRepository.getUsers(userId: FirebaseAuth.instance.currentUser!.uid);

      res.fold((failure) {
        showCustomMessenger(CustomMessengerState.ERROR, failure.message);
      }, (data) {
        userInfo = data;

        // sl<UserModel>().email = data.email;
      });
    } catch (_) {}
  }

  Future<void> login() async {
    final res =
        await authRepository.loginWithEmailAndPassword(email: emailController.text, password: passwordController.text);
    res.fold((failure) {
      showCustomMessenger(CustomMessengerState.ERROR, failure.message);
    }, (data) async {
      if (FirebaseAuth.instance.currentUser!.emailVerified == true) {
        await fetchUserInfo();

        saveDataFromKey(
          SharedPreferenceKeyWithValueParams(
            key: SharedPreferencesKeys.CACHE_USER_INFO,
            value: userInfo.toJson(),
          ),
        );

        clearController();

        Go.to.pageAndRemoveUntil(PageRoutes.messagePage);
        showCustomMessenger(CustomMessengerState.SUCCESS, "Hoşgeldiniz");
      } else {
        Go.to.page(PageRoutes.verifyEmailPage);
      }
    });
  }

  void clearController() {
    emailController.clear();
    passwordController.clear();
  }

  Future<void> resetPassword() async {
    FirebaseAuth.instance.sendPasswordResetEmail(email: emailController.text);

    emailController.clear();

    Go.to.pageAndRemoveUntil(PageRoutes.loginPage);

    showCustomMessenger(CustomMessengerState.SUCCESS, "Mail adresinize şifre yenileme bağlantısı gönderildi.");
  }

  UserModel firestoreUser = UserModel();

  bool isAnonym() {
    return FirebaseAuth.instance.currentUser == null;
  }
}
