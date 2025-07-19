
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:online_mart_journey_app/services/auth/auth_services.dart';

import '../../../controllers/auth/get_user_data_controller.dart';
import '../../../utils/app_constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final GetUserDataController getUserDataController = Get.put(
    GetUserDataController(),
  );

  @override
  void initState() {
    super.initState();
    navigateToNextScreen();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appMainColor,
      body: Column(
        children: [
          Expanded(
            child: Container(
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
          ),
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(bottom: 20),
            width: Get.width,
            child: Text(
              appCreatedBy,
              style: TextStyle(
                color: appTextColor,
                fontSize: Get.width *0.035,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void navigateToNextScreen() async {
    await Future.delayed(Duration(seconds: 3));

    final isLoggedIn = await AuthServices().isUserLoggedIn();

    if (!isLoggedIn) {
      Get.offAllNamed("/welcome");
    } else {
      // ✅ User is logged in, get UID
      final uid = AuthServices().getCurrentUser;

      // ✅ Get user data from controller
      final userModel = await getUserDataController.getUser(uid);

      if (userModel != null) {
        if (userModel.isAdmin) {
          Get.offAllNamed("/adminPanel");
        } else {
          Get.offAllNamed("/home");
        }
      } else {
        // User document not found
        Get.snackbar("Error", "User data not found!");
        Get.offAllNamed("/welcome");
      }
    }
  }

}
