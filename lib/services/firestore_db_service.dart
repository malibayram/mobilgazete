import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobilturkiyem/model/user_model.dart';
import 'package:mobilturkiyem/services/database_service.dart';

class FirestoreDbService implements DatabaseService {
  final Firestore _firebaseAuth = Firestore.instance;

  @override
  Future<bool> saveUser(User user) async {

    Map _eklenecekUserMap = user.toMap();
    _eklenecekUserMap['createdAt'] = FieldValue.serverTimestamp();

    await _firebaseAuth
        .collection("users")
        .document(user.userID)
        .setData(_eklenecekUserMap);
    return true;
  }
}
