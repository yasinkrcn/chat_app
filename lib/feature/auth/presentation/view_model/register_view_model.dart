import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:chat_app/core/_core_exports.dart';
import 'package:chat_app/core/utils/local_data_source/shared_preferences/domain/entities/shared_preferences_key_params.dart';
import 'package:chat_app/core/utils/local_data_source/shared_preferences/domain/usecases/remove_data_from_key.dart';
import 'package:chat_app/feature/auth/data/repositories/auth_repo_impl.dart';
import 'package:chat_app/feature/auth/domain/repositories/auth_repo.dart';
import 'package:chat_app/feature/auth/presentation/view_model/verify_email_view_model.dart';

class RegisterViewModel extends ChangeNotifier {
  SharedPreferences prefs = sl<SharedPreferences>();
  SaveDataFromKey saveDataFromKey = sl<SaveDataFromKey>();
  RemoveDataFromKey removeDataFromKey = sl<RemoveDataFromKey>();
  AuthRepository authRepository = sl<AuthRepository>();

  TextEditingController nameController = TextEditingController();
  TextEditingController surnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> register() async {
    try {
      final data = await authRepository.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      data.fold((failure) {
        showCustomMessenger(CustomMessengerState.ERROR, failure.message);
      }, (data) async {
        final userModel = UserModel(
          email: emailController.text,
          name: nameController.text,
          surname: surnameController.text,
          id: data.user?.uid,
        );
        try {
          final saveData = await authRepository.saveUserInfo(userModel: userModel);

          saveData.fold((failure) {
            showCustomMessenger(CustomMessengerState.ERROR, failure.message);
          }, (result) {
            saveDataFromKey(
              SharedPreferenceKeyWithValueParams(
                key: SharedPreferencesKeys.CACHE_USER_INFO,
                value: userModel.toJson(),
              ),
            );

            // clearController();

            Go.to.page(PageRoutes.verifyEmailPage);
            // showCustomMessenger(CustomMessengerState.SUCCESS, "Kullanıcı kayıt başarılı");
          });
        } catch (_) {}
      });
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "invalid-email":
          return showCustomMessenger(CustomMessengerState.ERROR, "Mail adresiniz hatalıdır.");
        case "email-already-in-use":
          return showCustomMessenger(CustomMessengerState.ERROR, "Mail adresi kullanılmaktadır.");
        case "weak-password":
          return showCustomMessenger(CustomMessengerState.ERROR, "Minimum 6 haneli bir şifre giriniz.");
      }
    }
  }

  String? getUserFirebaseId() {
    return FirebaseAuth.instance.currentUser!.uid;
  }

  void clearController() {
    nameController.clear();
    surnameController.clear();
    emailController.clear();
    passwordController.clear();
  }

  Future<void> logout() async {
    FirebaseAuth.instance.signOut();

    await removeDataFromKey(SharedPreferenceKeyParams(key: SharedPreferencesKeys.CACHE_USER_INFO));
    Go.to.pageAndRemoveUntil(PageRoutes.loginPage);
    showCustomMessenger(CustomMessengerState.SUCCESS, "Çıkış Yapıldı");

    clearController();
  }

  bool isAccept = false;

  void isTermsAndConditionAccept(bool value) {
    isAccept = value;

    notifyListeners();
  }

  void privacyPolicy(context) {
    showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        return Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 36),
            child: Container(
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24)),
              child: Stack(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(16),
                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      // child: PrivacyPolicyText(),
                    ),
                  ),
                  Positioned(
                    top: 16,
                    right: 16,
                    child: GestureDetector(
                      onTap: () => Go.to.back(),
                      child: Container(
                        decoration: BoxDecoration(color: Colors.grey.shade300, shape: BoxShape.circle),
                        child: const Icon(
                          Icons.close,
                          size: 36,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );

    notifyListeners();
  }

  void termsOfService(context) {
    showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        return Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 36),
            child: Container(
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24)),
              child: Stack(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(16),
                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      // child: TermsOfServices(),
                    ),
                  ),
                  Positioned(
                    top: 16,
                    right: 16,
                    child: GestureDetector(
                      onTap: () => Go.to.back(),
                      child: Container(
                        decoration: BoxDecoration(color: Colors.grey.shade300, shape: BoxShape.circle),
                        child: const Icon(
                          Icons.close,
                          size: 36,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );

    notifyListeners();
  }
}
