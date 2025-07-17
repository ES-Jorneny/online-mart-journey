import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../../utils/app_constants.dart';
import '../widgets/text_field_widget.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _usernameController=TextEditingController();
  final TextEditingController _phoneController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return KeyboardVisibilityBuilder(
      builder: (context, isKeyboardVisible) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text("Sign Up", style: TextStyle(color: appTextColor)),
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
                    controller: _usernameController,
                    hintText: "Username",
                    icon: Icons.person,
                    inputType: TextInputType.text,
                  ),
                  TextFieldWidget(
                    controller: _emailController,
                    hintText: "Email",
                    icon: Icons.email,
                    inputType: TextInputType.emailAddress,
                  ),
                  TextFieldWidget(
                    controller: _phoneController,
                    hintText: "Phone",
                    icon: Icons.phone,
                    inputType: TextInputType.phone,
                  ),
                  TextFieldWidget(
                    controller: _passwordController,
                    icon: Icons.password,
                    hintText: "Password",
                    inputType: TextInputType.visiblePassword,
                    isObscure: true,
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
                        "Sign Up ",
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
                            text: "Already have an account? ",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Get.offNamed("/login");
                              },
                            text: "Sign In",
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
