import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:online_mart_journey_app/services/auth/auth_services.dart';

class GoogleSignInController extends GetxController {

  // Use for get signIn and signOut methods
  final AuthServices _authServices = AuthServices();
  // Track current firebase user
  Rxn<User> currentUser = Rxn<User>();

  @override
  void onInit() {
    // show login current user
    currentUser.value = FirebaseAuth.instance.currentUser;
    super.onInit();
  }

  // signIn Function
  Future<void> signIn() async {
    try {
      await _authServices.signInWithGoogle();
      // current user
      currentUser.value = FirebaseAuth.instance.currentUser;
      if (currentUser.value != null) {
        Get.snackbar("Success", "Signed in as ${currentUser.value?.displayName}");
        Get.offAllNamed("/home");
      }
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
