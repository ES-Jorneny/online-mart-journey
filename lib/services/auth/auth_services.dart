import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:online_mart_journey_app/controllers/auth/get_device_token_controller.dart';
import 'package:online_mart_journey_app/models/user_model.dart';
import 'package:online_mart_journey_app/services/database/firestore_services.dart';

class AuthServices {


  // ✅ Correct way to initialize in latest version
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final GetDeviceTokenController getDeviceTokenController=Get.put(GetDeviceTokenController());

  // Firebase Auth
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final getCurrentUser=FirebaseAuth.instance.currentUser?.uid;

  // Sign In with Google
  Future<void> signInWithGoogle() async {


    try {
      // Account signIn
      final GoogleSignInAccount? googleSignInAccount = await googleSignIn
          .signIn();
      if (googleSignInAccount != null) {
        // Loading start
        EasyLoading.show(status: "Please wait...");
        // get user
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );
        final UserCredential userCredential = await _auth.signInWithCredential(
          credential,
        );
        final User? user = userCredential.user;
        if (user != null) {
          UserModel userModel = UserModel(
            uid: user.uid,
            username: user.displayName.toString(),
            email: user.email.toString(),
            phone: user.phoneNumber.toString(),
            userImgUrl: user.photoURL.toString(),
            userDeviceToken: getDeviceTokenController.deviceToken.toString(),
            country: "",
            userAddress: "",
            street: "",
            isAdmin: false,
            isActive: true,
            createdOn: DateTime.now(),
          );
          // add user on firestore
          FirestoreServices().addUser(userModel);
          EasyLoading.dismiss();
        }
      }
    } catch (e) {
      EasyLoading.dismiss();
      print(e.toString());
    }
  }

  // Sign In with email
  Future<UserCredential?> signInWithEmail(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user != null && userCredential.user!.emailVerified) {
        return userCredential; // ✅ Don't navigate here
      } else {
        await _auth.signOut();
        Get.snackbar("Error", "Please verify your email before sign In");
        throw FirebaseAuthException(
          code: 'email-not-verified',
          message: 'Please verify your email before signing in.',
        );
      }
    } on FirebaseAuthException catch (e) {
      print("Signin error: ${e.message}");
      rethrow;
    } catch (e) {
      print("Unexpected error: $e");
      rethrow;
    }
  }



  // Sign Up with Email
  Future<void> signUpWithEmail(
      String email,
      String password,
      String username,
      String phone,
      ) async {
    try {
      // Loading start
      EasyLoading.show(status: "Please wait...");
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Send verification email
      await userCredential.user!.sendEmailVerification();
      // add user data on user model
      UserModel userModel = UserModel(
        uid: userCredential.user!.uid,
        username: username,
        email: email,
        phone: phone,
        userImgUrl: "",
        userDeviceToken: getDeviceTokenController.deviceToken.toString(),
        country: "",
        userAddress: "",
        street: "",
        isAdmin: false,
        isActive: true,
        createdOn: DateTime.now(),
      );

      await FirestoreServices().addUser(userModel);
      // Loading start
      EasyLoading.dismiss();
    } on FirebaseAuthException catch (e) {
      EasyLoading.dismiss();
      // Show error message
      print("Signup error: ${e.message}");
      rethrow; // ya handle with Get.snackbar
    } catch (e) {
      EasyLoading.dismiss();
      print("Unexpected error: $e");
      rethrow;
    }
  }

  // Forget Password
  Future<void> forgetPassword(String email)async{
    try{
      EasyLoading.show(status: "Please wait");
     await _auth.sendPasswordResetEmail(email: email);
      Get.snackbar("Request sent successfully", "password reset link sent to your email",snackPosition: SnackPosition.BOTTOM);
     EasyLoading.dismiss();
    }on FirebaseAuthException catch(e){
      EasyLoading.dismiss();
      print("Unexpected error: $e");
      Get.snackbar("Error", e.toString(),snackPosition: SnackPosition.BOTTOM);
    }
  }



  // SignOut
  Future<void> signOut() async {
    final user = _auth.currentUser;

    if (user != null) {
      for (final provider in user.providerData) {
        if (provider.providerId == 'google.com') {
          // Google Sign-out
          await googleSignIn.signOut();
          break;
        }
      }
    }

    // Firebase Sign-out (always do this)
    await _auth.signOut();
  }


  // checkUser
  Future<bool> isUserLoggedIn() async {
    final user = _auth.currentUser;
    return user != null;
  }
}
