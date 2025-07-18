import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:online_mart_journey_app/models/user_model.dart';

class FirestoreServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addUser(UserModel userModel) async {
   await _firestore.collection("users").doc(userModel.uid).set(userModel.toJson());
  }
  Future<UserModel?> getUser(String uId) async {
    final snapshot = await _firestore
        .collection("users")
        .where("uid", isEqualTo: uId)
        .get();

    if (snapshot.docs.isNotEmpty) {
      final data = snapshot.docs.first.data();
      return UserModel.fromJson(data);
    } else {
      return null;
    }
  }

}
