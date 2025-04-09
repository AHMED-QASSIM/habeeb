// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myhabeeb/AdminPages/AdminMainPage.dart';
import 'package:myhabeeb/helpers/snackbar.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        body: Directionality(
          textDirection: TextDirection.rtl,
          child: SingleChildScrollView(
            child: Container(
              height: screenHeight,
              width: screenWidth,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment:  CrossAxisAlignment.start,
                  children: [
                                      Container(
                      height: screenHeight * 0.05,
                      color: Colors.white,
                      child:   IconButton(
                            icon: Icon(Icons.logout_outlined),
                            color: Colors.blue[900],
                            iconSize: 30,
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                    ),
                    Container(
                      color: Colors.transparent,
                      height: screenHeight * 0.45,
                      //width: screenWidth ,
                      child: Image.asset(
                        'assets/images/logo2.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.05),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'مرحبا بك',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Cairo',
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          ' الرجاء ادخال اسم المستخدم ورمزك السري للدخول الى التطبيق ',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.normal,
                            fontFamily: 'Cairo',
                            color: Colors.grey[700],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 25),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Container(
                            height: screenHeight * 0.1,
                            width: screenWidth * 0.95,
                            child: TextFormField(
                              controller: nameController,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.grey[100],
                                labelText: 'اسم المستخدم',
                                labelStyle: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                  fontFamily: 'Cairo',
                                  color: Colors.grey[700],
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(7.0),
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                  ), // Default border color
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(7.0),
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                  ), // Border color when not focused
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(7.0),
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                  ), // Border color when focused
                                ),
                                prefixIcon: Icon(
                                  Icons.person,
                                  color: Color.fromARGB(255, 3, 74, 131),
                                ),
                              ),
                            ),
                          ),
                        ),
                        // SizedBox(height: 5.0),
                        Center(
                          child: Container(
                            height: screenHeight * 0.1,
                            width: screenWidth * 0.95,
                            child: TextFormField(
                              controller: passwordController,
                              keyboardType: TextInputType.number,
                              obscureText: true,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.grey[100],
                                labelText: 'الرمز السري',
                                labelStyle: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                  fontFamily: 'Cairo',
                                  color: Colors.grey[700],
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(7.0),
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                  ), // Default border color
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(7.0),
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                  ), // Border color when not focused
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(7.0),
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                  ), // Border color when focused
                                ),
                                prefixIcon: Icon(
                                  Icons.lock,
                                  color: Color.fromARGB(255, 3, 74, 131),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: screenWidth * 0.95,
                          height: screenHeight * 0.06,
                          color: Colors.transparent,
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color.fromARGB(
                                255,
                                3,
                                74,
                                131,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                                side: BorderSide(
                                  color: Colors.transparent,
                                  width: 1.0,
                                ),
                              ),
                            ),
                            onPressed: () {
                              String name = nameController.text.trim();
                              String password = passwordController.text.trim();
                              if (name == 'habeeb' || password == '2025') {
                                Get.to(() => AdminNavBar());
                              } else {
                                showStyledSnackbar(
                                  title: "فشل",
                                  message: "اسم المستخدم أو الرمز السري غير صحيح",
                                  backgroundColor: Colors.red,
                                  icon: Icons.error,
                                );
                              }
                            },
                            label: Text(
                              ' تسجيل الدخول   ',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Cairo',
                                color: Colors.white,
                              ),
                            ),
                            icon: Icon(Icons.login, color: Colors.white),
                          ),
                        ),
                        Text(
                          ' يرجى التواصل مع الادارة في حال نسيان الرمز السري ',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.normal,
                            fontFamily: 'Cairo',
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
