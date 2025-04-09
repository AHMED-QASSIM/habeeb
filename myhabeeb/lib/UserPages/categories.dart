// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:myhabeeb/Styles/theme.dart';

class CategoriesPage extends StatefulWidget {
  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  // Sample categories data
  final List<Map<String, dynamic>> categories = [
    {
      'image': 'assets/images/guns.jpg', // Replace with actual image path
      'name': 'الاسلحة',
      'itemCount': 245,
    },
    {
      'image': 'assets/images/swpol.png', // Replace with actual image path

      'name': 'مسابح',
      'itemCount': 152,
    },
    {
      'image': 'assets/images/doll.jpg', // Replace with actual image path

      'name': 'لعابات',
      'itemCount': 208,
    },
    {
      'image': 'assets/images/RC.png', // Replace with actual image path

      'name': 'سيارات',
      'itemCount': 300,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Directionality(
          textDirection: TextDirection.rtl, // RTL layout
          child: SingleChildScrollView(
            child: Container(
                height: ScreenSize.height,
                color: Colors.white,
                child: Column(
                  children: [
                                  Container(
                    height: ScreenSize.height * 0.08,
                    width: ScreenSize.width * 0.99,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Card(
                      elevation: 5,
                      color: Colors.blue,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child:   Center(
                            child: Text(
                              'اقسام المنتجات    ', // Title text
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontFamily: 'Cairo',
                              ),
                            ),
                          ),
                      ),
                    ),
                  ),
                  SizedBox(height: ScreenSize.height * 0.01),
                    SingleChildScrollView(
                      child: Container(
                       height: ScreenSize.height * 0.75,
                        width: ScreenSize.width,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30.0), // Top-left radius
                            topRight: Radius.circular(30.0), // Top-right radius
                          ),
                        ),
                        child: ListView.builder(
                          itemCount: categories.length,
                          itemBuilder: (context, index) {
                            return Container(
                              height: ScreenSize.height * 0.2,
                              width: ScreenSize.width,
                              margin:
                                  EdgeInsets.symmetric(vertical: 2, horizontal: 2),
                              child: Card(
                                color: Colors.white,
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Column(
                                  children: [
                                    // Category Image
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.asset(
                                        categories[index]['image']!,
                                        width: ScreenSize.width * 0.9,
                                        height: ScreenSize.height * 0.15,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                              
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              categories[index]['name']!,
                                              style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.blue,
                                                fontFamily: 'Cairo',
                                              ),
                                            ),
                                            SizedBox(height: 8),
                                            Text(
                                              ' ${categories[index]['itemCount']} ايتم',
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.black,
                                                fontFamily: 'Cairo',
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
