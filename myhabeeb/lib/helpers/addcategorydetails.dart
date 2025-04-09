// ignore_for_file: sort_child_properties_last

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myhabeeb/Controllers/Category_controller.dart';

class CategoryDialog extends StatelessWidget {
  final String collection;
  final CategoryController controller = Get.find<CategoryController>();
  CategoryDialog({required this.collection});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl, // RTL layout

      child: AlertDialog(
        backgroundColor: Colors.white,
        title: Text(
          "اضافة قسم جديد ",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontFamily: 'Cairo',
          ),
        ),
        contentPadding: EdgeInsets.all(20),

        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Obx(
              () =>
                  controller.imagePath.value.isEmpty
                      ? IconButton(
                        icon: Icon(Icons.image, size: 50),
                        onPressed: () => controller.pickImage(),
                      )
                      : Image.file(
                        File(controller.imagePath.value),
                        height: 100,
                      ),
            ),
            TextField(
              controller: controller.nameController,
              decoration: InputDecoration(
                hintText: "اسم القسم",
                hintStyle: TextStyle(color: Colors.grey, fontFamily: 'Cairo'),
              ),
            ),
            SizedBox(height: 10),
          ],
        ),
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: () {
              controller.imagePath.value = ''; // Clear the image path
              controller.nameController.clear(); // Clear the text field
              Navigator.of(context).pop();
            },
            child: Text(
              " اغلاق",
              style: TextStyle(
                color: Colors.blue,
                fontFamily: 'Cairo',
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed:
                controller.isAddingCategory.value
                    ? null // Disable the button while loading
                    : () async {
                      await controller.addCategory(collection);
                      controller.imagePath.value =
                          ''; // Clear the image path after adding
                      controller.nameController
                          .clear(); // Clear the text field after adding
                    },
            child: Obx(() {
              return controller.isAddingCategory.value
                  ? SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  )
                  : Text(
                    "اضافة القسم ",
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Cairo',
                      fontWeight: FontWeight.bold,
                    ),
                  );
            }),
          ),
        ],
      ),
    );
  }
}
