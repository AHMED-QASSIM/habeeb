// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:myhabeeb/Styles/theme.dart';
import 'package:icons_plus/icons_plus.dart';

class ShopProfilePage extends StatelessWidget {
  // Sample shop data
  final Map<String, dynamic> shop = {
    'shopName': 'الحبيب لتجارة لعب الاطفال والهدايا ', // Shop name in Arabic
    'shopName2': ' (شركة تاج المحيط)', // Shop name in Arabic
    'shopImage': 'assets/images/shop3.jpeg', // Shop image path
    'address': 'بغداد شارع الرشيد - بناية المصطفى ', // Shop address in Arabic
    'phoneNumber': ' 986 6543 0770 ',
    'phoneNumber2': ' 987 6543 0770 ', // Shop phone number
    'category': 'بيع جملة فقط', // Shop category (what it sells)
     'website': 'tajalmahat.com.iq ', 
  };

  // Function to launch WhatsApp
  // _launchWhatsApp(String phoneNumber) async {
  //   final url = 'https://wa.me/$phoneNumber'; // WhatsApp link
  //   if (await canLaunch(url)) {
  //     await launch(url); // Launch the WhatsApp link
  //   } else {
  //     throw 'Could not open WhatsApp';
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          color: Colors.white,
          height: ScreenSize.height,
          child: Directionality(
            textDirection: TextDirection.rtl, // Set page to RTL for Arabic
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: ScreenSize.height * 0.04,
                  ),
                  Text(
                    shop['shopName']!,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Cairo',
                    ),
                    textAlign: TextAlign.right,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 70.0),
                    child: Text(
                      shop['shopName2']!,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Cairo',
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 8),

                  // Shop Image
                  Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        shop['shopImage'],
                        width: double.infinity,
                        height: 250,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(height: 16),

                  // Shop Name

                  // Shop Category
                  Text(
                    ' ${shop['category']}',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey[600],
                      fontFamily: 'Cairo',
                    ),
                    textAlign: TextAlign.right,
                  ),
                  SizedBox(height: 16),

                  // Shop Address
                  Text(
                'العنوان: ${shop['address']}',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontFamily: 'Cairo',
                    ),
                    textAlign: TextAlign.right,
                  ),
                  SizedBox(height: 16),

                  // Shop Phone Number
                  Text(
                    'رقم الهاتف: ${shop['phoneNumber']}',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontFamily: 'Cairo',
                    ),
                    textAlign: TextAlign.right,
                  ),
                  Text(
                    'رقم الهاتف: ${shop['phoneNumber2']}',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontFamily: 'Cairo',
                    ),
                    textAlign: TextAlign.right,
                  ),
                    Text(
                    'الموقع الالكتروني : ${shop['website']}',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontFamily: 'Cairo',
                    ),
                    textAlign: TextAlign.right,
                  ),
   SizedBox(
                    height: ScreenSize.height * 0.1,
                  ),

                  // WhatsApp Contact Button
                  Center(
                    child: Container(
                                            width: ScreenSize.width * 0.99,
                      height: ScreenSize.height * 0.07,
                      color: Colors.transparent,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          //   _launchWhatsApp(shop['phoneNumber']!); // Launch WhatsApp
                        },
                        icon: Icon(Iconsax.whatsapp_bold,
                            color: Colors.white), // WhatsApp icon
                        label: Text(
                          'تواصل معنا  عبر واتساب',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontFamily: 'Cairo',
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          padding:
                              EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
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
