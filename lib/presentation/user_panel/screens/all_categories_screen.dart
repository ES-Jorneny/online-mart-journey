import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_card/image_card.dart';

import '../../../models/category_model.dart';
import '../../../services/database/firestore_services.dart';
import '../../../utils/app_constants.dart';

class AllCategoriesScreen extends StatefulWidget {
  const AllCategoriesScreen({super.key});

  @override
  State<AllCategoriesScreen> createState() => _AllCategoriesScreenState();
}

class _AllCategoriesScreenState extends State<AllCategoriesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: appMainColor,
          statusBarBrightness: Brightness.light,
        ),
        backgroundColor: appMainColor,
        title: const Text("All Categories", style: TextStyle(color: appTextColor)),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: FirestoreServices().getCategories(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text("Error"));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return SizedBox(
              height: Get.height / 5,
              child: const Center(child: CupertinoActivityIndicator()),
            );
          }
          if (snapshot.data!.docs.isEmpty) {
            return const Center(child: Text("No category found"));
          }
          if (snapshot.data != null) {
            return GridView.builder(
              itemCount: snapshot.data!.docs.length,
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(8),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                childAspectRatio: 0.87, // Adjusted for better fit
              ),
              itemBuilder: (context, index) {
                var doc = snapshot.data!.docs[index];
                CategoryModel categoryModel = CategoryModel(
                  categoryId: doc["categoryId"],
                  categoryName: doc["categoryName"],
                  categoryImg: doc["categoryImg"],
                  createdAt: doc["createdAt"],
                  updatedAt: doc["updatedAt"],
                );

                return Container(

                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),

                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1), // adjust opacity
                        blurRadius: 6,
                        offset: Offset(2, 4), // X, Y shadow offset
                      ),
                    ],
                  ),
                  child: GestureDetector(
                    onTap: () {
                      // TODO: Handle tap
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.only(topRight:Radius.circular(15),topLeft:Radius.circular(15)  ),
                          child: CachedNetworkImage(
                            imageUrl: categoryModel.categoryImg,
                            height: Get.height / 9,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Center(
                          child: Text(
                            categoryModel.categoryName,
                            style: const TextStyle(fontSize: 12),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                        ),
                      ],
                    ),
                  ),
                );

              },
            );
          }
          return Container();
        },
      ),
    );
  }
}
