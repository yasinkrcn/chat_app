import 'package:chat_app/core/_core_exports.dart';
import 'package:chat_app/core/utils/ui_state.dart';
import 'package:chat_app/feature/message/domain/repositories/message_repo.dart';

class MessageViewModel extends ChangeNotifier {
  final MessageRepo messageRepo;

  MessageViewModel({
    required this.messageRepo,
  }) {
    getAllUser();
  }

  UIState<List<UserModel>> chatUserList = UIState.idle();

  void getAllUser() async {
    chatUserList = UIState.loading();
    notifyListeners();

    final fetchData = await messageRepo.fetchMessageUsers();

    fetchData.fold((failure) {
      chatUserList = UIState.error(failure.message);
    }, (data) {
      chatUserList = UIState.success(data);
    });
    notifyListeners();
  }

  String chatRoomId({required String user1, required String user2}) {
    if (user1[0].toLowerCase().codeUnits[0] > user2.toLowerCase().codeUnits[0]) {
      return "$user1$user2";
    } else {
      return "$user2$user1";
    }
  }

  TextEditingController searchText = TextEditingController();

  void searchUser() async {
    final query = FirebaseFirestore.instance.collection("users").doc(searchText.text);

    final searchResults = await query.get();
  }
}
