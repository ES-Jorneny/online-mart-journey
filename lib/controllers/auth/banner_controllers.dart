import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class BannerController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  RxList<String> bannerUrls=RxList([]);

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchBannerUrls();
  }

  /// fetch banners
  Future<void> fetchBannerUrls() async {
    try {
      QuerySnapshot bannerSnapshot = await _firestore
          .collection("banners")
          .get();
      if (bannerSnapshot.docs.isNotEmpty) {
        bannerUrls.value = bannerSnapshot.docs
            .map((doc) => doc["imageUrl"] as String)
            .toList();
      }
    } catch (e) {
      print(e);
    }
  }
}
