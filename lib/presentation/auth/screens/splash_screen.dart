
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../../utils/app_constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

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

  void navigateToNextScreen()async{
    await Future.delayed(Duration(seconds: 3));
    Get.offNamed("/welcome");
  }
}
