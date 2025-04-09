// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class Notifiactions extends StatefulWidget {
  const Notifiactions({super.key});

  @override
  State<Notifiactions> createState() => _NotifiactionsState();
}

class _NotifiactionsState extends State<Notifiactions> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blue[900],

        body: Directionality(
          textDirection: TextDirection.rtl,
          child: Column(
            children: [

                  Container(
                    decoration: BoxDecoration(
                      color: Colors.blue[900],
                      borderRadius: BorderRadius.only(
                       
                      ),
                    ),
                       height: screenHeight * 0.1,
                      width: screenWidth,

                    child:   Center(
                          child: Text(
                            "الاشعارات",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontFamily: 'Cairo',
                            ),
                          ),
                        ),
                  ),



              Container(
 decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
              ),
            ),            child: Column(
              children: [
                Container(
                  height: screenHeight * 0.38,
                  width: screenWidth,
            
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                      
                        SizedBox(height: 10),
                        Text(
                          '  ادخل العنوان ',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontFamily: 'Tajawal',
                          ),
                        ),
                        Container(
                          width: screenWidth * 0.99,
                          height: screenHeight * 0.05,
                          padding: EdgeInsets.symmetric(horizontal: 1),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                              color: Colors.grey,
                              width: 1,
                            ),

                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 15,
                              vertical: 10,
                            ),
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: "  ",
                                hintStyle: TextStyle(
                                  fontFamily: 'Tajawal',
                                  color: Colors.grey,
                                ),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          ' ادخل النص ',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontFamily: 'Tajawal',
                          ),
                        ),
                        Container(
                          width: screenWidth * 0.99,
                          height: screenHeight * 0.12,
                          padding: EdgeInsets.symmetric(horizontal: 1),
                             decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                              color: Colors.grey,
                              width: 1,
                            ),
                            
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 15,
                              vertical: 10,
                            ),
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: "  ",
                                hintStyle: TextStyle(
                                  fontFamily: 'Tajawal',
                                  color: Colors.grey,
                                ),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 25),
                        Center(
                          child: Container(
                            width: screenWidth * 0.9,
                            height: screenHeight * 0.06,
                            color: Colors.transparent,
                            child: ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue[900],
            
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  side: BorderSide(
                                    color: Colors.transparent,
                                    width: 1.0,
                                  ),
                                ),
                              ),
                              onPressed: () async {},
                              label: Text(
                                ' ارسال الاشعار',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Cairo',
                                  color: Colors.white,
                                ),
                              ),
                              icon: Icon(Icons.send, color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Divider(color: Colors.black, thickness: 1),
                Container(
                  height: screenHeight * 0.365,
                  width: screenWidth,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
            
                    children: [
                      Center(
                        child: Text(
                          "الاشعارات السابقة",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontFamily: 'Cairo',
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Expanded(
                        child: ListView.builder(
                          itemCount: 5,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: screenWidth * 0.99,
                                height: screenHeight * 0.1,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                    color: Colors.grey,
                                    width: 1,
                                  ),
                                ),
                                child: ListTile(
                                  title: Text(
                                    'عنوان الاشعار $index',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      fontFamily: 'Cairo',
                                    ),
                                  ),
                                  subtitle: Text(
                                    'نص الاشعار $index',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.black54,
                                      fontFamily: 'Cairo',
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
            ],
          ),
        ),
      ),
    );
  }
}
