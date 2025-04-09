import 'package:cloud_firestore/cloud_firestore.dart';

class ItemModel {
  String? id;
  String name;
  String imageUrl;
  String category;
  String subcategory;
  double price;
  String priceType;
  //String itemcode;
  String description;
  DateTime date; // New field for the date
  bool isStock; // New field for in-stock status

  ItemModel({
    this.id,
    required this.name,
    required this.imageUrl,
    required this.category,
    required this.subcategory,
    required this.price,
    required this.priceType,
    required this.description,
    required this.date,
    required this.isStock,
  });

  // Convert ItemModel to a Map (for Firestore or JSON)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'imageUrl': imageUrl,
      'category': category,
      'subcategory': subcategory,
      'price': price,
      'priceType': priceType,
      'description': description,
       'date': Timestamp.fromDate(date), // Store the date in ISO 8601 format
      'isStock': isStock,
    };
  }

  // Create ItemModel from a Map (for Firestore or JSON)
  factory ItemModel.fromJson(Map<String, dynamic> json) {
    return ItemModel(
      id: json['id'] as String?,
      name: json['name'] as String,
      imageUrl: json['imageUrl'] as String,
      category: json['category'] as String,
      subcategory: json['subcategory'] as String,
      price: (json['price'] as num).toDouble(), // Ensure price is a double
      priceType: json['priceType'] as String,
      description: json['description'] as String,
       date: (json['date'] as Timestamp).toDate(),// Parse the date from ISO 8601
      isStock: json['isStock'] as bool,
    );
  }

  // Create ItemModel from Firestore DocumentSnapshot
  factory ItemModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return ItemModel(
      id: doc.id,
      name: data['name'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
      category: data['category'] ?? '',
      subcategory: data['subcategory'] ?? '',
      price: (data['price'] as num).toDouble(), // Ensure price is a double
      priceType: data['priceType'] ?? '',
      description: data['description'] ?? '',
      date: (data['date'] as Timestamp).toDate(), // ✅ Convert Timestamp to DateTime
      isStock: data['isStock'] ?? false, // Default to false if not present
    );
  }
}
