import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';


import '../../../controllers/auth/email_sign_in_controller.dart';
import '../../../utils/app_constants.dart';
import '../widgets/text_field_widget.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();
  final EmailSignInController emailSignInController = Get.put(
    EmailSignInController(),
  );
  @override
  Widget build(BuildContext context) {
    return  KeyboardVisibilityBuilder(
      builder: (context, isKeyboardVisible) {
        return Scaffold(
          backgroundColor: Colors.white,

          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                AppBar(
                  iconTheme: IconThemeData(
                      color: Colors.white
                  ),
                  title: Text("Forget Password", style: TextStyle(color: appTextColor)),
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
                              value: appMainColor, // 👈 your desired color
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

                      SizedBox(height: Get.height *0.03),
                      Container(
                        width: Get.width * 0.9,
                        padding: EdgeInsets.symmetric(vertical: Get.height * 0.005),
                        decoration: BoxDecoration(
                          color: appMainColor,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: TextButton(
                          onPressed: () {
                            if(_emailController.text.isEmpty){
                              Get.snackbar("Error", "please fill required field",snackPosition: SnackPosition.BOTTOM);
                            }else{
                              emailSignInController.forgetPassword(_emailController.text);
                              Get.offAllNamed("/login");
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
