import 'package:chat_app/core/_core_exports.dart';
import 'package:chat_app/feature/auth/presentation/view/pages/forgot_password_page.dart';
import 'package:chat_app/feature/auth/presentation/view/pages/login_page.dart';
import 'package:chat_app/feature/auth/presentation/view/pages/register_page.dart';
import 'package:chat_app/feature/auth/presentation/view/pages/splash_page.dart';
import 'package:chat_app/feature/auth/presentation/view/pages/verify_email_page.dart';
import 'package:chat_app/feature/bottom_nav_bar/view/pages/bottom_navigation_page.dart';
import 'package:chat_app/feature/message/presentation/view/pages/chat_page.dart';
import 'package:chat_app/feature/message/presentation/view/pages/contact_details_page.dart';
import 'package:chat_app/feature/message/presentation/view/pages/message_page.dart';
import 'package:chat_app/feature/settings/presentation/view/pages/profile_settings.dart';
import 'package:chat_app/feature/settings/presentation/view/pages/settings_page.dart';
import 'package:flutter/cupertino.dart';

class PageRoutes {
  static const String splashPage = "/splashPage";
  static const String loginPage = "/loginPage";
  static const String registerPage = "/registerPage";
  static const String verifyEmailPage = "/verifyEmailPage";
  static const String forgotPasswordPage = "/forgotPasswordPage";
  static const String messagePage = "/messagePage";
  static const String chatPage = "/chatPage";

  static const String contactDetailsPage = "/contactDetailsPage";
  static const String settingsPage = "/settingsPage";
  static const String profileSettingsPage = "/profileSettingsPage";
  static const String bottomNavigationPage = "/bottomNavigationPage";
}

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case PageRoutes.splashPage:
      return CupertinoPageRoute(builder: (_) => const SplashPage());
    case PageRoutes.bottomNavigationPage:
      return CupertinoPageRoute(builder: (_) => const BottomNavigationPage());

    case PageRoutes.loginPage:
      return CupertinoPageRoute(builder: (_) => const LoginPage());

    case PageRoutes.registerPage:
      return CupertinoPageRoute(builder: (_) => const RegisterPage());

    case PageRoutes.verifyEmailPage:
      return CupertinoPageRoute(builder: (_) => const VerifyEmailPage());

    case PageRoutes.forgotPasswordPage:
      return CupertinoPageRoute(builder: (_) => const ForgotPasswordPage());
    case PageRoutes.contactDetailsPage:
      final UserModel userModel = settings.arguments as UserModel;
      return CupertinoPageRoute(
          builder: (_) => ContactDetailsPage(
                userData: userModel,
              ));
    case PageRoutes.messagePage:
      return CupertinoPageRoute(builder: (_) => const MessagePage());

    case PageRoutes.chatPage:
      return CupertinoPageRoute(builder: (_) => const ChatPage());

    case PageRoutes.settingsPage:
      return CupertinoPageRoute(builder: (_) => const SettingsPage());

    case PageRoutes.profileSettingsPage:
      return CupertinoPageRoute(builder: (_) => const ProfileSettingsPage());

    // case PageRoutes.addTaskPage:
    //   return CupertinoPageRoute(builder: (_) => const AddTaskPage());

    default:
      return CupertinoPageRoute(builder: (_) => const LoginPage());
  }
}
