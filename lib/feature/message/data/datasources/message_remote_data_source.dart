import 'package:chat_app/core/_core_exports.dart';

class MessageRemoteDataSource {
  Future<List<UserModel>> fetchMessageUsers() async {
    Query query = FirebaseFirestore.instance.collection('users');

    List<UserModel> chatUserList = [];

    QuerySnapshot querySnapshot = await query.get();

    chatUserList = querySnapshot.docs.map((doc) => UserModel.fromFirestore(doc)).toList();

    chatUserList.removeWhere((index) =>
        index.id == FirebaseAuth.instance.currentUser!.uid); // id si bize eşit olan kullanıcıyı listeden çıkardık

    return chatUserList;
  }
}
