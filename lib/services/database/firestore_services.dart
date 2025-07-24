import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:online_mart_journey_app/models/user_model.dart';

class FirestoreServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  /// Add User
  Future<void> addUser(UserModel userModel) async {
   await _firestore.collection("users").doc(userModel.uid).set(userModel.toJson());
  }
  /// Fetch User based on Id
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

  /// Fetch category
Future<QuerySnapshot> getCategories() async{
    return await _firestore.collection("categories").get();
}
/// Fetch  Sale Product
Future<QuerySnapshot> getSaleProducts()async{
    return await _firestore.collection("products").where("isSale",isEqualTo: true).get();
}
/// Fetch product based on category
  Future<QuerySnapshot> getSaleProductsBasedOnCategory(String categoryId)async{
    return await _firestore.collection("products").where("categoryId",isEqualTo: categoryId).get();
  }

  /// Fetch  All Product
  Future<QuerySnapshot> getAllProducts()async{
    return await _firestore.collection("products").get();
  }


}
