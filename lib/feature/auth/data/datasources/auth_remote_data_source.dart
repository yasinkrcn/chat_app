import 'dart:io';

import 'package:chat_app/core/_core_exports.dart';
import 'package:uuid/uuid.dart';

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

  Future<String> getImageUrlFromFirebase({
    required File imageFile,
    String? imageLocation,
  }) async {
    String fileName = const Uuid().v1();

    var ref = FirebaseStorage.instance.ref().child(imageLocation ?? 'userImages').child("$fileName.jpg");

    TaskSnapshot uploadTask = await ref.putFile(imageFile);

    String imageUrl = await uploadTask.ref.getDownloadURL();

    return imageUrl;
  }
}
