import 'dart:async';
import 'dart:io';
import 'package:chat_app/core/_core_exports.dart';
import 'package:chat_app/feature/message/data/models/chat_model.dart';

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
      // sendFirebaseNotification(
      //       senderName: _messagePerson.name!,
      //       message: messageController.text,
      //       receiverToken: _messagePerson.messageToken!);
    });
  }

  Future<void> sendTextMessage() async {
    if (messageController.text.isNotEmpty) {
      var res = await messageRepo.sendTextMessage(
        message: messageController.text,
        chatRoomId: chatRoomId,
      );

      res.fold((failure) {
        showCustomMessenger(CustomMessengerState.ERROR, failure.message);
      }, (data) {
        sendFirebaseNotification(
            senderName: _messagePerson.name!,
            message: messageController.text,
            receiverToken: _messagePerson.messageToken!);
        messageController.clear();
      });
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

  List<DocumentSnapshot> chatDocuments = [];

  bool isLoading = false;

  Timestamp? lastMessageTime;
  Timestamp? newMessageTime;

  bool firstData = false;
  bool isNewMessageServiceBegin = false;

  List<ChatModel> messageData = [];

  Timestamp? firstMessageTime;

  void openNewChat() {
    isNewMessagesubscription?.cancel();
    messageData.clear();

    firstData = false;
    firstMessageTime = null;
    lastMessageTime = null;
    newMessageTime = null;
    isNewMessageServiceBegin = false;

    scroolController.dispose();
    scroolController = ScrollController();

    notifyListeners();
  }

  Future<void> fetchMessages() async {
    var res = await messageRepo.fetchMessages(chatRoomId: chatRoomId, lastMessageTime: lastMessageTime);

    res.fold((failure) {
      showCustomMessenger(CustomMessengerState.ERROR, failure.message);
    }, (data) {
      if (data.isNotEmpty) {
        ChatModel getData = data[data.length - 1]; //Burada gelen son mesajın tarihini alıyoruz.
        lastMessageTime = getData.time; //Daha eski mesajlara bakmak istediğimizde bu taihe göre sorgu atıyoruz.

        if (!firstData) {
          messageData = data;

          firstMessageTime = messageData.first.time ?? Timestamp.now();

          notifyListeners();
        } else {
          List<ChatModel> newMessageData = data;
          messageData.addAll(newMessageData);

          notifyListeners();
        }
      }
    });
  }

  Future<void> getChatMessages() async {
    if (!isNewMessageServiceBegin) {
      listenScroolController();
      newMessageQuery();
      fetchNewMessages();
      isNewMessageServiceBegin = true;
    }
    if (lastMessageTime != null) {
      firstData = true;
    }

    fetchMessages();
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

        if (newMessageTime!.seconds > (firstMessageTime?.seconds ?? 0)) {
          var newMessageData = event.docs.map((document) {
            return ChatModel.fromSnapshot(document);
          }).toList();

          messageData.insert(0, newMessageData[0]);
          notifyListeners();
        }
      }
    });
  }

  void sendFirebaseNotification({
    required String senderName,
    String? message,
    required String receiverToken,
    String? imageUrl,
  }) async {
    final res = await messageRepo.sendFirebaseNotification(
      imageUrl: imageUrl,
      senderName: sl<UserModel>().name!,
      message: message,
      receiverToken: receiverToken,
    );

    res.fold((failure) {
      showCustomMessenger(CustomMessengerState.WARNING, failure.message);
    }, (data) {});
  }
}
