// ignore_for_file: constant_identifier_names

import 'package:chat_app/core/_core_exports.dart';
import 'package:chat_app/feature/home/presentation/view/pages/home_page.dart';
import 'package:chat_app/feature/message/presentation/view/pages/message_page.dart';
import 'package:chat_app/feature/settings/presentation/view/pages/settings_page.dart';

enum BottomNavigationBarState { HOME, MESSAGE, SETTINGS }

extension BottomNavigationBarStateExtension on BottomNavigationBarState {
  int stateToPageIndex() {
    switch (this) {
      case BottomNavigationBarState.HOME:
        return 0;
      case BottomNavigationBarState.MESSAGE:
        return 1;
      case BottomNavigationBarState.SETTINGS:
        return 2;
    }
  }

  BottomNavigationBarState indexToState(int pageIndex) {
    switch (pageIndex) {
      case 0:
        return BottomNavigationBarState.HOME;
      case 1:
        return BottomNavigationBarState.MESSAGE;
      case 2:
        return BottomNavigationBarState.SETTINGS;

      default:
        return BottomNavigationBarState.HOME;
    }
  }

  Color stateToActiveColor() {
    switch (this) {
      case BottomNavigationBarState.HOME:
      case BottomNavigationBarState.MESSAGE:
      case BottomNavigationBarState.SETTINGS:
        return AppColors.white;
    }
  }

  String stateToAssetPath() {
    switch (this) {
      case BottomNavigationBarState.HOME:
        return AssetPaths().home;
      case BottomNavigationBarState.MESSAGE:
        return AssetPaths().message;

      case BottomNavigationBarState.SETTINGS:
        return AssetPaths().settings;
    }
  }

  double stateToAssetPathSize() {
    switch (this) {
      case BottomNavigationBarState.HOME:
        return 30.h;
      case BottomNavigationBarState.MESSAGE:
        return 30.h;

      case BottomNavigationBarState.SETTINGS:
        return 30.h;
    }
  }

  String stateToTitle() {
    switch (this) {
      case BottomNavigationBarState.HOME:
        return "Ana Sayfa";
      case BottomNavigationBarState.MESSAGE:
        return "Mesajlar";
      case BottomNavigationBarState.SETTINGS:
        return "Ayarlar";
    }
  }

  Widget buildBody() {
    switch (this) {
      case BottomNavigationBarState.HOME:
        return const HomePage();
      case BottomNavigationBarState.MESSAGE:
        return const MessagePage();
      case BottomNavigationBarState.SETTINGS:
        return const SettingsPage();
    }
  }

  Color pageBackGroundColor() {
    switch (this) {
      case BottomNavigationBarState.HOME:
        return Colors.blue;
      case BottomNavigationBarState.MESSAGE:
        return Colors.blue;
      case BottomNavigationBarState.SETTINGS:
        return Colors.blue;
    }
  }
}
