
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:myhabeeb/Models/customer_model.dart';
import 'package:path/path.dart';

import 'dart:io';

class customersService {
  final ImagePicker _picker = ImagePicker();
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;








 Future<List<CustomerModel>> getCustomersByStatus(bool isActive) async {
  try {
    final query = await _firestore
        .collection('Customers')
        .where('isActive', isEqualTo: isActive)
        .get();

    return query.docs
        .map((doc) => CustomerModel.fromSnapshot(doc)).toList();


  } catch (e) {
    print('Error fetching customers: $e');
    return [];
  }
}




  Future<File?> pickImageFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      return File(pickedFile.path);
    }
    return null;
  }

  // Upload image to Firebase Storage and get the download URL
  Future<String?> uploadImage(File imageFile, String? customerid) async {
    try {
      String fileName = basename(imageFile.path);
      Reference storageRef =
          _storage.ref().child('customers_images/$customerid/$fileName');
      UploadTask uploadTask = storageRef.putFile(imageFile);
      TaskSnapshot snapshot = await uploadTask;
      String downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print("Failed to upload image: $e");
      return null;
    }
  }

  Future<void> addcustomer(CustomerModel customer) async {
    try {
      final docId = _firestore.collection('Customers').doc().id;

      await _firestore.collection('Customers').doc(docId).set(customer.toMap());

  
    } catch (e) {
      throw e;
    }
  }
}
