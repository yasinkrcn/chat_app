import 'dart:ui';

class AppConstants {
  static final AppConstants _instance = AppConstants._init();
  AppConstants._init();

  factory AppConstants() {
    return _instance;
  }

  //Tasarım yapılan cihazın ekran boyutları
  Size designDeviceSize = const Size(375, 812);

  String appName = "chat_app";
}
