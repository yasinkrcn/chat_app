import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:chat_app/core/_core_exports.dart';
import 'package:chat_app/feature/message/data/models/chat_model.dart';
import 'package:dio/dio.dart';
import 'package:uuid/uuid.dart';

class ChatViewModel extends ChangeNotifier {
  final MessageRepo messageRepo;

  ChatViewModel({
    required this.messageRepo,
  });

  final TextEditingController messageController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String? chatRoomId;

  File? imageFile;

  void pickPictureFromGallery({
    required String receiverToken,
  }) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      uploadImage(
        receiverToken: receiverToken,
        imageFile: File(pickedFile.path),
      );
      print("Fotoğraf başarıyla seçildi, işlemler burada yapılır.");
    } else {
      print("Kullanıcı fotoğraf seçmeyi iptal etti veya bir hata oluştu.");
    }
  }

  Future uploadImage({
    required String receiverToken,
    required File? imageFile,
  }) async {
    String fileName = Uuid().v1();
    int status = 1;

    var ref = FirebaseStorage.instance.ref().child('images').child("$fileName.jpg");

    var uploadTask = await ref.putFile(imageFile!).catchError((error) async {
      await _firestore.collection('chatroom').doc(chatRoomId).collection('chats').doc(fileName).delete();

      status = 0;
    });

    if (status == 1) {
      String imageUrl = await uploadTask.ref.getDownloadURL();

      await _firestore.collection('chatroom').doc(chatRoomId).collection('chats').doc(fileName).set({
        "sendby": _auth.currentUser!.uid,
        "message": imageUrl,
        "type": "img",
        "time": DateTime.now(),
      });

      print(imageUrl);

      sendPushNotification(
        title: sl<LoginViewModel>().firestoreUser.name!,
        body: messageController.text,
        receiverToken: receiverToken,
        image: imageUrl,
      );
    }
  }

  void onSendMessage({
    required String receiverToken,
  }) async {
    if (messageController.text.isNotEmpty) {
      // changeScroolController();

      Map<String, dynamic> messages = {
        "sendby": _auth.currentUser!.uid,
        "message": messageController.text,
        "type": "text",
        "time": DateTime.now(),
      };

      sendPushNotification(
        title: sl<LoginViewModel>().firestoreUser.name!,
        body: messageController.text,
        receiverToken: receiverToken,
      );

      messageController.clear();
      await _firestore.collection('chatroom').doc(chatRoomId).collection('chats').add(messages);
    } else {
      print("Enter Some Text");
    }
  }

  ScrollController scroolController = ScrollController();

  void listenScroolController() {
    // fetchNewMessage();
    scroolController.addListener(() {
      // print(controller.position.pixels);

      if (scroolController.position.pixels == scroolController.position.maxScrollExtent) {
        // page++;
        print("*****************************************");
        getChatMessages();
      }
    });
  }

  late Future<QuerySnapshot<Map<String, dynamic>>> messageDocument;

  List<DocumentSnapshot> chatDocuments = [];

  bool isLoading = false;

  Timestamp? lastMessageTime;
  Timestamp? newMessageTime;

  bool ilkVeri = false;
  bool isNewMessageServiceBegin = false;

  List<ChatModel> messageData = [];

  List<ChatModel> newMessageData = [];

  int pagelimit = 15;

  Timestamp? ilkMesajTime;

  void openNewChat() {
    isNewMessagesubscription?.cancel();
    messageData.clear();

    ilkVeri = false;
    ilkMesajTime = null;
    lastMessageTime = null;
    newMessageTime = null;
    isNewMessageServiceBegin = false;

    scroolController.dispose(); // scroolController ı dispose ettik önceki verileri temizlendi. Şimdi tekrar çağrıcaz.
    scroolController = ScrollController();

    notifyListeners();
  }

  Future<void> getChatMessages() async {
    if (!isNewMessageServiceBegin) {
      listenScroolController();
      newMessageQuery();
      fetchNewMessages();
      isNewMessageServiceBegin = true;
    }
    if (lastMessageTime != null) {
      ilkVeri = true;
    }
    messageDocument = FirebaseFirestore.instance
        .collection('chatroom')
        .doc(chatRoomId)
        .collection('chats')
        .orderBy("time", descending: true)
        .limit(pagelimit)
        .startAfter([
      Timestamp(lastMessageTime?.seconds ?? Timestamp.now().seconds,
          lastMessageTime?.nanoseconds ?? Timestamp.now().nanoseconds)
    ]).get();

    getOldMessages();
  }

  //---------------------------------//

  void getOldMessages() {
    messageDocument.then(
      (value) {
        if (value.docs.isNotEmpty) {
          var getData = value.docs[value.docs.length - 1];
          lastMessageTime = getData.get("time");

          if (!ilkVeri) {
            messageData = value.docs.map((document) {
              return ChatModel.fromSnapshot(document);
            }).toList();

            ilkMesajTime = messageData.first.time ?? Timestamp.now();

            print(messageData.length);

            notifyListeners();
          } else {
            newMessageData = value.docs.map((document) {
              return ChatModel.fromSnapshot(document);
            }).toList();

            messageData.addAll(newMessageData);

            print(messageData.length);

            notifyListeners();
          }
        }
      },
    );
  }

  //---------------------------------//

  late Stream<QuerySnapshot> newMessageDocument;

  Stream<QuerySnapshot> newMessageQuery() {
    newMessageDocument = FirebaseFirestore.instance
        .collection('chatroom')
        .doc(chatRoomId)
        .collection('chats')
        .orderBy("time", descending: true)
        .limit(1)
        .snapshots();

    return newMessageDocument;
  }

  StreamSubscription<QuerySnapshot>? isNewMessagesubscription;

  void fetchNewMessages() async {
    isNewMessagesubscription = newMessageDocument.listen((event) {
      if (event.docs.isNotEmpty) {
        var getNewData = event.docs.first;

        newMessageTime = getNewData.get("time");

        if (newMessageTime!.seconds > (ilkMesajTime?.seconds ?? 0)) {
          var newMessageData = event.docs.map((document) {
            return ChatModel.fromSnapshot(document);
          }).toList();

          messageData.insert(0, newMessageData[0]);
          notifyListeners();
        }
      }
    });
  }

  void sendPushNotification({
    required String title,
    String? body,
    String? image,
    required String receiverToken,
  }) async {
    const url = "https://onesignal.com/api/v1/notifications";

    /// kRestApiKey is your OneSignal REST API key
    const restApiKey = "NjVjN2EwYzYtZjE1MS00YzBiLWI2Y2ItZmQxYTg2ZTNjM2Rh";
    const oneSignalAppID = "370ec5f1-4889-427e-b1aa-e14a753b72ee";
    final dio = Dio();
    try {
      final response = await dio.post(
        url,
        options: Options(
          headers: <String, String>{
            "Authorization": "Basic $restApiKey",
            "Content-Type": "application/json",
          },
        ),
        data: jsonEncode({
          "app_id": oneSignalAppID,
          "include_player_ids": [receiverToken],
          "headings": {"en": title},
          "contents": {"en": body == "" ? "." : body},
          "large_icon": image,
        }),
      );

      if (response.statusCode == 200) {
        print('Push notification sent successfully.');
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      print('Error occurred: $e');
    }
  }
}
