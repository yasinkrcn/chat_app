import 'dart:async';

import 'package:chat_app/core/_core_exports.dart';
import 'package:chat_app/feature/auth/presentation/view_model/register_view_model.dart';

class VerifyEmailViewModel extends RegisterViewModel {
  late bool isEmailVerified;
  bool canResendEmail = false;
  Timer? timer;
  Timer? textTimer;

  void verifyEmailInitState() async {
    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;

    if (!isEmailVerified) {
      await sendVerificationEmail();

      timer = Timer.periodic(const Duration(seconds: 3), (_) {
        checkEmailVerified();
      });
    }
  }

  void timerDispose() async {
    timer?.cancel();
    textTimer?.cancel();
  }

  Future<void> sendVerificationEmail() async {
    if (isActiveButton == true) {
      try {
        await authRepository.sendEmailVerificationCode();

        resendButtonTimer();
      } catch (_) {
        showCustomMessenger(CustomMessengerState.ERROR, "kod gönderilirken hata oluştu");
      }
    }
  }

  Future<void> checkEmailVerified() async {
    try {
      await FirebaseAuth.instance.currentUser!.reload();

      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
      notifyListeners();

      if (isEmailVerified) {
        timerDispose();
        Go.to.pageAndRemoveUntil(PageRoutes.homePage);
        showCustomMessenger(CustomMessengerState.SUCCESS, "Hoşgeldiniz");
      }
    } catch (e) {
      e.toString();
    }
  }

  bool isActiveButton = true;

  int seconds = 60;
  void resendButtonTimer() {
    isActiveButton = false;
    const oneSec = Duration(seconds: 1);
    textTimer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (seconds == 0) {
          timer.cancel();
          isActiveButton = true;
          notifyListeners();
        } else {
          seconds--;
          notifyListeners();
        }
      },
    );
    seconds = 60;
    // notifyListeners();
  }
}
