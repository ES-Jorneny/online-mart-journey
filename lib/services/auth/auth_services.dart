import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:online_mart_journey_app/models/user_model.dart';
import 'package:online_mart_journey_app/services/database/firestore_services.dart';

class AuthServices {

  // ✅ Correct way to initialize in latest version
  final GoogleSignIn googleSignIn = GoogleSignIn();
  // Firebase Auth
  final FirebaseAuth _auth = FirebaseAuth.instance;
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
            userDeviceToken: "",
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
