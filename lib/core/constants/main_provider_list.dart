import 'package:chat_app/feature/message/presentation/view_model/chat_view_model.dart';
import 'package:chat_app/feature/message/presentation/view_model/message_view_model.dart';
import 'package:provider/single_child_widget.dart';
import '../_core_exports.dart';

class MainProviderList {
  /// This list includes providers that should stand up when the application starts.
  static List<SingleChildWidget> mainProviderlist = [
    ChangeNotifierProvider(create: (_) => sl<LoginViewModel>()),
    ChangeNotifierProvider(create: (_) => sl<RegisterViewModel>()),
    ChangeNotifierProvider(create: (_) => sl<VerifyEmailViewModel>()),
    ChangeNotifierProvider(create: (_) => sl<MessageViewModel>()),
    ChangeNotifierProvider(create: (_) => sl<ChatViewModel>()),
    ChangeNotifierProvider(create: (_) => sl<BottomNavBarViewModel>()),
  ];

  /// This method returns the provider list that should stand up at the beginning of the application.
  static List<SingleChildWidget> getMainProviderList() {
    return mainProviderlist;
  }
}
