// import 'dart:convert';
// import 'dart:io';

// import 'package:chat_app/core/_core_exports.dart';
// import 'package:dio/dio.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:http/http.dart' as http;

// class NotificationService {
//   final FlutterLocalNotificationsPlugin notificationsPlugin = FlutterLocalNotificationsPlugin();

//   Future<void> initNotification() async {
//     AndroidInitializationSettings initializationSettingsAndroid =
//         const AndroidInitializationSettings('@mipmap/ic_launcher');

//     var initializationSettingsIOS = DarwinInitializationSettings(
//         requestAlertPermission: true,
//         requestBadgePermission: true,
//         requestSoundPermission: true,
//         onDidReceiveLocalNotification: (int id, String? title, String? body, String? payload) async {});

//     var initializationSettings = InitializationSettings(
//       android: initializationSettingsAndroid,
//       iOS: initializationSettingsIOS,
//     );
//     await notificationsPlugin.initialize(initializationSettings,
//         onDidReceiveNotificationResponse: (NotificationResponse notificationResponse) async {});
//   }

//   notificationDetails({String? imageUrl}) async {
//     return NotificationDetails(
//       android: AndroidNotificationDetails(
//         'channelId',
//         'channelName',
//         importance: Importance.max,
//         styleInformation: imageUrl != null
//             ? BigPictureStyleInformation(
//                 FilePathAndroidBitmap(await _saveImageLocally(imageUrl, "bigPicture")),
//               )
//             : null,
//       ),
//       iOS: const DarwinNotificationDetails(),
//     );
//   }

//   Future showNotification({
//     int id = 0,
//     String? title,
//     String? body,
//     String? payLoad,
//     String? imageUrl,
//   }) async {
//     return notificationsPlugin.show(
//       id,
//       title,
//       body,
//       await notificationDetails(imageUrl: imageUrl),
//     );
//   }

//   Future<String> _saveImageLocally(String url, String fileName) async {
//     final documentDirectory = await getApplicationDocumentsDirectory();
//     final filePath = '${documentDirectory.path}/$fileName';
//     final response = await http.get(Uri.parse(url));

//     final file = File(filePath);

//     await file.writeAsBytes(response.bodyBytes);
//     return filePath;
//   }
// }
