import 'package:get/get.dart';
import 'package:online_mart_journey_app/models/user_model.dart';
import 'package:online_mart_journey_app/services/database/firestore_services.dart';

class GetUserDataController extends GetxController{
final FirestoreServices _firestoreServices=FirestoreServices();
Future<UserModel?> getUser(String uId)async{
  return await _firestoreServices.getUser(uId);
}

}