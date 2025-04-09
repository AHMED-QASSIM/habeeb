// ignore_for_file: prefer_const_constructors

import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:myhabeeb/Controllers/customer_controller.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class Customerspage extends StatefulWidget {
  const Customerspage({super.key});

  @override
  State<Customerspage> createState() => _CustomerspageState();
}

class _CustomerspageState extends State<Customerspage> {
  final customersController customersconroller =
      Get.find<customersController>();
  RefreshController _refreshController = RefreshController(
    initialRefresh: false,
  );
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SmartRefresher(
        enablePullDown: true,

        enablePullUp: false,
        controller: _refreshController,
        onRefresh: () async {
          await Future.delayed(Duration(milliseconds: 1000));
          customersconroller.refreshCustomers();

          _refreshController.refreshCompleted();
        },
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,

            child: SafeArea(
              child: Directionality(
                textDirection: TextDirection.rtl, // RTL layout

                child: Column(
                  children: [
                    SizedBox(height: 10),
                    Text(
                      "الزبائن",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue[900],
                        fontFamily: 'Cairo',
                      ),
                    ),
                    //SizedBox(height: 5),
                    Container(
                      padding: const EdgeInsets.all(2.0),
                      color: Colors.white,
                      height: screenHeight * 0.8,
                      width: screenWidth,
                      child: ContainedTabBarView(
                        tabBarProperties: TabBarProperties(
                          background: Container(color: Colors.white),
                          indicatorSize: TabBarIndicatorSize.tab,
                          indicatorColor: Colors.blue[900],

                          unselectedLabelColor: Colors.grey[400],
                        ),
                        tabs: [
                          Text(
                            'طلبات التسجيل ',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue[900],
                              fontFamily: 'Cairo',
                            ),
                          ),
                          Text(
                            ' الزبائن الحاليين ',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue[900],
                              fontFamily: 'Cairo',
                            ),
                          ),
                        ],
                        views: [
                          Container(
                            color: Colors.white,

                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SingleChildScrollView(
                                  child: Obx(() {
                                    if (customersconroller
                                        .pendingCustomers
                                        .isEmpty) {
                                      return Center(
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                            top: 2.0,
                                          ),
                                          child: Container(
                                            height: screenHeight * 0.72,
                                            width: screenWidth,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(
                                                  30.0,
                                                ), // Top-left radius
                                                topRight: Radius.circular(
                                                  30.0,
                                                ), // Top-right radius
                                              ),
                                            ),
                                            child: Center(
                                              child: Text(
                                                'لا يوجد زبائن ',
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: 'Cairo',
                                                  color: Colors.blue[900],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    }
                                    return SingleChildScrollView(
                                      child: Container(
                                        height: screenHeight * 0.7,
                                        width: screenWidth,
                                        child: ListView.builder(
                                          itemCount:
                                              customersconroller
                                                  .pendingCustomers
                                                  .length,
                                          itemBuilder: (context, index) {
                                            final customer =
                                                customersconroller
                                                    .pendingCustomers[index];
                                            return Container(
                                              margin: EdgeInsets.all(5),
                                              height: screenHeight * 0.3,
                                              child: Card(
                                                color:
                                                    Colors
                                                        .white, // Light custom background color
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                        10.0,
                                                      ),
                                                  side: BorderSide(
                                                    color:
                                                        Colors
                                                            .transparent, // Custom border color
                                                    width: 1.5,
                                                  ),
                                                ),

                                                elevation: 5,
                                                shadowColor: Colors.grey[300],
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                    4.0,
                                                  ),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets.all(
                                                                      4.0,
                                                                    ),
                                                                child: Text(
                                                                  customer
                                                                      .shopName,
                                                                  style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        14,
                                                                    fontFamily:
                                                                        'Cairo',
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),

                                                          CircleAvatar(
                                                            backgroundImage:
                                                                NetworkImage(
                                                                  customer
                                                                      .imageUrl,
                                                                ), // Change this to NetworkImage or File if needed
                                                            radius: 30,
                                                          ),
                                                        ],
                                                      ),
                                                      Divider(
                                                        color: Colors.grey[300],
                                                        thickness: 1,
                                                      ),
                                                      SizedBox(
                                                        height:
                                                            screenHeight * 0.01,
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                            "اسم الزبون: ",
                                                            style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              fontSize: 12,
                                                              fontFamily:
                                                                  'Cairo',
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                          ),
                                                          Text(
                                                            customer.name,
                                                            style: TextStyle(
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  Colors
                                                                      .blue[900],
                                                              fontFamily:
                                                                  'Cairo',

                                                              // Or any color you prefer
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height:
                                                            screenHeight * 0.01,
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                            "العنوان: ",
                                                            style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              fontSize: 12,
                                                              fontFamily:
                                                                  'Cairo',
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                          ),
                                                          Text(
                                                            customer.address,
                                                            style: TextStyle(
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  Colors
                                                                      .blue[900],
                                                              fontFamily:
                                                                  'Cairo',

                                                              // Or any color you prefer
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height:
                                                            screenHeight * 0.01,
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                            "رقم الهاتف: ",
                                                            style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              fontSize: 12,
                                                              fontFamily:
                                                                  'Cairo',
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                          ),
                                                          Text(
                                                            customer
                                                                .phoneNumber,
                                                            style: TextStyle(
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  Colors
                                                                      .blue[900],
                                                              fontFamily:
                                                                  'Cairo',

                                                              // Or any color you prefer
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height:
                                                            screenHeight * 0.03,
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        children: [
                                                          Container(
                                                            width:
                                                                screenWidth *
                                                                0.45,
                                                            height:
                                                                screenHeight *
                                                                0.04,
                                                            child: ElevatedButton(
                                                              onPressed: () {
                                                                // Accept action
                                                              },
                                                              style: ElevatedButton.styleFrom(
                                                                backgroundColor:
                                                                    Colors
                                                                        .green,
                                                                shape: RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius.circular(
                                                                        10,
                                                                      ),
                                                                ),
                                                              ),
                                                              child: Text(
                                                                'قبول',
                                                                style: TextStyle(
                                                                  fontFamily:
                                                                      'Cairo',
                                                                  color:
                                                                      Colors
                                                                          .white,
                                                                  fontSize: 16,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          Container(
                                                            width:
                                                                screenWidth *
                                                                0.45,
                                                            height:
                                                                screenHeight *
                                                                0.04,
                                                            child: ElevatedButton(
                                                              onPressed: () {
                                                                // Reject action
                                                              },
                                                              style: ElevatedButton.styleFrom(
                                                                backgroundColor:
                                                                    Colors.red,
                                                                shape: RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius.circular(
                                                                        10,
                                                                      ),
                                                                ),
                                                              ),
                                                              child: Text(
                                                                'رفض',
                                                                style: TextStyle(
                                                                  fontFamily:
                                                                      'Cairo',
                                                                  color:
                                                                      Colors
                                                                          .white,
                                                                  fontSize: 16,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    );
                                  }),
                                ),
                              ],
                            ),
                          ),

                          Container(
                            color: Colors.white,

                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SingleChildScrollView(
                                  child: Obx(() {
                                    if (customersconroller
                                        .activeCustomers
                                        .isEmpty) {
                                      return Center(
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                            top: 2.0,
                                          ),
                                          child: Container(
                                            height: screenHeight * 0.72,
                                            width: screenWidth,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(
                                                  30.0,
                                                ), // Top-left radius
                                                topRight: Radius.circular(
                                                  30.0,
                                                ), // Top-right radius
                                              ),
                                            ),
                                            child: Center(
                                              child: Text(
                                                'لا يوجد زبائن ',
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: 'Cairo',
                                                  color: Colors.blue[900],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    }
                                    return SingleChildScrollView(
                                      child: Container(
                                        height: screenHeight * 0.7,
                                        width: screenWidth,
                                        child: ListView.builder(
                                          itemCount:
                                              customersconroller
                                                  .pendingCustomers
                                                  .length,
                                          itemBuilder: (context, index) {
                                            final customer =
                                                customersconroller
                                                    .pendingCustomers[index];
                                            return Container(
                                              margin: EdgeInsets.all(5),
                                              height: screenHeight * 0.3,
                                              child: Card(
                                                color:
                                                    Colors
                                                        .white, // Light custom background color
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                        10.0,
                                                      ),
                                                  side: BorderSide(
                                                    color:
                                                        Colors
                                                            .transparent, // Custom border color
                                                    width: 1.5,
                                                  ),
                                                ),

                                                elevation: 5,
                                                shadowColor: Colors.grey[300],
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                    4.0,
                                                  ),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets.all(
                                                                      4.0,
                                                                    ),
                                                                child: Text(
                                                                  customer
                                                                      .shopName,
                                                                  style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        14,
                                                                    fontFamily:
                                                                        'Cairo',
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),

                                                          CircleAvatar(
                                                            backgroundImage:
                                                                NetworkImage(
                                                                  customer
                                                                      .imageUrl,
                                                                ), // Change this to NetworkImage or File if needed
                                                            radius: 30,
                                                          ),
                                                        ],
                                                      ),
                                                      Divider(
                                                        color: Colors.grey[300],
                                                        thickness: 1,
                                                      ),
                                                      SizedBox(
                                                        height:
                                                            screenHeight * 0.01,
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                            "اسم الزبون: ",
                                                            style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              fontSize: 12,
                                                              fontFamily:
                                                                  'Cairo',
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                          ),
                                                          Text(
                                                            customer.name,
                                                            style: TextStyle(
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  Colors
                                                                      .blue[900],
                                                              fontFamily:
                                                                  'Cairo',

                                                              // Or any color you prefer
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height:
                                                            screenHeight * 0.01,
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                            "العنوان: ",
                                                            style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              fontSize: 12,
                                                              fontFamily:
                                                                  'Cairo',
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                          ),
                                                          Text(
                                                            customer.address,
                                                            style: TextStyle(
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  Colors
                                                                      .blue[900],
                                                              fontFamily:
                                                                  'Cairo',

                                                              // Or any color you prefer
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height:
                                                            screenHeight * 0.01,
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                            "رقم الهاتف: ",
                                                            style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              fontSize: 12,
                                                              fontFamily:
                                                                  'Cairo',
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                          ),
                                                          Text(
                                                            customer
                                                                .phoneNumber,
                                                            style: TextStyle(
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  Colors
                                                                      .blue[900],
                                                              fontFamily:
                                                                  'Cairo',

                                                              // Or any color you prefer
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height:
                                                            screenHeight * 0.03,
                                                      ),
                                                      Container(
                                                        width:
                                                            screenWidth * 0.90,
                                                        height:
                                                            screenHeight * 0.04,
                                                        child: ElevatedButton(
                                                          onPressed: () {
                                                            showDialog(
                                                              context: context,
                                                              builder:
                                                                  (
                                                                    context,
                                                                  ) => Directionality(
                                                                    textDirection:
                                                                        TextDirection
                                                                            .rtl,
                                                                    child: AlertDialog(
                                                                      backgroundColor: Colors.white,
                                                                      title: Text(
                                                                        'تأكيد الحذف',
                                                                        style: TextStyle(
                                                                          fontFamily:
                                                                              'Cairo',
                                                                        ),
                                                                      ),
                                                                      content: Text(
                                                                        'هل أنت متأكد من حذف الزبون؟',
                                                                        style: TextStyle(
                                                                          fontFamily:
                                                                              'Cairo',
                                                                        ),
                                                                      ),
                                                                      actions: [
                                                                        TextButton(
                                                                          onPressed:
                                                                              () => Navigator.pop(
                                                                                context,
                                                                              ), // Close dialog
                                                                          child: Text(
                                                                            'إلغاء',
                                                                            style: TextStyle(
                                                                              fontFamily:
                                                                                  'Cairo',
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        TextButton(
                                                                          onPressed: () {
                                                                            // Call your delete function here
                                                                            Navigator.pop(
                                                                              context,
                                                                            ); // Close dialog after deletion
                                                                          },
                                                                          child: Text(
                                                                            'حذف',
                                                                            style: TextStyle(
                                                                              color:
                                                                                  Colors.red,
                                                                              fontFamily:
                                                                                  'Cairo',
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                            );
                                                          },
                                                          style: ElevatedButton.styleFrom(
                                                            backgroundColor:
                                                                Colors.red,
                                                            shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius.circular(
                                                                    10,
                                                                  ),
                                                            ),
                                                          ),
                                                          child: Text(
                                                            'حذف الزبون',
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'Cairo',
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 16,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    );
                                  }),
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
          ),
        ),
      ),
    );
  }
}
