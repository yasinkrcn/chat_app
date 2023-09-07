import 'package:chat_app/core/_core_exports.dart';

class LoginViewModel extends ChangeNotifier {
  SaveDataFromKey saveDataFromKey = sl<SaveDataFromKey>();
  RemoveDataFromKey removeDataFromKey = sl<RemoveDataFromKey>();
  AuthRepository authRepository = sl<AuthRepository>();

  final TextEditingController emailController = TextEditingController(text: "pazaxcz@pretreer.com");
  final TextEditingController passwordController = TextEditingController(text: "121212");

  UserModel userInfo = UserModel();

  Future<void> fetchUserInfo() async {
    final res = await authRepository.getUserInfo(userId: FirebaseAuth.instance.currentUser!.uid);

    res.fold((failure) {
      showCustomMessenger(CustomMessengerState.ERROR, failure.message);
    }, (data) async {
      userInfo = data;

      checkFCMToken();

      await sl.getAsync<UserModel>().then(
        (userModel) {
          userModel.assignData(data);

          return userModel;
        },
      );

      print(sl<UserModel>().name);

      notifyListeners();

      // print("object");

      // print(sl<UserModel>().name);
      // print("object66");
    });
  }

  // void aaaaaaa() async {
  //   await sl.getAsync<UserModel>().then(
  //     (userModel) {
  //       userModel.name = "aaaaaaaaa";

  //       return userModel;
  //     },
  //   );

  //   print(sl<UserModel>().name);
  //   notifyListeners();
  // }

  Future<void> checkFCMToken() async {
    String? token = await FirebaseMessagingService().getFCMToken();

    if (token != null && userInfo.messageToken != token) {
      userInfo.messageToken = token;

      await authRepository.saveUserInfo(userModel: userInfo);

      fetchUserInfo();
    }
  }

  Future<void> login() async {
    final res =
        await authRepository.loginWithEmailAndPassword(email: emailController.text, password: passwordController.text);
    res.fold((failure) {
      showCustomMessenger(CustomMessengerState.ERROR, failure.message);
    }, (data) async {
      if (FirebaseAuth.instance.currentUser!.emailVerified == true) {
        fetchUserInfo();

        saveDataFromKey(
          SharedPreferenceKeyWithValueParams(
            key: SharedPreferencesKeys.CACHE_USER_INFO,
            value: userInfo.toJson(),
          ),
        );

        clearController();

        Go.to.pageAndRemoveUntil(PageRoutes.bottomNavigationPage);
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

  Future<void> logOut() async {
    var res = await authRepository.signOut();
    res.fold((failure) {
      showCustomMessenger(CustomMessengerState.ERROR, failure.message);
    }, (data) {
      showCustomMessenger(CustomMessengerState.SUCCESS, "Hesabınızdan çıkış yapıldı");

      Go.to.pageAndRemoveUntil(PageRoutes.loginPage);
    });
  }
}
