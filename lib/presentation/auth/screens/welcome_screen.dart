import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:lottie/lottie.dart';
import 'package:online_mart_journey_app/controllers/google_sign_in_controller.dart';
import '../../../utils/app_constants.dart';

class WelcomeScreen extends StatelessWidget {
  WelcomeScreen({super.key});

  final GoogleSignInController _googleSignInController = Get.put(
    GoogleSignInController(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: Get.height,
        color: Colors.white,
        child: Column(
          children: [
            /// 50 percent height of screen
            Container(
              color: appMainColor,
              height: Get.height * 0.5,
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: Get.height * 0.05),
                  // Text
                  Text(
                    "Welcome to my app",
                    style: TextStyle(
                      color: appTextColor,
                      fontSize: Get.width * 0.07,
                    ),
                  ),
                  SizedBox(height: Get.height * 0.05),
                  // Icon
                  Container(
                    alignment: Alignment.center,
                    width: Get.width,
                    // use for .json icons etc
                    child: Lottie.asset(
                      'assets/images/splash-icon.json',
                      delegates: LottieDelegates(
                        values: [
                          ValueDelegate.color(
                            const ['**'],
                            // or ['Shape Layer 1', 'Fill 1'] – exact path of the layer
                            value: appMainColor, // 👈 your desired color
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            /// 50 percent height of screen
            Container(
              color: Colors.white,
              height: Get.height * 0.5,
              width: double.infinity,
              child: Column(
                children: [
                  SizedBox(height: Get.height * 0.03),
                  Text(
                    "Happy Shopping",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: Get.width * 0.04,
                    ),
                  ),
                  SizedBox(height: Get.height * 0.09),
                  Container(
                    width: Get.width * 0.82,
                    padding: EdgeInsets.symmetric(vertical: Get.height * 0.005),
                    decoration: BoxDecoration(
                      color: appMainColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Brand(Brands.google),
                        TextButton(
                          onPressed: () {
                            _googleSignInController.signIn();

                          },
                          child: Text(
                            "Sign in with google",
                            style: TextStyle(
                              color: appTextColor,
                              fontSize: Get.width * 0.038,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: Get.height * 0.02),
                  Container(
                    width: Get.width * 0.82,
                    padding: EdgeInsets.symmetric(vertical: Get.height * 0.005),
                    decoration: BoxDecoration(
                      color: appMainColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.email, color: Colors.white),
                        TextButton(
                          onPressed: () {
                            Get.offNamed("/login");
                          },
                          child: Text(
                            "Sign in with email",
                            style: TextStyle(
                              color: appTextColor,
                              fontSize: Get.width * 0.038,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
