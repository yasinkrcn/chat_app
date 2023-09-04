// ignore_for_file: overridden_fields

import 'package:chat_app/core/error/failures/failure.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseFailure extends Failure {
  @override
  final String message;

  FirebaseFailure(this.message) : super(message);
}

class FirebaseExceptionManager {
  static Failure handleFirebaseException(FirebaseAuthException e) {
    switch (e.code) {
      case "invalid-email":
        // Geçersiz e-posta adresi hatası
        return FirebaseFailure("Geçersiz e-posta adresi.");
      case "user-disabled":
        // Kullanıcı devre dışı bırakıldı hatası
        return FirebaseFailure("Kullanıcı devre dışı bırakıldı.");
      case "user-not-found":
        // Kullanıcı bulunamadı hatası
        return FirebaseFailure("Kullanıcı bulunamadı.");
      case "wrong-password":
        // Yanlış şifre hatası
        return FirebaseFailure("Yanlış şifre.");
      case "email-already-in-use":
        // E-posta adresi zaten kullanılıyor hatası
        return FirebaseFailure("E-posta adresi zaten kullanılıyor.");
      case "operation-not-allowed":
        // Bu işlem izin verilmiyor hatası
        return FirebaseFailure("Bu işlem izin verilmiyor.");
      case "weak-password":
        // Zayıf şifre hatası
        return FirebaseFailure("Zayıf şifre.");
      case "provider-already-linked":
        // Sağlayıcı zaten bağlı hatası
        return FirebaseFailure("Sağlayıcı zaten bağlı.");
      case "requires-recent-login":
        // İşlem için yakın zamanda oturum açmanız gerekiyor hatası
        return FirebaseFailure("Bu işlem için yakın zamanda oturum açmanız gerekiyor.");
      case "credential-already-in-use":
        // Kimlik bilgisi zaten kullanılıyor hatası
        return FirebaseFailure("Kimlik bilgisi zaten kullanılıyor.");
      case "invalid-verification-code":
        // Geçersiz doğrulama kodu hatası
        return FirebaseFailure("Geçersiz doğrulama kodu.");
      case "invalid-verification-id":
        // Geçersiz doğrulama kimliği hatası
        return FirebaseFailure("Geçersiz doğrulama kimliği.");
      case "too-many-requests":
        // Çok fazla istek yapıldı hatası
        return FirebaseFailure("Çok fazla istek yapıldı. Lütfen daha sonra tekrar deneyin.");
      case "expired-action-code":
        // Süresi geçmiş işlem kodu hatası
        return FirebaseFailure("Süresi geçmiş işlem kodu.");
      case "invalid-action-code":
        // Geçersiz işlem kodu hatası
        return FirebaseFailure("Geçersiz işlem kodu.");
      default:
        // Diğer Firebase Authentication istisnalarını ele almak için genel hata mesajı
        return FirebaseFailure("Bir hata oluştu: ${e.code}");
    }
  }
}
