import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:online_mart_journey_app/presentation/auth/screens/forget_password_screen.dart';
import 'package:online_mart_journey_app/presentation/auth/screens/login_screen.dart';
import 'package:online_mart_journey_app/presentation/auth/screens/signup_screen.dart';
import 'package:online_mart_journey_app/presentation/auth/screens/splash_screen.dart';
import 'package:online_mart_journey_app/presentation/auth/screens/welcome_screen.dart';
import 'package:online_mart_journey_app/presentation/user_panel/screens/home_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Online Mart Journey',
      debugShowCheckedModeBanner: false,
      builder: EasyLoading.init(),
      initialRoute: "/",
      getPages: [
        GetPage(name: "/", page: () => SplashScreen()),
        GetPage(name: "/welcome", page: () => WelcomeScreen()),
        GetPage(name: "/login", page: () => LoginScreen()),
        GetPage(name: "/signUp", page: () => SignupScreen()),
        GetPage(name: "/home", page: ()=>HomeScreen()),
        GetPage(name: "/forget", page: ()=>ForgetPasswordScreen())
      ],
    );
  }
}
