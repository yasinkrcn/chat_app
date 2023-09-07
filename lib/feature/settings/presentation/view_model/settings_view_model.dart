import 'dart:io';
import 'package:chat_app/core/_core_exports.dart';
import 'package:chat_app/feature/settings/domain/repositories/settings_repo.dart';

class SettingsViewModel extends ChangeNotifier {
  File? imageFile;

  SettingsRepo settingsRepo = sl<SettingsRepo>();

  Future getImage() async {
    ImagePicker picker = ImagePicker();

    await picker.pickImage(source: ImageSource.gallery).then((xFile) {
      if (xFile != null) {
        imageFile = File(xFile.path);

        notifyListeners();
      }
    });
  }

  void removeImage() async {
    await imageFile?.delete();

    imageFile = null;
    notifyListeners();
  }

  TextEditingController nameController = TextEditingController(text: sl<UserModel>().name);

  TextEditingController phoneController = TextEditingController(text: sl<UserModel>().number);

  UserModel userModel = sl<UserModel>();

  Future<void> updateUserData() async {
    if (imageFile != null) {
      String imageUrl = await sl<RegisterViewModel>().getImageUrlFromFirebase(imageFile: imageFile);

      userModel.userImage = imageUrl;
    }

    userModel.name = nameController.text;
    userModel.number = phoneController.text;

    var res = await settingsRepo.updateUserInformations(user: userModel);

    res.fold((failure) {
      showCustomMessenger(CustomMessengerState.ERROR, "Bir hata oluştu");
    }, (data) {
      showCustomMessenger(CustomMessengerState.SUCCESS, "Kullanıcı Güncelleme Başarılı");

      sl<LoginViewModel>().fetchUserInfo();
    });
  }
}
