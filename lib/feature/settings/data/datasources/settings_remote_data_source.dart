import 'package:chat_app/core/_core_exports.dart';

class SettingsRemoteDataSource {
  Future<void> updateUserInformations({required UserModel user}) async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(
          FirebaseAuth.instance.currentUser?.uid,
        )
        .set(
          user.toMap(),
        );
  }
}
