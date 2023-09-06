import 'package:chat_app/core/_core_exports.dart';

class PermissionManager {
  Permission notification = Permission.notification;

  Future<void> notificationPermission() async {
    if (!await notification.isGranted) {
      await notification.request();
    }
  }
}
