import 'dart:io';

import 'package:chat_app/core/_core_exports.dart';
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
    required String receiverToken,
  }) async {
    Map<String, dynamic> messages = {
      "sendby": Fb().auth.currentUser!.uid,
      "message": message,
      "type": "text",
      "time": DateTime.now(),
    };

    // sendPushNotification(
    //   title: sl<LoginViewModel>().firestoreUser.name!,
    //   body: messageController.text,
    //   receiverToken: receiverToken,
    // );

    await Fb().firestore.collection('chatroom').doc(chatRoomId).collection('chats').add(messages);
  }
}
