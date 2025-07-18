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

  // Sign In with email
  Future<void> signInWithEmail(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // ✅ Check if email is verified
      if (userCredential.user != null && userCredential.user!.emailVerified) {
        // Proceed to home screen
      } else {
        // Sign out and warn
        await _auth.signOut();
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
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Send verification email
      await userCredential.user!.sendEmailVerification();

      UserModel userModel = UserModel(
        uid: userCredential.user!.uid,
        username: username,
        email: email,
        phone: phone,
        userImgUrl: "",
        userDeviceToken: "",
        country: "",
        userAddress: "",
        street: "",
        isAdmin: false,
        isActive: true,
        createdOn: DateTime.now(),
      );

      await FirestoreServices().addUser(userModel);
    } on FirebaseAuthException catch (e) {
      // Show error message
      print("Signup error: ${e.message}");
      rethrow; // ya handle with Get.snackbar
    } catch (e) {
      print("Unexpected error: $e");
      rethrow;
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
