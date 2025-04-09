import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myhabeeb/Models/item_model.dart';
import 'package:myhabeeb/Services/item_service.dart';
import 'package:myhabeeb/helpers/snackbar.dart';

class ItemController extends GetxController {
  final ItemService _itemService = ItemService();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  String? selectedCategory;
  String? selectedSubCategory;
  String? priceType;
  String? imageUrl;
  RxString imagePath = ''.obs;
  var isAddingItem = false.obs; // Observable for loading state
  var isLoading = false.obs; // Observable for loading state
  var Items = <ItemModel>[].obs;

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      imagePath.value = pickedFile.path;
    }
  }

  Future<void> addItem(String subCategory, String id) async {
    selectedSubCategory = subCategory;
    if (nameController.text.isEmpty ||
        priceController.text.isEmpty ||
        descriptionController.text.isEmpty ||
        selectedCategory == null ||
        selectedSubCategory == null ||
        priceType == null ||
        imagePath.value.isEmpty) {
      print(
        "Error: ${nameController.text} ${priceController.text} ${descriptionController.text} ${selectedCategory} ${selectedSubCategory} ${priceType}",
      );
      Get.snackbar(
        "خطأ",
        "الرجاء إدخال جميع البيانات",
         titleText: Text(
        "خطأ",
      textAlign: TextAlign.right, // Align title to the right
      style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 16,
        fontFamily: 'Cairo', // Use the same font as the message
      ),
    ),
    messageText: Text(
        "الرجاء إدخال جميع البيانات",
      textAlign: TextAlign.right, // Align message to the right
      style: TextStyle(
        color: Colors.white,
        fontSize: 14,
        fontFamily: 'Cairo', // Use the same font as the title
      ),
    ),
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    double price = double.tryParse(priceController.text) ?? 0;
    String imageUrl = await _uploadImageToStorage( File(imagePath.value));

    ItemModel newItem = ItemModel(
      date: DateTime.now(),
      name: nameController.text,
      category: selectedCategory!,
      subcategory: selectedSubCategory!,
      price: price,
      priceType: priceType!,
      description: descriptionController.text,
      imageUrl: imageUrl ?? '',
      isStock: true,
    );

   await  _itemService
        .addItem(newItem, selectedCategory!, selectedSubCategory!, id)
        .then((_) {
          showStyledSnackbar(
            title: "نجاح",
            message: "تم إضافة المنتج بنجاح!",
            backgroundColor: Colors.green,
            icon: Icons.check_circle,
          );
        })
        .catchError((error) {
          showStyledSnackbar(
            title: "خطأ",
            message: "فشل في إضافة المنتج: $error",
            backgroundColor: Colors.red,
            icon: Icons.error,
          );
        });

    nameController.clear();
    priceController.clear();
    descriptionController.clear();
    selectedCategory = null;
    selectedSubCategory = null;
    priceType = null;
    imagePath.value = '';
  }
void fetchItems (String categoryId ,String collection ,String categoryName ) async {
   try {
      isLoading(true);
      final snapshot =
          await 
          FirebaseFirestore
          .instance.collection('Categories').doc('U6VWQKmnDWPF2NnH3fiQ')
          .collection(collection).doc(categoryId).collection('items').get();
      Items.value =
          snapshot.docs.map((doc) {
            print(doc.data());

            return ItemModel.fromFirestore(doc);
          }).toList();
    } catch (e) {
      Get.snackbar("Error", "Failed to fetch categories: $e");
    } finally {
      isLoading(false);
    }

  }
}
Future<String> _uploadImageToStorage( File file) async {
  String uniqueId = DateTime.now().millisecondsSinceEpoch.toString();

  Reference ref = FirebaseStorage.instance.ref().child("items_images/$uniqueId.jpg");
  UploadTask uploadTask = ref.putFile(file);
  TaskSnapshot snapshot = await uploadTask;
  return await snapshot.ref.getDownloadURL();
}


