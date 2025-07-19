import 'package:get/get.dart';
import 'package:online_mart_journey_app/services/auth/auth_services.dart';

class GoogleSignInController extends GetxController {

  // Use for get signIn and signOut methods
  final AuthServices _authServices = AuthServices();


  // signIn Function
  Future<void> signIn() async {
    try {
      await _authServices.signInWithGoogle();

        Get.snackbar("Success", "Signed in  successfully",snackPosition: SnackPosition.BOTTOM);
        Get.offAllNamed("/home");

    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }
  // signOut Function
  Future<void> signOut()async{
   await _authServices.signOut();
    Get.offAllNamed("/welcome");
  }

}
