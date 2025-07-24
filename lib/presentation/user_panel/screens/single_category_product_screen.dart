import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_card/image_card.dart';

import '../../../models/category_model.dart';
import '../../../models/product_model.dart';
import '../../../services/database/firestore_services.dart';
import '../../../utils/app_constants.dart';

class SingleCategoryProductScreen extends StatefulWidget {
  const SingleCategoryProductScreen({super.key});

  @override
  State<SingleCategoryProductScreen> createState() => _SingleCategoryProductScreenState();
}

class _SingleCategoryProductScreenState extends State<SingleCategoryProductScreen> {
  late String categoryId;

  @override
  void initState() {
    super.initState();
    categoryId = Get.arguments['categoryId'];
    print("Selected category ID: $categoryId");
  }
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
        title: const Text("Products", style: TextStyle(color: appTextColor)),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: FirestoreServices().getSaleProductsBasedOnCategory(categoryId),
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
            return const Center(child: Text("No product found"));
          }
          if (snapshot.data != null) {
            final productData = snapshot.data!.docs[0]; // Single product
            final List<dynamic> images = productData["productImages"]; // List of images
            return GridView.builder(
              itemCount: images.length,
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(8),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                childAspectRatio: 0.85, // Adjusted for better fit
              ),
              itemBuilder: (context, index) {
                ProductModel productModel = ProductModel(
                  productId: productData["productId"],
                  productName: productData["productName"],
                  productDescription: productData["productDescription"],
                  categoryId: productData["categoryId"],
                  categoryName: productData["categoryName"],
                  deliveryTime: productData["deliveryTime"],
                  isSale: productData["isSale"],
                  fullPrice: productData["fullPrice"],
                  salePrice: productData["salePrice"],
                  productImages: productData["productImages"],
                  createdAt: productData["createdAt"],
                  updatedAt: productData["updatedAt"],
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
                            imageUrl: productModel.productImages[index],
                            height: Get.height / 9,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Center(
                          child: Text(
                          productModel.productName,
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
