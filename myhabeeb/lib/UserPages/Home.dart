// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:icons_plus/icons_plus.dart';
import 'package:myhabeeb/UserPages/itemspage.dart';
import 'package:myhabeeb/styles/theme.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

final List<Map<String, String>> categories = [
  {"name": "سيارات", "image": "assets/images/RC.png"},
  {"name": "لعابات", "image": "assets/images/doll.jpg"},
  {"name": "اسلحة", "image": "assets/images/guns.jpg"},
  {"name": "مسابح", "image": "assets/images/swpol.png"},
  {"name": "اخرى", "image": "assets/images/toys.png"},
];

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Directionality(
          textDirection: TextDirection.rtl,
          child: Container(
            height: ScreenSize.height,
            width: ScreenSize.width,
            color: Colors.white,
            child: Column(
              children: [
                Container(
                  height: ScreenSize.height * 0.1,
                  width: ScreenSize.width,
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment
                          .spaceBetween, // Aligns elements in a row
                      children: [
                        SizedBox(),
                        Center(
                          child: Text(
                            'الحبيب لتجارة الالعاب  ', // Title text
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                              fontFamily: 'Cairo',
                            ),
                          ),
                        ),
                        Icon(
                          IonIcons.notifications,
                          color: Colors
                              .blue, // You can change the color of the notification icon
                          size: 30, // Set the size of the icon
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 1,
                ),
                Container(
                  height: ScreenSize.height * 0.2,
                  width: ScreenSize.width * 0.99,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    border: Border.all(
                      color: Colors.transparent,
                      width: 0.5,
                    ),
                  ),
                  child: Card(
                    elevation: 2,
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Text(
                          //   "الاقسام",
                          //   style: TextStyle(
                          //     fontSize: 16,
                          //     fontWeight: FontWeight.bold,
                          //     color: Colors.blue,
                          //     fontFamily: 'Cairo',
                          //   ),
                          // ),
                          SizedBox(height: 1),
                          Expanded(
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: categories.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  width: ScreenSize.width * 0.2,
                                  height: ScreenSize.height * 0.05,
                                  padding: EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(
                                        12), // Rounded corners
                                    border: Border.all(
                                        color: Colors.transparent,
                                        width: 0.5), // Blue border
                                  ),
                                  margin: EdgeInsets.symmetric(horizontal: 0),
                                  child: GestureDetector(
                                    onTap: () {
                                      Get.to(() => ItemsPage());
                                    },
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment
                                          .center, // Centers the content
                                      children: [
                                        Image.asset(
                                          categories[index]["image"]!,

                                          fit: BoxFit
                                              .contain, // Ensures the image fills the container
                                        ),
                                        SizedBox(height: 4),
                                        Text(
                                          categories[index]["name"]!,
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: ScreenSize.height * 0.02),
                Container(
                  height: ScreenSize.height * 0.15,
                  width: ScreenSize.width,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Card(
                    elevation: 0,
                    color: Colors.white,
                    child: Image.asset(
                      'assets/images/shop2.png',
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
                SizedBox(height: ScreenSize.height * 0.02),
                Container(
                  height: ScreenSize.height * 0.3,
                  width: ScreenSize.width * 0.95,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Card(
                    elevation: 0,
                    color: Colors.white,
                    child: CarouselSlider(
                      options: CarouselOptions(
                        height: double.infinity,
                        autoPlay: false,
                        enlargeCenterPage: true,
                        aspectRatio: 16 / 9,
                        viewportFraction: 0.7,
                      ),
                      items: [
                        Image.asset(
                          'assets/images/slide1.png',
                          fit: BoxFit.contain,
                        ),
                        Image.asset(
                          'assets/images/slide1.png',
                          fit: BoxFit.contain,
                        ),
                        Image.asset(
                          'assets/images/slide1.png',
                          fit: BoxFit.contain,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
