import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_card/image_card.dart';
import 'package:online_mart_journey_app/models/product_model.dart';
import 'package:online_mart_journey_app/utils/app_constants.dart';
import '../../../services/database/firestore_services.dart';

class FlashSaleWidget extends StatelessWidget {
  const FlashSaleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirestoreServices().getSaleProducts(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text("Error"));
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SizedBox(
            height: Get.height / 5,
            child: Center(child: CupertinoActivityIndicator()),
          );
        }
        if (snapshot.data!.docs.isEmpty) {
          return Center(child: Text("No products found!"));
        }
        if (snapshot.data != null) {
          return SizedBox(
            height: Get.height / 6,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final productData = snapshot.data!.docs[index];
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
                return Padding(
                  padding: EdgeInsets.all(5),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1), // adjust opacity
                          blurRadius: 6,
                          offset: Offset(2, 4), // X, Y shadow offset
                        ),
                      ],
                    ),
                    child: FillImageCard(
                      width: Get.width / 4,
                      heightImage: Get.height / 12,
                      imageProvider: CachedNetworkImageProvider(
                        productModel.productImages[0],
                      ),
                      title: Text(
                        productModel.productName,
                        style: TextStyle(fontSize: 10),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                      footer: Row(
                        children: [
                          Text(
                            "Rs ${productModel.salePrice}",
                            style: TextStyle(fontSize: 10),
                          ),
                          SizedBox(
                            width: 2,
                          ),
                          Text(
                            " ${productModel.fullPrice}",
                            style: TextStyle(
                              fontSize: 10,
                              decoration: TextDecoration.lineThrough,
                              color: appMainColor
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        }
        return Container();
      },
    );
  }
}
