import 'dart:ui';

class AppConstants {
  static final AppConstants _instance = AppConstants._init();
  AppConstants._init();

  factory AppConstants() {
    return _instance;
  }

  //Tasarım yapılan cihazın ekran boyutları
  Size designDeviceSize = const Size(375, 812);

  String appName = "ChatApp";

  String fcmUrl = "https://fcm.googleapis.com/fcm/send";

  String firebaseKey =
      "AAAAH0MlHrE:APA91bH-mqOZULWQ_VfzwTzeMObO5e-3FAW5bn_wTNbyn1GVqAy6XrTp_liWEntypNpSmgISGfkFpBOt-yvngO2q07zxK_35XiRm2j_rwIhAr48zFPlCYhItWfSHlXpeDNQ3iI8QqMh-";
}
