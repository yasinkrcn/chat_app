import 'package:chat_app/core/_core_exports.dart';

class HomeViewModel extends ChangeNotifier {
  HomeViewModel() {
    fetchOtherUsers();
  }
  final _messageRepo = sl<MessageRepo>();

  UIState<List<UserModel>> users = UIState.idle();

  Future<void> fetchOtherUsers() async {
    users = UIState.loading();
    notifyListeners();
    var res = await _messageRepo.fetchMessageUsers();

    res.fold((failure) {
      users = UIState.error(failure.message);
    }, (data) {
      users = UIState.success(data);
    });
    notifyListeners();
  }
}
