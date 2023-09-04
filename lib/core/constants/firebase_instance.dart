import 'package:chat_app/core/_core_exports.dart';

class Fb {
  static final Fb _instance = Fb._init();
  Fb._init();

  factory Fb() {
    return _instance;
  }

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseStorage storage = FirebaseStorage.instance;
}
