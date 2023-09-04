import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:chat_app/core/_core_exports.dart';
import 'package:chat_app/feature/message/data/models/chat_model.dart';
import 'package:dio/dio.dart';

class ChatViewModel extends ChangeNotifier {
  final MessageRepo messageRepo;

  ChatViewModel({
    required this.messageRepo,
  });

  final TextEditingController messageController = TextEditingController();

  late String chatRoomId;

  UserModel _messagePerson = UserModel();

  UserModel get messagePerson => _messagePerson;

  void setMessagePerson(UserModel targetUser) {
    _messagePerson = targetUser;
  }

  void setChatRoomId({required String user1, required String user2}) {
    if (user1[0].toLowerCase().codeUnits[0] > user2.toLowerCase().codeUnits[0]) {
      chatRoomId = "$user1$user2";
    } else {
      chatRoomId = "$user2$user1";
    }
  }

  void startMessage({required UserModel targetUser}) async {
    setMessagePerson(targetUser);

    setChatRoomId(user1: Fb().auth.currentUser!.uid, user2: targetUser.id!);

    openNewChat();

    getChatMessages();

    Go.to.page(PageRoutes.chatPage);
  }

  void pickPictureFromGallery() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      uploadImage(
        imageFile: File(pickedFile.path),
      );
    }
  }

  Future<void> uploadImage({
    required File? imageFile,
  }) async {
    var res = await messageRepo.sendImage(
      receiverToken: _messagePerson.messageToken!,
      chatRoomId: chatRoomId,
      imageFile: imageFile,
    );

    res.fold((failure) {
      showCustomMessenger(CustomMessengerState.ERROR, failure.message);
    }, (imageUrl) {
      sendPushNotification(
        title: sl<LoginViewModel>().firestoreUser.name!,
        body: messageController.text,
        receiverToken: _messagePerson.messageToken!,
        image: imageUrl,
      );
    });
  }

  Future<void> sendTextMessage() async {
    if (messageController.text.isNotEmpty) {
      var res = await messageRepo.sendTextMessage(
        message: messageController.text,
        chatRoomId: chatRoomId,
        receiverToken: "receiverToken",
      );

      messageController.clear();

      res.fold((failure) {
        showCustomMessenger(CustomMessengerState.ERROR, failure.message);
      }, (data) {});
    }
  }

  ScrollController scroolController = ScrollController();

  void listenScroolController() {
    scroolController.addListener(() {
      if (scroolController.position.pixels == scroolController.position.maxScrollExtent) {
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

    scroolController.dispose();
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

  Stream<QuerySnapshot> newMessageQuery() {
    Stream<QuerySnapshot<Map<String, dynamic>>> newMessageDocument = Fb()
        .firestore
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
    isNewMessagesubscription = newMessageQuery().listen((event) {
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
