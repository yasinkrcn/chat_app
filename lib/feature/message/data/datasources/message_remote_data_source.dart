import 'dart:convert';
import 'dart:io';

import 'package:chat_app/core/_core_exports.dart';
import 'package:chat_app/core/constants/app_constants.dart';
import 'package:chat_app/feature/message/data/models/chat_model.dart';
import 'package:dio/dio.dart';
import 'package:uuid/uuid.dart';

class MessageRemoteDataSource {
  Future<List<UserModel>> fetchMessageUsers() async {
    Query query = Fb().firestore.collection('users');

    List<UserModel> chatUserList = [];

    QuerySnapshot querySnapshot = await query.get();

    chatUserList = querySnapshot.docs.map((doc) => UserModel.fromFirestore(doc)).toList();

    chatUserList.removeWhere(
        (index) => index.id == Fb().auth.currentUser!.uid); // id si bize eşit olan kullanıcıyı listeden çıkardık

    return chatUserList;
  }

  Future<String> sendImage({
    required String receiverToken,
    required String chatRoomId,
    required File? imageFile,
  }) async {
    String fileName = const Uuid().v1();
    int status = 1;

    late String imageUrl;

    Reference ref = Fb().storage.ref().child('images').child("$fileName.jpg");

    var uploadTask = await ref.putFile(imageFile!).catchError((error) async {
      await Fb().firestore.collection('chatroom').doc(chatRoomId).collection('chats').doc(fileName).delete();

      status = 0;
    });

    if (status == 1) {
      imageUrl = await uploadTask.ref.getDownloadURL();

      await Fb().firestore.collection('chatroom').doc(chatRoomId).collection('chats').doc(fileName).set({
        "sendby": Fb().auth.currentUser!.uid,
        "message": imageUrl,
        "type": "img",
        "time": DateTime.now(),
      });

      print(imageUrl);
    }
    return imageUrl;
  }

  Future<void> sendTextMessage({
    required String message,
    required String chatRoomId,
  }) async {
    ChatModel item = ChatModel(
      message: message,
      sendby: Fb().auth.currentUser!.uid,
      type: "text",
      time: Timestamp.now(),
    );

    await Fb().firestore.collection('chatroom').doc(chatRoomId).collection('chats').add(item.toMap());
  }

  Future<List<ChatModel>> fetchMessages({required String chatRoomId, required Timestamp? lastMessageTime}) async {
    final QuerySnapshot<Map<String, dynamic>> value = await FirebaseFirestore.instance
        .collection('chatroom')
        .doc(chatRoomId)
        .collection('chats')
        .orderBy("time", descending: true)
        .limit(15)
        .startAfter([
      Timestamp(lastMessageTime?.seconds ?? Timestamp.now().seconds,
          lastMessageTime?.nanoseconds ?? Timestamp.now().nanoseconds)
    ]).get();

    List<ChatModel> chatMessages = value.docs.map((doc) => ChatModel.fromSnapshot(doc)).toList();

    return chatMessages;
  }

  Future<void> sendFirebaseNotification({
    required String senderName,
    required String message,
    required String receiverToken,
  }) async {
    String url = AppConstants().fcmUrl;

    Map<String, dynamic> data = {
      "to": receiverToken,
      "notification": {
        "title": senderName,
        "body": message,
      },
      "data": {
        "key1": "value1",
        "key2": "value2",
      }
    };

    String firebaseKey = AppConstants().firebaseKey;
    final dio = Dio();

    final response = await dio.post(
      url,
      options: Options(
        headers: <String, dynamic>{
          "Authorization": "key=$firebaseKey",
          "Content-Type": "application/json",
        },
      ),
      data: json.encode(data),
    );
    if (response.statusCode == 200) {
      if (kDebugMode) {
        print('Push notification sent successfully.');
      }
    } else {
      if (kDebugMode) {
        print('Request failed with status: ${response.statusCode}.');
      }
    }
  }
}
