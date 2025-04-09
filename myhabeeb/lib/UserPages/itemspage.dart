// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myhabeeb/Styles/theme.dart';
import 'package:myhabeeb/UserPages/itemdetails.dart';

class ItemsPage extends StatefulWidget {
  @override
  _ItemsPageState createState() => _ItemsPageState();
}

class _ItemsPageState extends State<ItemsPage> {
  // Sample list of items to display
  final List<Map<String, String>> items = [
    {
      'image': 'assets/images/guns.jpg', // Replace with actual image path
      'name': 'مسدس ماء',
      'category': 'الاسلحة',
      'price': '12000', // Price for 12 items (dozen)
    },
    {
      'image': 'assets/images/swpol.png', // Replace with actual image path
      'name': 'مسبح اطفال',
      'category': 'مسابح',
      'price': '15000', // Price for 12 items (dozen)
    },
    {
      'image': 'assets/images/RC.png', // Replace with actual image path
      'name': 'سيارة ار سي ',
      'category': 'سيارات',
      'price': '18000', // Price for 12 items (dozen)
    },

    {
      'image': 'assets/images/guns.jpg', // Replace with actual image path
      'name': 'مسدس ماء',
      'category': 'الاسلحة',
      'price': '12000', // Price for 12 items (dozen)
    },
    {
      'image': 'assets/images/swpol.png', // Replace with actual image path
      'name': 'مسبح اطفال',
      'category': 'مسابح',
      'price': '15000', // Price for 12 items (dozen)
    },
    {
      'image': 'assets/images/RC.png', // Replace with actual image path
      'name': 'سيارة ار سي ',
      'category': 'سيارات',
      'price': '18000', // Price for 12 items (dozen)
    },
    // Add more items as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Directionality(
        textDirection: TextDirection.rtl, // Set the page direction to RTL
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 24.0),
                child: Container(
                             height: ScreenSize.height * 0.07,
                  width: ScreenSize.width,
                           child: Row(
                             children: [
                               IconButton(
                                 onPressed: () {
                                   Navigator.pop(context);
                                 },
                                 icon: Icon(
                                   Icons.arrow_back,
                                   size: 25,
                                   color: Colors.blue,
                                 ),
                               ),
                               Padding(
                                 padding:
                                     const EdgeInsets.symmetric(horizontal: 2.0),
                                 child: Text(
                                   " المنتجات ",
                                   style: TextStyle(
                                     fontSize: 22,
                                     fontWeight: FontWeight.bold,
                                     fontFamily: 'Cairo',
                                     color: Colors.black,
                                   ),
                                 ),
                               ),
                             ],
                           )
                ),
              ),
              Container(
                height: ScreenSize.height * 0.90,
                width: ScreenSize.width,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // 2 items per row
                      crossAxisSpacing: 8.0,
                      mainAxisSpacing: 8.0,
                      childAspectRatio:
                          0.75, // Adjust the height/width ratio of each card
                    ),
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: ()
                        {
                          Get.to(() => ItemDetailsPage(itemIndex: index,));
                        },
                        child: Card(
                          color: Colors.white,
                          elevation: 4.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.asset(
                                  items[index]['image']!, // Item image
                                  width: double.infinity,
                                  height: 120, // Adjust height of image
                                  fit: BoxFit.contain,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                items[index]['name']!, // Item name
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: 4),
                              Text(
                                items[index]['category']!, // Item category
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[600],
                                ),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: 4),
                              Text(
                                '  ${items[index]['price']} د.ع  / الدرزن', // Price for 12 items
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue,
                                  fontFamily: 'Cairo',
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
          ),
        ),
      ),
    );
  }
}
