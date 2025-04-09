import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myhabeeb/Controllers/customer_controller.dart';
import 'package:myhabeeb/Models/customer_model.dart';
import 'package:myhabeeb/Services/customer_services.dart';

class Registerpage extends StatefulWidget {
  const Registerpage({super.key});

  @override
  State<Registerpage> createState() => _RegisterpageState();
}

final _addnewcustomer = GlobalKey<FormState>();
  final customersController customer_controller =
      Get.find<customersController>();
final TextEditingController nameController = TextEditingController();
final TextEditingController usernameController = TextEditingController();
final TextEditingController passwordController = TextEditingController();
final TextEditingController phoneController = TextEditingController();
final TextEditingController addressController = TextEditingController();
final TextEditingController shopnameController = TextEditingController();

File? _selectedImage;

class _RegisterpageState extends State<Registerpage> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        body: Directionality(
          textDirection: TextDirection.rtl,
          child: Container(
            color: Colors.blue[900],

            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: screenHeight * 0.13,
                    width: screenWidth,
                    color: Colors.blue[900],
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 24.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          IconButton(
                            icon: Icon(Icons.logout_outlined),
                            color: Colors.white,
                            iconSize: 30,
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                          SizedBox(width: screenWidth * 0.2),
                          Text(
                            'إنشاء حساب',
                            style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontFamily: 'Cairo',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: screenHeight * 0.835,
                    width: screenWidth,
                    decoration: BoxDecoration(
                      color: Colors.white, // Light blue background color
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50.0), // Top-left radius
                        topRight: Radius.circular(50.0), // Top-right radius
                      ),
                    ),
                    child: Form(
                      key: _addnewcustomer,
                      child: Container(
                        color: Colors.transparent,
                        height: screenHeight,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(height: screenHeight * 0.03),

                            Center(
                              child: Padding(
                                padding: const EdgeInsets.all(1.0),
                                child: GestureDetector(
                                  onTap: () async {


                                                               _selectedImage = await customer_controller.CustomerService
                                .pickImageFromGallery();
                            setState(() {});
                                  },
                                  child: Container(
                                    height: screenHeight * 0.15,
                                    child: CircleAvatar(
                                      radius: 60,
                                      backgroundColor: Color.fromARGB(
                                        255,
                                        209,
                                        221,
                                        244,
                                      ),
                                      child:
                                          _selectedImage != null
                                              ? CircleAvatar(
                                                radius: 60,
                                                backgroundColor: Color.fromARGB(
                                                  255,
                                                  209,
                                                  221,
                                                  244,
                                                ),
                                                backgroundImage: FileImage(
                                                  _selectedImage!,
                                                ),
                                              )
                                              : Icon(
                                                Icons.add_a_photo,
                                                color: Colors.blue,
                                              ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 15),
                            Center(
                              child: Container(
                                width: screenWidth * 0.95,
                                height: screenHeight * 0.06,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.blue, // Border color
                                    width: 1, // Border width
                                  ),
                                  borderRadius: BorderRadius.circular(
                                    8,
                                  ), // Optional: rounded corners
                                ),
                                child: TextFormField(
                                  controller: nameController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter value';
                                    }
                                    return null;
                                  },
                                  textAlign: TextAlign.right,
                                  decoration: InputDecoration(
                                    hintText: 'اسم الزبون',
                                    hintStyle: TextStyle(
                                      fontSize: 14,
                                      fontFamily: 'Cairo',
                                      color: Colors.grey[600],
                                    ),
                                    filled: true,
                                    fillColor: Colors.white,
                                    contentPadding: EdgeInsets.symmetric(
                                      vertical: 15.0,
                                      horizontal: 10.0,
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12.0),
                                      borderSide:  BorderSide.none,
                                    ),
                                    
                                    prefixIcon: Icon(
                                      Icons.person,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            Center(
                              child: Container(
                                width: screenWidth * 0.95,
                                height: screenHeight * 0.06,
                                 decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.blue, // Border color
                                    width: 1, // Border width
                                  ),
                                  borderRadius: BorderRadius.circular(
                                    8,
                                  ), // Optional: rounded corners
                                ),
                                child: TextFormField(
                                  controller: addressController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter value';
                                    }
                                    return null;
                                  },
                                  textAlign: TextAlign.right,
                                  decoration: InputDecoration(
                                    hintText: 'العنوان',
                                    hintStyle: TextStyle(
                                      fontSize: 14,
                                      fontFamily: 'Cairo',
                                      color: Colors.grey[600],
                                    ),
                                    filled: true,
                                    fillColor: Colors.white,
                                    contentPadding: EdgeInsets.symmetric(
                                      vertical: 15.0,
                                      horizontal: 10.0,
                                    ),
                                     border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12.0),
                                      borderSide:  BorderSide.none,
                                    ),
                                    prefixIcon: Icon(
                                      Icons.location_city,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            Center(
                              child: Container(
                                width: screenWidth * 0.95,
                                 height: screenHeight * 0.06,
                                 decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.blue, // Border color
                                    width: 1, // Border width
                                  ),
                                  borderRadius: BorderRadius.circular(
                                    8,
                                  ), // Optional: rounded corners
                                ),
                                child: TextFormField(
                                  controller: shopnameController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter value';
                                    }
                                    return null;
                                  },
                                  textAlign: TextAlign.right,
                                  decoration: InputDecoration(
                                    hintText: 'اسم المحل',
                                    hintStyle: TextStyle(
                                      fontSize: 14,
                                      fontFamily: 'Cairo',
                                      color: Colors.grey[600],
                                    ),
                                    filled: true,
                                    fillColor: Colors.white,
                                    contentPadding: EdgeInsets.symmetric(
                                      vertical: 15.0,
                                      horizontal: 10.0,
                                    ),
                                   border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12.0),
                                      borderSide:  BorderSide.none,
                                    ),
                                    prefixIcon: Icon(
                                      Icons.store,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 10),

                            Center(
                              child: Container(
                                width: screenWidth * 0.95,
                                height: screenHeight * 0.06,
                                 decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.blue, // Border color
                                    width: 1, // Border width
                                  ),
                                  borderRadius: BorderRadius.circular(
                                    8,
                                  ), // Optional: rounded corners
                                ),
                                child: TextFormField(
                                  controller: usernameController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter value';
                                    }
                                    return null;
                                  },
                                  textAlign: TextAlign.right,
                                  decoration: InputDecoration(
                                    hintText: 'اسم الدخول للنظام',
                                    hintStyle: TextStyle(
                                      fontSize: 14,
                                      fontFamily: 'Cairo',
                                      color: Colors.grey[600],
                                    ),
                                    filled: true,
                                    fillColor: Colors.white,
                                    contentPadding: EdgeInsets.symmetric(
                                      vertical: 15.0,
                                      horizontal: 10.0,
                                    ),
                                   border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12.0),
                                      borderSide:  BorderSide.none,
                                    ),
                                    prefixIcon: Icon(
                                      Icons.email,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 10),

                            Center(
                              child: Container(
                                width: screenWidth * 0.95,
                               height: screenHeight * 0.06,
                                 decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.blue, // Border color
                                    width: 1, // Border width
                                  ),
                                  borderRadius: BorderRadius.circular(
                                    8,
                                  ), // Optional: rounded corners
                                ),
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  controller: passwordController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter value';
                                    }
                                    return null;
                                  },
                                  textAlign: TextAlign.right,
                                  decoration: InputDecoration(
                                    hintText: 'رمز الدخول للنظام',
                                    hintStyle: TextStyle(
                                      fontSize: 14,
                                      fontFamily: 'Cairo',
                                      color: Colors.grey[600],
                                    ),
                                    filled: true,
                                    fillColor: Colors.white,
                                    contentPadding: EdgeInsets.symmetric(
                                      vertical: 15.0,
                                      horizontal: 10.0,
                                    ),
                                   border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12.0),
                                      borderSide:  BorderSide.none,
                                    ),
                                    prefixIcon: Icon(
                                      Icons.password,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 10),

                            Center(
                              child: Container(
                                width: screenWidth * 0.95,
                                 height: screenHeight * 0.06,
                                 decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.blue, // Border color
                                    width: 1, // Border width
                                  ),
                                  borderRadius: BorderRadius.circular(
                                    8,
                                  ), // Optional: rounded corners
                                ),
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  controller: phoneController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter value';
                                    }
                                    return null;
                                  },
                                  textAlign: TextAlign.right,
                                  decoration: InputDecoration(
                                    hintText: 'رقم الهاتف ',
                                    hintStyle: TextStyle(
                                      fontSize: 14,
                                      fontFamily: 'Cairo',
                                      color: Colors.grey[600],
                                    ),
                                    filled: true,
                                    fillColor: Colors.white,
                                    contentPadding: EdgeInsets.symmetric(
                                      vertical: 15.0,
                                      horizontal: 10.0,
                                    ),
                                   border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12.0),
                                      borderSide:  BorderSide.none,
                                    ),
                                    prefixIcon: Icon(
                                      Icons.phone,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.1),

                            Center(
                              child: Container(
                                width: screenWidth * 0.95,
                                height: screenHeight * 0.06,
                                color: Colors.transparent,
                                child: ElevatedButton.icon(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.blue[900],
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                      side: BorderSide(
                                        color: Colors.transparent,
                                        width: 1.0,
                                      ),
                                    ),
                                  ),
                                  onPressed: () {

                            if (_addnewcustomer.currentState?.validate() ??
                                false) {
                              final customers = CustomerModel(
                                id: '',
                                name: nameController.text,
                                address: addressController.text,
                                shopName: shopnameController.text,
                                username: usernameController.text,
                                password: passwordController.text,
                                phoneNumber: phoneController.text,
                                isActive: false,
                                registerDate:Timestamp.fromDate(DateTime.now()), // Set the current date
                                imageUrl: '', // Set a default value or leave it empty


                              );
                              customer_controller.addCustomer(customers, _selectedImage); 
                            } else {
                              // Form is invalid, show error messages
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: Text(
                                        'يرجى إدخال جميع الحقول')),
                              );
                            }



                                  },
                                  label: Text(
                                    ' تسجيل ',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Cairo',
                                      color: Colors.white,
                                    ),
                                  ),
                                  icon: Icon(
                                    Icons.app_registration,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
