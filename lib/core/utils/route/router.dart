import 'package:chat_app/feature/auth/presentation/view/pages/forgot_password_page.dart';
import 'package:chat_app/feature/auth/presentation/view/pages/login_page.dart';
import 'package:chat_app/feature/auth/presentation/view/pages/register_page.dart';
import 'package:chat_app/feature/auth/presentation/view/pages/splash_page.dart';
import 'package:chat_app/feature/auth/presentation/view/pages/verify_email_page.dart';
import 'package:flutter/cupertino.dart';

class PageRoutes {
  static const String splashPage = "/splashPage";
  static const String loginPage = "/loginPage";
  static const String registerPage = "/registerPage";
  static const String verifyEmailPage = "/verifyEmailPage";
  static const String forgotPasswordPage = "/forgotPasswordPage";
  static const String homePage = "/homePage";
  static const String addTaskPage = "/addTaskPage";
}

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case PageRoutes.splashPage:
      return CupertinoPageRoute(builder: (_) => const SplashPage());
    case PageRoutes.loginPage:
      return CupertinoPageRoute(builder: (_) => const LoginPage());

    case PageRoutes.registerPage:
      return CupertinoPageRoute(builder: (_) => const RegisterPage());

    case PageRoutes.verifyEmailPage:
      return CupertinoPageRoute(builder: (_) => const VerifyEmailPage());

    case PageRoutes.forgotPasswordPage:
      return CupertinoPageRoute(builder: (_) => const ForgotPasswordPage());
    // case PageRoutes.homePage:
    //   return CupertinoPageRoute(builder: (_) => const HomePage());

    // case PageRoutes.addTaskPage:
    //   return CupertinoPageRoute(builder: (_) => const AddTaskPage());

    default:
      return CupertinoPageRoute(builder: (_) => const LoginPage());
  }
}
