import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../../../controllers/google_sign_in_controller.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final GoogleSignInController _googleSignInController = Get.put(
    GoogleSignInController(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: GestureDetector(
        onTap: (){
          _googleSignInController.signOut();
        },
          child: Text("logout"))),
    );
  }
}
