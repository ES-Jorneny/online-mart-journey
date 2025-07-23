import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  final String productId;
  final String productName;
  final String productDescription;
  final String categoryId;
  final String categoryName;
  final String deliveryTime;
  final bool isSale;
  final String fullPrice; // Keep as String if you want, else use double
  final String salePrice;
  final List productImages;
  final Timestamp createdAt;
  final Timestamp updatedAt;

  ProductModel({
    required this.productId,
    required this.productName,
    required this.productDescription,
    required this.categoryId,
    required this.categoryName,
    required this.deliveryTime,
    required this.isSale,
    required this.fullPrice,
    required this.salePrice,
    required this.productImages,
    required this.createdAt,
    required this.updatedAt,
  });

  // FROM JSON (Firestore or REST API)
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      productId: json['productId'] ?? '',
      productName: json['productName'] ?? '',
      productDescription: json['productDescription'] ?? '',
      categoryId: json['categoryId'] ?? '',
      categoryName: json['categoryName'] ?? '',
      deliveryTime: json['deliveryTime'] ?? '',
      isSale: json['isSale'] ?? false,
      fullPrice: json['fullPrice']?.toString() ?? '',
      salePrice: json['salePrice']?.toString() ?? '',
      productImages: List<String>.from(json['productImages'] ?? []),
      createdAt: json['createdAt'] ?? Timestamp.now(),
      updatedAt: json['updatedAt'] ?? Timestamp.now(),
    );
  }

  // TO JSON (For Firestore)
  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'productName': productName,
      'productDescription': productDescription,
      'categoryId': categoryId,
      'categoryName': categoryName,
      'deliveryTime': deliveryTime,
      'isSale': isSale,
      'fullPrice': fullPrice,
      'salePrice': salePrice,
      'productImages': productImages,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}
