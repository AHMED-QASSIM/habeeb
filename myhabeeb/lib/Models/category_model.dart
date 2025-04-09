
import 'package:cloud_firestore/cloud_firestore.dart';

class Category {
  final String? id;
  final String name;
  final String image;
  final int itemCount;

  Category({
     this.id,
    required this.name,
    required this.image,
    required this.itemCount,
  });

  // Convert a Firestore document to Category
  factory Category.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Category(
      id: doc.id,
      name: data['name'] ?? '',
      image: data['image'] ?? '',
      itemCount: data['itemCount'] ?? 0,
    );
  }

  // Convert a Map to Category
  factory Category.fromMap(Map<String, dynamic> data, String documentId) {
    return Category(
      id: documentId,
      name: data['name'] ?? '',
      image: data['image'] ?? '',
      itemCount: data['itemCount'] ?? 0,
    );
  }

  // Convert a Category object to a Map for Firestore
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'image': image,
      'itemCount': itemCount,
    };
  }
}
class MainCategoryModel {
  final String id;
  final String name;

  MainCategoryModel({required this.id, required this.name});

  // Convert to map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }

  // Create from map
  factory MainCategoryModel.fromMap(Map<String, dynamic> map) {
    return MainCategoryModel(
      id: map['id'],
      name: map['name'],
    );
  }
}