abstract class Failure {
  final String message;

  Failure(this.message);
}

class ConnectionErrorFailure extends Failure {
  ConnectionErrorFailure() : super("Bağlantı hatası oluştu.");
}

class DataLoadFailure extends Failure {
  DataLoadFailure() : super("Veri yüklenemedi.");
}

class UserRegistrationFailure extends Failure {
  UserRegistrationFailure() : super("Kullanıcı kayıt olurken sorun oluştu.");
}

class UserLoginFailure extends Failure {
  UserLoginFailure() : super("Kullanıcı giriş yaparken sorun oluştu.");
}

class UserDataFetchFailure extends Failure {
  UserDataFetchFailure() : super("Kullanıcı verileri çekilirken sorun oluştu.");
}

class UserDeleteFailure extends Failure {
  UserDeleteFailure() : super("Kullanıcı silinirken sorun oluştu.");
}

class UserLogOutFailure extends Failure {
  UserLogOutFailure() : super("Kullanıcı Çıkış yaparken sorun oluştu.");
}

class PushNotificationError extends Failure {
  PushNotificationError() : super("Bildirim gönderilirken bir sorun oluştu.");
}
