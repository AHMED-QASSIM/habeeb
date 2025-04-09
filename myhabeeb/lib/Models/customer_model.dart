import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CustomerModel {
  String? id;
  String name;
  String address;
  String shopName;
  String username;
  String password;
  String phoneNumber;
  String imageUrl;
  bool isActive;
  Timestamp registerDate;

  CustomerModel({
    this.id,
    required this.name,
    required this.address,
    required this.shopName,
    required this.username,
    required this.password,
    required this.phoneNumber,
    required this.isActive,
    required this.registerDate,
    this.imageUrl = '',
  });

  // Convert CustomerModel to Map
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'address': address,
      'shopName': shopName,
      'username': username,
      'password': password,
      'phoneNumber': phoneNumber,
      'imageUrl': imageUrl,
      'isActive': isActive,
      'registerDate': registerDate,
    };
  }

  // Create CustomerModel from Firestore DocumentSnapshot
  factory CustomerModel.fromSnapshot(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return CustomerModel(
      id: doc.id,
      name: data['name'] ?? '',
      address: data['address'] ?? '',
      shopName: data['shopName'] ?? '',
      username: data['username'] ?? '',
      password: data['password'] ?? '',
      phoneNumber: data['phoneNumber'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
      isActive: data['isActive'] ?? false,
      registerDate: data['registerDate'] ?? Timestamp.now(),
    );
  }
}
