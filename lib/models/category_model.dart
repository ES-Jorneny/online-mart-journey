import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryModel {
  final String categoryId;
  final String categoryName;
  final String categoryImg;
  final Timestamp createdAt;
  final Timestamp updatedAt;

  CategoryModel({
    required this.categoryId,
    required this.categoryName,
    required this.categoryImg,
    required this.createdAt,
    required this.updatedAt,
  });

  // From JSON
  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      categoryId: json['categoryId'] ?? '',
      categoryName: json['categoryName'] ?? '',
      categoryImg: json['categoryImg'] ?? '',
      createdAt: json['createdAt'] ,  // if coming from Firestore
      updatedAt: json['updatedAt'] ,
    );
  }

  // To JSON
  Map<String, dynamic> toJson() {
    return {
      'categoryId': categoryId,
      'categoryName': categoryName,
      'categoryImg': categoryImg,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}
