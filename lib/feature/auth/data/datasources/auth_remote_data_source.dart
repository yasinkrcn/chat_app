import 'package:chat_app/core/_core_exports.dart';

class AuthRemoteDataSource {
  Future<UserCredential> createUserWithEmailAndPassword({required String email, required String password}) async {
    final user = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    return user;
  }

  Future<void> saveUserInfo({required UserModel userModel}) async {
    final tempUserCollection = FirebaseFirestore.instance.collection('users');
    tempUserCollection.doc(userModel.id).set(userModel.toMap());
  }

  Future<UserCredential> loginWithEmailAndPassword({required String email, required String password}) async {
    final user = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    return user;
  }

  Future<void> logOut() async {
    await FirebaseAuth.instance.signOut();
  }

  Future<UserModel> getUserInfo({required String userId}) async {
    final getData = await FirebaseFirestore.instance.collection("users").doc(userId).get();

    final userInfo = UserModel.fromMap(getData.data()!);

    return userInfo;
  }

  Future<void> deleteUser({
    required String userId,
  }) async {
    await FirebaseAuth.instance.currentUser?.delete();

    await FirebaseFirestore.instance.collection("users").doc(userId).delete();
  }

  Future<void> sendEmailVerificationCode() async {
    await FirebaseAuth.instance.currentUser?.sendEmailVerification();
  }
}
