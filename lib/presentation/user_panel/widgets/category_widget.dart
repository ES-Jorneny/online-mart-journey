import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_card/image_card.dart';
import 'package:online_mart_journey_app/models/category_model.dart';
import 'package:online_mart_journey_app/services/database/firestore_services.dart';

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirestoreServices().getCategories(),
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
          return Center(child: Text("No category found"));
        }
        if (snapshot.data != null) {
          return SizedBox(
            height: Get.height /6.5,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                CategoryModel categoryModel = CategoryModel(
                  categoryId: snapshot.data!.docs[index]["categoryId"],
                  categoryName: snapshot.data!.docs[index]["categoryName"],
                  categoryImg: snapshot.data!.docs[index]["categoryImg"],
                  createdAt: snapshot.data!.docs[index]["createdAt"],
                  updatedAt: snapshot.data!.docs[index]["updatedAt"],
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
                      width: Get.width/4,
                      heightImage: Get.height/12,
                      imageProvider: CachedNetworkImageProvider(
                        categoryModel.categoryImg,
                      ),
                      title: Center(
                        child: Text(categoryModel.categoryName,style: TextStyle(
                          fontSize: 12
                        ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
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
