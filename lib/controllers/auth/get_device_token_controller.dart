import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';

class GetDeviceTokenController extends GetxController{
  String? deviceToken;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getDeviceToken();
  }

  Future<void> getDeviceToken()async{
    try{
          String? token=await FirebaseMessaging.instance.getToken();
          if(token!=null){
            deviceToken=token;
            print("Token:$deviceToken");
            update();
          }
    }catch(e){
      Get.snackbar("Error", e.toString(),snackPosition: SnackPosition.BOTTOM);
    }
  }
}