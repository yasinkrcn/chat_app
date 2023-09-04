// ignore_for_file: must_be_immutable

import 'package:chat_app/core/error/failures/failure.dart';

class NullPointerFailure extends Failure {
  NullPointerFailure() : super("NullPointerFailure");
}

class ListEmptyFailure extends Failure {
  ListEmptyFailure() : super("ListEmptyFailure");
}

class ThisClassDoesNotImplemented extends Failure {
  ThisClassDoesNotImplemented() : super("ThisClassDoesNotImplemented");
}

class VerificationCodeNotMatchedFailure extends Failure {
  VerificationCodeNotMatchedFailure() : super("VerificationCodeNotMatchedFailure");
}

class NotificationNotSetFailure extends Failure {
  NotificationNotSetFailure() : super("NotificationNotSetFailure");
}

class NoteNotSaveLocalFailure extends Failure {
  NoteNotSaveLocalFailure() : super("NotificationNotSetFailure");
}

class NoteNotSaveRemoteFailure extends Failure {
  NoteNotSaveRemoteFailure() : super("NoteNotSaveRemoteFailure");
}
