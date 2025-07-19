import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:online_mart_journey_app/presentation/user_panel/widgets/custom_drawer_widget.dart';


import '../../../controllers/auth/google_sign_in_controller.dart';
import '../../../utils/app_constants.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawerWidget(),
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white
        ),
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: appMainColor,
            statusBarBrightness: Brightness.light
        ),
        backgroundColor: appMainColor,
        title: Text(appMainName,style: TextStyle(
            color: appTextColor
        ),),
        centerTitle: true,

      ),
      body: Center(child: GestureDetector(
        onTap: (){

        },
          child: Text("logout"))),
    );
  }
}
