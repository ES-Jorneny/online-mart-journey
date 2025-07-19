import 'package:get/get.dart';

import '../../services/auth/auth_services.dart';

class EmailSignInController extends GetxController {
  final AuthServices _authServices = AuthServices();

  Future<void> signUp(
    String email,
    String password,
    String username,
    String phone,
  ) async {
    try {
      await _authServices.signUpWithEmail(email, password, username, phone);
      Get.snackbar("Verification email send", "Please Verify your email",snackPosition: SnackPosition.BOTTOM);
      _authServices.signOut();
      Get.offAllNamed("/login");

    } catch (e) {
      Get.snackbar("Fail", "Try again $e",snackPosition: SnackPosition.BOTTOM);
    }
  }

  Future<void> signIn(String email,String password) async{
    try{
      _authServices.signInWithEmail(email, password);
      Get.snackbar("Success", "Login Successfully",snackPosition: SnackPosition.BOTTOM);
    }catch(e){
      Get.snackbar("Error", e.toString(),snackPosition: SnackPosition.BOTTOM);
    }
  }

  Future<void> forgetPassword(String email)async{
    await _authServices.forgetPassword(email);
  }
}
