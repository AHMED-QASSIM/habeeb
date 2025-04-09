// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:group_button/group_button.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myhabeeb/Controllers/Category_controller.dart';
import 'package:myhabeeb/Controllers/item_controller.dart';
import 'package:myhabeeb/Models/item_model.dart';
import 'dart:io';
import 'package:myhabeeb/Services/item_service.dart';

import 'package:pull_to_refresh/pull_to_refresh.dart';

class AddItemspage extends StatefulWidget {
  const AddItemspage({super.key});

  @override
  State<AddItemspage> createState() => _AddItemspageState();
}

class _AddItemspageState extends State<AddItemspage> {
  File? _image;
  final picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  String? selectedMYSUBCategory; // To store the selected value
  String? selectedMYSUBCategoryID;
  final CategoryController carcategorycontroller = Get.put(
    CategoryController(),
  );
  final CategoryController toyscategorycontroller = Get.put(
    CategoryController(),
  );
  RefreshController _refreshController = RefreshController(
    initialRefresh: false,
  );

  String? theselectedCategory; // To store the selected value
  final GroupButtonController _controller1 =
      GroupButtonController(); // Controller to manage selection
  final GroupButtonController _controller2 =
      GroupButtonController(); // Controller to manage selection
  void initState() {
    super.initState();
    // Initialize the controllers
    carcategorycontroller.fetchCarCategories("CarsCategory");
    toyscategorycontroller.fetchToysCategories("ToysCategory");
  }

  void _showCategoryPicker() {
    // Fetch categories based on the selected category
    if (theselectedCategory == "العاب") {
      toyscategorycontroller.fetchToysCategories("ToysCategory");
    } else if (theselectedCategory == "سيارات") {
      carcategorycontroller.fetchCarCategories("CarsCategory");
    }

    // Show the bottom sheet
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      isScrollControlled: false, // Allows the bottom sheet to take more space
      builder: (BuildContext context) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Container(
            color: Colors.white,
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "اختر الفئة",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Tajawal',
                  ),
                ),
                SizedBox(height: 10),
                Expanded(
                  child: Obx(() {
                    // Dynamically select the controller based on the selected category
                    final isLoading =
                        theselectedCategory == "العاب"
                            ? toyscategorycontroller.isLoading.value
                            : carcategorycontroller.isLoading.value;

                    final categories =
                        theselectedCategory == "العاب"
                            ? toyscategorycontroller.TOYScategories
                            : carcategorycontroller.CARScategories;

                    // Show loading indicator if data is being fetched
                    if (isLoading) {
                      return Center(child: CircularProgressIndicator());
                    }

                    // Show a message if no categories are found
                    if (theselectedCategory == null) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 2.0),
                        child: Center(
                          child: Container(
                            height: 50,
                            width: double.infinity,
                            child: Center(
                              child: Text(
                                ' يرجى اختيار النوع  ',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Cairo',
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }

                    // Display the list of categories
                    return ListView.builder(
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border(
                                bottom: BorderSide(
                                  color: Colors.grey,
                                  width: 0.5,
                                ),
                              ),
                            ),
                            width: double.infinity,
                            height: 50,
                            child: Text(
                              categories[index]
                                  .name, // Assuming each category has a 'name' field
                              style: TextStyle(fontFamily: 'Tajawal'),
                            ),
                          ),
                          onTap: () {
                            setState(() {
                              selectedMYSUBCategory = categories[index].name;
                              selectedMYSUBCategoryID = categories[index].id;
                            });
                            Navigator.pop(context); // Close the bottom sheet
                          },
                        );
                      },
                    );
                  }),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    final ItemController controller = Get.put(ItemController());

    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(() {
        return Stack(
          children: [
            SafeArea(
              child: SmartRefresher(
                enablePullDown: true,

                enablePullUp: false,
                controller: _refreshController,
                onRefresh: () async {
                  await Future.delayed(Duration(milliseconds: 1000));
                  controller.imagePath.value =
                      ''; // Clear the image path after adding
                  _refreshController.refreshCompleted();
                },
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: screenHeight * 0.1,
                            width: screenWidth,
                            decoration: BoxDecoration(
                              color: Colors.blue[100],
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(
                                  25.0,
                                ), // Top-left radius
                                bottomRight: Radius.circular(
                                  25.0,
                                ), // Top-right radius
                              ),
                            ),

                            child: Center(
                              child: Text(
                                'اضافة  منتجات جديد',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontFamily: 'Cairo',
                                ),
                              ),
                            ),
                          ),
                          Container(
                            // height: screenHeight ,
                            width: screenWidth,
                            decoration: BoxDecoration(
                              color:
                                  const Color.fromARGB(
                                    255,
                                    255,
                                    255,
                                    255,
                                  )!, // Light blue background color
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(
                                  50.0,
                                ), // Top-left radius
                                topRight: Radius.circular(
                                  50.0,
                                ), // Top-right radius
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 10),
                                Center(
                                  child: CircleAvatar(
                                    radius: 50,
                                    backgroundColor: Colors.white,
                                    backgroundImage:
                                        _image != null
                                            ? FileImage(_image!)
                                            : null,
                                    child: Obx(
                                      () =>
                                          controller.imagePath.value.isEmpty
                                              ? IconButton(
                                                icon: Icon(
                                                  Icons.add_a_photo,
                                                  size: 50,
                                                  color: Colors.blue[900],
                                                ),
                                                onPressed:
                                                    () =>
                                                        controller.pickImage(),
                                              )
                                              : Image.file(
                                                File(
                                                  controller.imagePath.value,
                                                ),
                                                height: 100,
                                              ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  ' الاسم  ',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                    fontFamily: 'Tajawal',
                                  ),
                                ),
                                Container(
                                  width: screenWidth * 0.99,
                                  height: screenHeight * 0.09,
                                  padding: EdgeInsets.symmetric(horizontal: 1),
                                  child: Card(
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    elevation: 3,
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 15,
                                        vertical: 10,
                                      ),
                                      child: TextField(
                                        controller: controller.nameController,
                                        decoration: InputDecoration(
                                          hintText: " ادخل اسم المنتج",
                                          hintStyle: TextStyle(
                                            fontFamily: 'Tajawal',
                                            color: Colors.grey,
                                          ),
                                          border: InputBorder.none,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                    SizedBox(height: 10),
                                // Text(
                                //   ' الرمز  ',
                                //   style: TextStyle(
                                //     fontSize: 16,
                                //     color: Colors.black,
                                //     fontFamily: 'Tajawal',
                                //   ),
                                // ),
                                // Container(
                                //   width: screenWidth * 0.99,
                                //   height: screenHeight * 0.09,
                                //   padding: EdgeInsets.symmetric(horizontal: 1),
                                //   child: Card(
                                //     color: Colors.white,
                                //     shape: RoundedRectangleBorder(
                                //       borderRadius: BorderRadius.circular(5),
                                //     ),
                                //     elevation: 3,
                                //     child: Padding(
                                //       padding: EdgeInsets.symmetric(
                                //         horizontal: 15,
                                //         vertical: 10,
                                //       ),
                                //       child: TextField(
                                //         controller: controller.nameController,
                                //         decoration: InputDecoration(
                                //           hintText: " ادخل  الرمز",
                                //           hintStyle: TextStyle(
                                //             fontFamily: 'Tajawal',
                                //             color: Colors.grey,
                                //           ),
                                //           border: InputBorder.none,
                                //         ),
                                //       ),
                                //     ),
                                //   ),
                                // ),
                                SizedBox(height: 10),
                                Text(
                                  'النوع',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                    fontFamily: 'Tajawal',
                                  ),
                                ),
                                Center(
                                  child: GroupButton(
                                    controller: _controller1,

                                    enableDeselect: true,
                                    buttons: ["العاب", "سيارات حديد"],
                                    isRadio:
                                        true, // Ensures only one selection at a time
                                    onSelected: (value, index, isSelected) {
                                      setState(() {
                                        print("Selected: $value");
                                        theselectedCategory = value;
                                        controller.selectedCategory = value;
                                        if (theselectedCategory == "العاب") {
                                          controller.selectedCategory =
                                              "ToysCategory";
                                        } else if (theselectedCategory ==
                                            "سيارات حديد") {
                                          controller.selectedCategory =
                                              "CarsCategory";
                                        }
                                      });
                                    },
                                    options: GroupButtonOptions(
                                      buttonWidth: screenWidth * 0.47,
                                      selectedColor: Colors.blue[900],
                                      unselectedColor: Colors.white,
                                      selectedTextStyle: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontFamily: 'Tajawal',
                                      ),
                                      unselectedTextStyle: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontFamily: 'Tajawal',
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                      spacing: 10,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  'الفئة',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                    fontFamily: 'Tajawal',
                                  ),
                                ),
                                GestureDetector(
                                  onTap: _showCategoryPicker,
                                  child: Container(
                                    width: screenWidth * 0.99,
                                    height: screenHeight * 0.07,

                                    child: Card(
                                      color: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      elevation: 3,
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 15,
                                          vertical: 10,
                                        ),
                                        child: Text(
                                          selectedMYSUBCategory ?? "اختر الفئة",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontFamily: 'Tajawal',
                                            color:
                                                selectedMYSUBCategory == null
                                                    ? Colors.grey
                                                    : Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10),

                                Text(
                                  'السعر ',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                    fontFamily: 'Tajawal',
                                  ),
                                ),
                                Container(
                                  width: screenWidth * 0.99,
                                  height: screenHeight * 0.09,
                                  padding: EdgeInsets.all(2),
                                  child: Card(
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    elevation: 3,
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 15,
                                        vertical: 10,
                                      ),
                                      child: TextField(
                                        keyboardType: TextInputType.number,
                                        controller: controller.priceController,
                                        decoration: InputDecoration(
                                          hintText: "  ادخل سعر المنتج",
                                          hintStyle: TextStyle(
                                            fontFamily: 'Tajawal',
                                            color: Colors.grey,
                                          ),
                                          border: InputBorder.none,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),

                                SizedBox(height: 10),
                                Text(
                                  'نوع السعر ',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                    fontFamily: 'Tajawal',
                                  ),
                                ),
                                Center(
                                  child: GroupButton(
                                    enableDeselect: true,
                                    controller: _controller2,

                                    buttons: ["قطعة", "درزن", "باكيت"],
                                    isRadio:
                                        true, // Ensures only one selection at a time
                                    onSelected: (value, index, isSelected) {
                                      print("Selected: $value");
                                      setState(() {
                                        controller.priceType = value;
                                      });
                                    },
                                    options: GroupButtonOptions(
                                      buttonWidth: screenWidth * 0.30,
                                      selectedColor: Colors.blue[900],

                                      unselectedColor: Colors.white,
                                      selectedTextStyle: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontFamily: 'Tajawal',
                                      ),
                                      unselectedTextStyle: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontFamily: 'Tajawal',
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                      spacing: 10,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  'الوصف ',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                    fontFamily: 'Tajawal',
                                  ),
                                ),
                                Container(
                                  width: screenWidth * 0.99,
                                  height: screenHeight * 0.15,
                                  padding: EdgeInsets.all(2),
                                  child: Card(
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    elevation: 3,
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 15,
                                        vertical: 10,
                                      ),
                                      child: TextField(
                                        // maxLines: 5,
                                        controller:
                                            controller.descriptionController,
                                        decoration: InputDecoration(
                                          hintText: "ادخل وصف المنتج",
                                          hintStyle: TextStyle(
                                            fontFamily: 'Tajawal',
                                            color: Colors.grey,
                                          ),
                                          border: InputBorder.none,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 20),
                                Center(
                                  child: Container(
                                    width: screenWidth * 0.9,
                                    height: screenHeight * 0.06,
                                    color: Colors.transparent,
                                    child: ElevatedButton.icon(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.blue[900],

                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            15,
                                          ),
                                          side: BorderSide(
                                            color: Colors.transparent,
                                            width: 1.0,
                                          ),
                                        ),
                                      ),
                                      onPressed:
                                          controller.isAddingItem.value
                                              ? null // Disable the button while loading
                                              : () async {
                                                if (theselectedCategory ==
                                                        null ||
                                                    selectedMYSUBCategory ==
                                                        null ||
                                                    controller
                                                        .imagePath
                                                        .value
                                                        .isEmpty ||
                                                    controller
                                                        .nameController
                                                        .text
                                                        .isEmpty ||
                                                    controller
                                                        .priceController
                                                        .text
                                                        .isEmpty ||
                                                    controller
                                                        .descriptionController
                                                        .text
                                                        .isEmpty ||
                                                    controller.priceType ==
                                                        null) {
                                                  Get.snackbar(
                                                    "خطأ",
                                                    "الرجاء إدخال جميع البيانات",

                                                    snackPosition:
                                                        SnackPosition.TOP,
                                                    backgroundColor:
                                                        Colors.red, // Background color
                                                    titleText: Text(
                                                      "خطأ",
                                                      textAlign:
                                                          TextAlign.right,
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 16,
                                                        fontFamily: 'Cairo',
                                                      ),
                                                    ),
                                                    messageText: Text(
                                                      "الرجاء إدخال جميع البيانات",
                                                      textAlign:
                                                          TextAlign.right,
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 14,
                                                        fontFamily: 'Cairo',
                                                      ),
                                                    ),
                                                    colorText: Colors.white,
                                                  );
                                                  return;
                                                }

                                                controller.isAddingItem.value =
                                                    true;
                                                await controller.addItem(
                                                  selectedMYSUBCategory!,
                                                  selectedMYSUBCategoryID!,
                                                );
                                                selectedMYSUBCategory = null;
                                                selectedMYSUBCategoryID = null;
                                                theselectedCategory = null;
                                                _controller1.unselectAll();
                                                _controller2.unselectAll();

                                                controller.isAddingItem.value =
                                                    false;



                                              },
                                      label: Text(
                                        ' اضافة      ',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Cairo',
                                          color: Colors.white,
                                        ),
                                      ),
                                      icon: Icon(
                                        Icons.add,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            // Loading overlay
            if (controller.isAddingItem.value)
              Positioned.fill(
                child: Container(
                  color: Colors.black.withOpacity(
                    0.5,
                  ), // Semi-transparent overlay
                  child: Center(
                    child: CircularProgressIndicator(color: Colors.white),
                  ),
                ),
              ),
          ],
        );
      }),
    );
  }
}
