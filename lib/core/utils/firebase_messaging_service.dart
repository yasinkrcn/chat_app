// ignore_for_file: non_constant_identifier_names

import 'package:chat_app/core/_core_exports.dart';

class FirebaseMessagingService {
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  void initialize() {
    listenMessages();
    getFCMToken();
  }

  void listenMessages() {
    // _messaging.subscribeToTopic('all');

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      NotificationService().showNotification(
        title: message.notification?.title,
        body: message.notification?.body,
      );
      // Yeni bir bildirim geldiğinde burası çalışır
      // print('Yeni bildirim geldi: ${message.notification?.title}');
      // print('Yeni bildirim geldi: ${message.notification?.body}');
      // İsterseniz burada bildirimi işleyebilir veya görsel bir bildirim gösterebilirsiniz.
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      // Bildirim ile uygulama açıldığında burası çalışır
      // print('Bildirim ile uygulama açıldı: ${message.notification?.title}');
      // İsterseniz burada bildirimi işleyebilir veya belirli bir sayfaya yönlendirebilirsiniz.
    });
  }

  Future<String?> getFCMToken() async {
    String? token = await _messaging.getToken();

    if (kDebugMode) {
      print(token);
    }

    return token;
  }
}
