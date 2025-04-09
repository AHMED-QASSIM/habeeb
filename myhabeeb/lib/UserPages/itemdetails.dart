// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:myhabeeb/Styles/theme.dart';
import 'package:icons_plus/icons_plus.dart';

class ItemDetailsPage extends StatelessWidget {
  final int itemIndex;

  // Sample list of items (replace with actual data)
  final List<Map<String, dynamic>> items = [
    {
      'image': 'assets/images/swpol.png', // Replace with actual image path
      'name': 'مسبح اطفال',
      'category': 'مسابح',
      'price': '15000', // Price for 12 items (dozen)
      'details': 'مسبح اطفال قياس 100 في 200  ماركة انديكس',
    },
    {
      'image': 'assets/item2.jpg', // Replace with actual image path
      'name': 'Item 2',
      'category': 'Category 2',
      'price': '15000', // Price for 12 items (dozen)
      'details':
          'This is the description for Item 2. It contains various details about the product.',
    },
    {
      'image': 'assets/item3.jpg', // Replace with actual image path
      'name': 'Item 3',
      'category': 'Category 3',
      'price': '18000', // Price for 12 items (dozen)
      'details':
          'This is the description for Item 3. It contains various details about the product.',
    },
    // Add more items as needed
  ];

  // Constructor to accept itemIndex
  ItemDetailsPage({required this.itemIndex});

  @override
  Widget build(BuildContext context) {
    final item = items[itemIndex]; // Get the item details based on the index

    return Scaffold(
      body: Container(
        color: Colors.white,
        height: ScreenSize.height,
        child: Directionality(
          textDirection: TextDirection.rtl, // Set the page direction to RTL
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                                " تفاصيل المنتج ",
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Cairo',
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        )),
                  ),

                  // Big image for the item (half of the screen)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      item['image']!, // Item image
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height *
                          0.4, // 40% of the screen height
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Item name
                  Text(
                    item['name']!,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Cairo',
                    ),
                    textAlign: TextAlign.right,
                  ),
                  const SizedBox(height: 8),

                  // Item price
                  Text(
                    '${item['price']} د.ع  / الدرزن', // Price for 12 items
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                      fontFamily: 'Cairo',
                    ),
                    textAlign: TextAlign.right,
                  ),
                  const SizedBox(height: 8),

                  // Item category
                  Text(
                    'الفئة: ${item['category']}',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                      fontFamily: 'Cairo',
                    ),
                    textAlign: TextAlign.right,
                  ),
                  const SizedBox(height: 16),

                  // Item details
                  Text(
                    'تفاصيل المنتج:\n\n${item['details']}',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontFamily: 'Cairo',
                    ),
                    textAlign: TextAlign.right,
                  ),
                  SizedBox(
                    height: ScreenSize.height * 0.15,
                  ),

                  // Add to Cart button
                  Center(
                    child: Container(
                      width: ScreenSize.width * 0.99,
                      height: ScreenSize.height * 0.07,
                      color: Colors.transparent,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                            side: BorderSide(color: Colors.transparent, width: 1.0),
                          ),
                        ),
                        onPressed: () async {},
                         icon: Icon(
                          HeroIcons.shopping_cart,
                          color: Colors.white,
                        ),
                        label: Text(
                          '    اضف الى السلة ',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Cairo',
                            color: Colors.white,
                          ),
                        ),
                       
                      ),
                    ),
                  ),
                  const SizedBox(height: 40), // Add some space at the bottom
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
