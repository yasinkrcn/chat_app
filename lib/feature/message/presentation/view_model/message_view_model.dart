import 'package:chat_app/core/_core_exports.dart';

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

  TextEditingController searchText = TextEditingController();

  void searchUser() async {
    final query = FirebaseFirestore.instance.collection("users").doc(searchText.text);

    final searchResults = await query.get();
  }
}
