import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:online_mart_journey_app/presentation/auth/widgets/text_field_widget.dart';
import 'package:online_mart_journey_app/utils/app_constants.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return KeyboardVisibilityBuilder(
      builder: (context, isKeyboardVisible) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text("Sign In", style: TextStyle(color: appTextColor)),
            backgroundColor: appMainColor,
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Container(
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
                  TextFieldWidget(
                    controller: _passwordController,
                    icon: Icons.password,
                    hintText: "Password",
                    inputType: TextInputType.visiblePassword,
                    isObscure: true,
                  ),
                  Container(
                    margin: EdgeInsets.only(right: Get.width*0.06),
                    alignment: Alignment.topRight,
                    child: Text("Forget Password?",style: TextStyle(
                      color: appMainColor,
                      fontWeight: FontWeight.w500
                    ),),
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
                       margin: EdgeInsets.only(top: Get.height *0.04),
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
                              Get.offNamed("/signUp");
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
          ),
        );
      },
    );
  }
}
