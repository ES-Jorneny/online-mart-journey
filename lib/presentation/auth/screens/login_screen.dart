import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:online_mart_journey_app/controllers/auth/get_user_data_controller.dart';
import 'package:online_mart_journey_app/models/user_model.dart';
import 'package:online_mart_journey_app/presentation/auth/widgets/text_field_widget.dart';
import 'package:online_mart_journey_app/utils/app_constants.dart';

import '../../../controllers/auth/email_sign_in_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final EmailSignInController emailSignInController = Get.put(
    EmailSignInController(),
  );
  final GetUserDataController getUserDataController = Get.put(
    GetUserDataController(),
  );

  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return KeyboardVisibilityBuilder(
      builder: (context, isKeyboardVisible) {
        return Scaffold(
          backgroundColor: Colors.white,

          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                AppBar(
                  iconTheme: IconThemeData(color: Colors.white),
                  title: Text("Sign In", style: TextStyle(color: appTextColor)),
                  backgroundColor: appMainColor,
                  centerTitle: true,
                ),
                Container(
                  height: Get.height,
                  width: Get.width,
                  color: Colors.white,
                  child: Column(
                    children: [
                      isKeyboardVisible
                          ? SizedBox.shrink()
                          : Lottie.asset(
                              'assets/images/splash-icon.json',
                              delegates: LottieDelegates(
                                values: [
                                  ValueDelegate.color(
                                    const ['**'],
                                    // or ['Shape Layer 1', 'Fill 1'] – exact path of the layer
                                    value:
                                        appMainColor, // 👈 your desired color
                                  ),
                                ],
                              ),
                            ),
                      SizedBox(height: Get.height / 20),
                      TextFieldWidget(
                        controller: _emailController,
                        hintText: "Email",
                        icon: Icons.email,
                        inputType: TextInputType.emailAddress,
                      ),
                      TextFieldWidget(
                        controller: _passwordController,
                        icon: Icons.password,
                        onPressed: () {
                          if (_isObscure) {
                            setState(() {
                              _isObscure = false;
                            });
                          } else {
                            _isObscure = true;
                          }
                        },
                        hintText: "Password",
                        inputType: TextInputType.visiblePassword,
                        isObscure: _isObscure,
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.toNamed("/forget");
                        },
                        child: Container(
                          margin: EdgeInsets.only(right: Get.width * 0.06),
                          alignment: Alignment.topRight,
                          child: Text(
                            "Forget Password?",
                            style: TextStyle(
                              color: appMainColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: Get.height * 0.03),
                      Container(
                        width: Get.width * 0.9,
                        padding: EdgeInsets.symmetric(
                          vertical: Get.height * 0.005,
                        ),
                        decoration: BoxDecoration(
                          color: appMainColor,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: TextButton(
                          onPressed: () async {
                            if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
                              Get.snackbar("Message", "Please fill required fields");
                            } else {
                              try {
                                // ✅ 1. Sign in
                                UserCredential? userCredential = await emailSignInController.signIn(
                                  _emailController.text.trim(),
                                  _passwordController.text.trim(),
                                );

                                if (userCredential != null) {
                                  final uid = userCredential.user!.uid;

                                  // ✅ 2. Use controller to get user data (NOT direct firestore)
                                  final UserModel? userModel = await getUserDataController.getUser(uid);

                                  if (userModel != null) {
                                    // ✅ 3. Navigate according to isAdmin
                                    if (userModel.isAdmin) {
                                      Get.offAllNamed("/adminPanel");
                                    } else {
                                      Get.offAllNamed("/home");
                                    }
                                  } else {
                                    Get.snackbar("Error", "User data not found.");
                                  }
                                }
                              } catch (e) {
                                print("Login error: $e");
                                Get.snackbar("Error", e.toString());
                              }
                            }
                          },


                          child: Text(
                            "Sign In ",
                            style: TextStyle(
                              color: appTextColor,
                              fontSize: Get.width * 0.038,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: Get.height * 0.04),
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "Don't have an account? ",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              TextSpan(
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Get.toNamed("/signUp");
                                  },
                                text: "Sign Up",
                                style: TextStyle(
                                  color: appMainColor, // your app theme color
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
