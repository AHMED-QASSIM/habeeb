import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:myhabeeb/Models/category_model.dart';
import 'package:myhabeeb/helpers/snackbar.dart';
import 'package:uuid/uuid.dart';
import '../services/category_service.dart';

class CategoryController extends GetxController {
  final CategoryService _categoryService = CategoryService();
  RxString imagePath = ''.obs;
  TextEditingController nameController = TextEditingController();
  var CARScategories = <Category>[].obs;
  var TOYScategories = <Category>[].obs;
  var isAddingCategory = false.obs; // Observable for loading state

  var isLoading = false.obs; // Observable for loading state
  // Fetch categories from Firebase
  void fetchCarCategories(String collection) async {
    try {
      isLoading(true);
      final snapshot =
          await FirebaseFirestore.instance.collection('Categories').doc('U6VWQKmnDWPF2NnH3fiQ').collection(collection).get();
      CARScategories.value =
          snapshot.docs.map((doc) {
            print(doc.data());

            return Category.fromFirestore(doc);
          }).toList();
    } catch (e) {
      Get.snackbar("Error", "Failed to fetch categories: $e");
    } finally {
      isLoading(false);
    }
  }

  void fetchToysCategories(String collection) async {
    try {
      isLoading(true);
      final snapshot =
          await FirebaseFirestore.instance.collection('Categories').doc('U6VWQKmnDWPF2NnH3fiQ').collection(collection).get();

      TOYScategories.value =
          snapshot.docs.map((doc) {
            print(doc.data());
            return Category.fromFirestore(doc);
          }).toList();
    } catch (e) {
      Get.snackbar("Error", "Failed to fetch categories: $e");
    } finally {
      isLoading(false);
    }
  }

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      imagePath.value = pickedFile.path;
    }
  }

  Future<void> addCategory(String collection) async {
    if (nameController.text.isEmpty || imagePath.value.isEmpty) {
       showStyledSnackbar(
      title: "خطأ",
      message: "يرجى إدخال جميع الحقول",
      backgroundColor: Colors.red,
      icon: Icons.error,);
      return;
    }

    isAddingCategory(true); // Start loading
    try {
      String id =''; // Generate a unique ID for the category
      String imageUrl = await _uploadCategoryImageToStorage(id, File(imagePath.value));

      Category mycategory = Category(
        
        name: nameController.text,
        image: imageUrl,
        itemCount: 0,
      );
      await _categoryService.addCategory(mycategory, collection);

       showStyledSnackbar(
      title: "نجاح",
      message: " تم إضافة القسم بنجاح!",
      backgroundColor: Colors.green,
      icon: Icons.check_circle,
    );
      nameController.clear();
      imagePath.value = '';
      
    } catch (e) {
      Get.snackbar(
        "Error",
        "Something went wrong: $e",
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isAddingCategory(false); // Stop loading
    }
  }

  Future<String> _uploadCategoryImageToStorage(String id, File file) async {
    
    
  String CategoryuniqueIdimage = DateTime.now().millisecondsSinceEpoch.toString();

    Reference ref = FirebaseStorage.instance.ref().child(
      "category_images/$CategoryuniqueIdimage.jpg",
    );
    UploadTask uploadTask = ref.putFile(file);
    TaskSnapshot snapshot = await uploadTask;
    return await snapshot.ref.getDownloadURL();
  }
}
