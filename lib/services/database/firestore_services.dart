import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:online_mart_journey_app/models/user_model.dart';

class FirestoreServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addUser(UserModel userModel) async {
    _firestore.collection("users").doc(userModel.uid).set(userModel.toJson());
  }
}
