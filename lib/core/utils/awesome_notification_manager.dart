import 'package:awesome_notifications/awesome_notifications.dart';

class NotificationManager {
  void init() {
    AwesomeNotifications().initialize(
      "resource://mipmap/ic_launcher", // Uygulamanızın ikon kaynağı
      [
        NotificationChannel(
          channelKey: 'basic_channel',
          channelName: 'Basic Notifications',
          channelDescription: 'Basic Notifications Channel',
        ),
      ],
    );
  }

  Future<bool> requestPermission() async {
    return await AwesomeNotifications().requestPermissionToSendNotifications();
  }

  void showBasicNotification({required String title, required String body, String? image}) {
    AwesomeNotifications().createNotification(
      // actionButtons: [
      //   NotificationActionButton(
      //     key: 'ACTION_YES',
      //     label: 'Yes',
      //   ),
      //   NotificationActionButton(
      //     key: 'ACTION_NO',
      //     label: 'No',
      //   ),
      // ],
      content: NotificationContent(
        id: 0,
        channelKey: 'basic_channel',

        title: title,
        body: body,
        bigPicture: image,
        notificationLayout: NotificationLayout.BigPicture, // Bildirim düzenini belirlemek
      ),
    );
  }
}
