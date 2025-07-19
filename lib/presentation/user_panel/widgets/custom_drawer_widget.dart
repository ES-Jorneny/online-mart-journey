import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_mart_journey_app/utils/app_constants.dart';

import '../../../controllers/auth/google_sign_in_controller.dart';

class CustomDrawerWidget extends StatefulWidget {
  const CustomDrawerWidget({super.key});

  @override
  State<CustomDrawerWidget> createState() => _CustomDrawerWidgetState();
}

class _CustomDrawerWidgetState extends State<CustomDrawerWidget> {
  final GoogleSignInController _googleSignInController = Get.put(
    GoogleSignInController(),
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: Get.height / 25),
      child: Drawer(

        backgroundColor: appMainColor,
        child: Wrap(
          runSpacing: 10,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: ListTile(
                titleAlignment: ListTileTitleAlignment.center,
                title: Text(
                  "Esha",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                subtitle: Text(
                  "Version 1.0.1",
                  style: TextStyle(color: Colors.white),
                ),
                leading: CircleAvatar(
                  radius: 22,
                  backgroundColor: Colors.white,
                  child: Text("ES", style: TextStyle(color: appMainColor)),
                ),
              ),
            ),
            Divider(
              indent: 10,
              endIndent: 10,
              thickness: 1.5,
              color: Colors.grey.shade400,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ListTile(
                titleAlignment: ListTileTitleAlignment.center,
                title: Text("Home", style: TextStyle(color: Colors.white)),

                leading: Icon(Icons.home, color: Colors.white),
                trailing: Icon(Icons.arrow_forward, color: Colors.white),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ListTile(
                titleAlignment: ListTileTitleAlignment.center,
                title: Text("Products", style: TextStyle(color: Colors.white)),

                leading: Icon(
                  Icons.production_quantity_limits,
                  color: Colors.white,
                ),
                trailing: Icon(Icons.arrow_forward, color: Colors.white),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ListTile(
                titleAlignment: ListTileTitleAlignment.center,
                title: Text("Orders", style: TextStyle(color: Colors.white)),

                leading: Icon(Icons.shopping_bag, color: Colors.white),
                trailing: Icon(Icons.arrow_forward, color: Colors.white),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ListTile(
                titleAlignment: ListTileTitleAlignment.center,
                title: Text("Contact", style: TextStyle(color: Colors.white)),

                leading: Icon(Icons.help, color: Colors.white),
                trailing: Icon(Icons.arrow_forward, color: Colors.white),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ListTile(
                titleAlignment: ListTileTitleAlignment.center,
                title: Text("Logout", style: TextStyle(color: Colors.white)),
                onTap: (){
                  _googleSignInController.signOut();
                },
                leading: Icon(Icons.logout, color: Colors.white),
                trailing: Icon(Icons.arrow_forward, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
