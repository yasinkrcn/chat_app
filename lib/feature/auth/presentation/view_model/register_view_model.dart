import 'dart:async';
import 'dart:io';
import 'package:chat_app/core/_core_exports.dart';

import 'package:uuid/uuid.dart';

class RegisterViewModel extends ChangeNotifier {
  SharedPreferences prefs = sl<SharedPreferences>();
  SaveDataFromKey saveDataFromKey = sl<SaveDataFromKey>();
  RemoveDataFromKey removeDataFromKey = sl<RemoveDataFromKey>();
  AuthRepository authRepository = sl<AuthRepository>();

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  File? imageFile;

  UserModel userModel = UserModel();

  Future getImage() async {
    ImagePicker picker = ImagePicker();
    await picker.pickImage(source: ImageSource.gallery).then((xFile) {
      if (xFile != null) {
        imageFile = File(xFile.path);
        notifyListeners();
        // uploadImage(imageFile: imageFile);
      }
    });
  }

  void removeImage() async {
    await imageFile?.delete();
    imageFile = null;
    notifyListeners();
  }

  Future<String> getImageUrlFromFirebase({required imageFile}) async {
    late String imageUrl;
    var res = await authRepository.getImageUrlFromFirebase(imageFile: imageFile!);

    res.fold((failure) {
      showCustomMessenger(CustomMessengerState.ERROR, failure.message);
    }, (data) {
      imageUrl = data;
    });

    return imageUrl;
  }

  Future<void> register() async {
    final data = await authRepository.createUserWithEmailAndPassword(
      email: emailController.text,
      password: passwordController.text,
    );

    data.fold((failure) {
      showCustomMessenger(CustomMessengerState.ERROR, failure.message);
    }, (data) async {
      userModel.userImage = await getImageUrlFromFirebase(imageFile: imageFile);
      userModel.email = emailController.text;
      userModel.name = nameController.text;
      userModel.number = phoneNumberController.text;
      userModel.id = data.user?.uid;
      userModel.messageToken = await FirebaseMessagingService().getFCMToken();

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
        });
      } catch (_) {}
    });
  }

  String? getUserFirebaseId() {
    return FirebaseAuth.instance.currentUser!.uid;
  }

  void clearController() {
    nameController.clear();
    phoneNumberController.clear();
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
