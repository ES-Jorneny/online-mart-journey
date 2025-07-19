import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_mart_journey_app/services/auth/auth_services.dart';


import '../../../controllers/auth/google_sign_in_controller.dart';

class AdminPanel extends StatefulWidget {
  const AdminPanel({super.key});

  @override
  State<AdminPanel> createState() => _AdminPanelState();
}

class _AdminPanelState extends State<AdminPanel> {
 final  GoogleSignInController _googleSignInController = Get.put(
    GoogleSignInController(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Center(child: GestureDetector(
          onTap: (){
            _googleSignInController.signOut();

          },
          child: Text("Admin panel"))),
    );
  }
}
