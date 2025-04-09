import 'dart:io';
import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myhabeeb/AdminPages/admintemsPage.dart';
import 'package:myhabeeb/Controllers/Category_controller.dart';
import 'package:myhabeeb/helpers/addcategorydetails.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:quickalert/quickalert.dart';
class CategoryPage extends StatefulWidget {
  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  final CategoryController carcategorycontroller = Get.put(
    CategoryController(),
  );
  final CategoryController toyscategorycontroller = Get.put(
    CategoryController(),
  );
  RefreshController _refreshController = RefreshController(
    initialRefresh: false,
  );

  void initState() {
    super.initState();
    // Fetch categories when the widget is initialized
    toyscategorycontroller.fetchToysCategories("ToysCategory");

    carcategorycontroller.fetchCarCategories("CarsCategory");
  }

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
          toyscategorycontroller.fetchToysCategories("ToysCategory");

          carcategorycontroller.fetchCarCategories("CarsCategory");
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
                      "الاقسام",
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
                            ' الالعاب',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue[900],
                              fontFamily: 'Cairo',
                            ),
                          ),
                          Text(
                            'السيارات',
                            style: TextStyle(
                              fontSize: 18,
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
                                  child: Container(
                                    height: screenHeight * 0.65,
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
                                    child: Obx(() {
                                      if (toyscategorycontroller
                                          .isLoading
                                          .value) {
                                        return Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      } else if (toyscategorycontroller
                                          .TOYScategories
                                          .isEmpty) {
                                        return Padding(
                                          padding: const EdgeInsets.only(
                                            top: 2.0,
                                          ),
                                          child: Container(
                                            height: screenHeight * 0.45,
                                            child: Center(
                                              child: Text(
                                                ' لا  يوجد اقسام',
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: 'Cairo',
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      } else {
                                        return ListView.builder(
                                          itemCount:
                                              toyscategorycontroller
                                                  .TOYScategories
                                                  .length,
                                          itemBuilder: (context, index) {
                                            final toyscategory =
                                                toyscategorycontroller
                                                    .TOYScategories[index];
                                            return GestureDetector(
                                              onTap: () {
                                                Get.to(
                                                  () => AdminItemsPage(

                                                    categoryName:
                                                        toyscategory.name,
                                                    categoryId: 
                                                        toyscategory.id!,
                                                    collection: "ToysCategory",
                                                 
                                                  ),
                                                );
                                              },
                                              child: Container(
                                                height: screenHeight * 0.1,
                                                width: screenWidth,
                                              
                                                margin: EdgeInsets.symmetric(
                                                  vertical: 2,
                                                  horizontal: 2,
                                                ),
                                                child: Card(
                                                  color: Colors.white,
                                                  elevation: 1,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(1),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.symmetric(
                                                          horizontal: 12.0,
                                                          vertical: 8.0,
                                                        ),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        // Category Name and Item Count
                                                        Expanded(
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Text(
                                                                toyscategory.name,
                                                                style: TextStyle(
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color:
                                                                      Colors
                                                                          .black,
                                                                  fontFamily:
                                                                      'Tajawal',
                                                                ),
                                                              ),
                                                              SizedBox(height: 4),
                                                              Text(
                                                                '${toyscategory.itemCount} ايتم',
                                                                style: TextStyle(
                                                                  fontSize: 12,
                                                                  color:
                                                                      Colors
                                                                          .black,
                                                                  fontFamily:
                                                                      'Tajawal',
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        SizedBox(width: 12),
                                                        // Category Image
                                                        Image.network(
                                                          toyscategory.image,
                                                          width:
                                                              screenWidth * 0.25,
                                                          height:
                                                              screenHeight * 0.12,
                                                          fit: BoxFit.contain,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                      }
                                    }),
                                  ),
                                ),

                                Center(
                                  child: Container(
                                    width: screenWidth * 0.9,
                                    height: screenHeight * 0.06,
                                    color: Colors.transparent,
                                    child: ElevatedButton.icon(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.blue[100],
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            5,
                                          ),
                                          side: BorderSide(
                                            color: Colors.blue,
                                            width: 1.0,
                                          ),
                                        ),
                                      ),
                                      onPressed: () async {
                                        Get.dialog(
                                          CategoryDialog(
                                            collection: "ToysCategory",
                                          ),
                                        ).then((_) {
                                          toyscategorycontroller
                                              .fetchToysCategories(
                                                "ToysCategory",
                                              );
                                        });
                                      },
                                      label: Text(
                                        ' اضافة قسم جديد    ',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Cairo',
                                          color: Colors.blue[900],
                                        ),
                                      ),
                                      icon: Icon(
                                        Icons.logout,
                                        color: Colors.blue[900],
                                      ),
                                    ),
                                  ),
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
                                  child: Container(
                                    height: screenHeight * 0.65,
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
                                    child: Obx(() {
                                      if (carcategorycontroller
                                          .isLoading
                                          .value) {
                                        return Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      } else if (carcategorycontroller
                                          .CARScategories
                                          .isEmpty) {
                                        return Padding(
                                          padding: const EdgeInsets.only(
                                            top: 2.0,
                                          ),
                                          child: Container(
                                            height: screenHeight * 0.45,
                                            child: Center(
                                              child: Text(
                                                ' لا  يوجد اقسام',
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: 'Cairo',
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      } else {
                                        return ListView.builder(
                                          itemCount:
                                              carcategorycontroller
                                                  .CARScategories
                                                  .length,
                                          itemBuilder: (context, index) {
                                            final CARcategory =
                                                carcategorycontroller
                                                    .CARScategories[index];
                                            return GestureDetector(
                                              onTap: () {
                                                Get.to(
                                                  () => AdminItemsPage(

                                                    categoryName:
                                                        CARcategory.name,
                                                    categoryId: 
                                                        CARcategory.id!,
                                                    collection: "CarsCategory",
                                                 
                                                  ),
                                                );
                                              },
                                              child: Container(
                                                height: screenHeight * 0.1,
                                                width: screenWidth,
                                              
                                                margin: EdgeInsets.symmetric(
                                                  vertical: 2,
                                                  horizontal: 2,
                                                ),
                                                child: Card(
                                                  color: Colors.white,
                                                  elevation: 1,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(1),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.symmetric(
                                                          horizontal: 12.0,
                                                          vertical: 8.0,
                                                        ),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        // Category Name and Item Count
                                                        Expanded(
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Text(
                                                                CARcategory.name,
                                                                style: TextStyle(
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color:
                                                                      Colors
                                                                          .black,
                                                                  fontFamily:
                                                                      'Tajawal',
                                                                ),
                                                              ),
                                                              SizedBox(height: 4),
                                                              Text(
                                                                '${CARcategory.itemCount} ايتم',
                                                                style: TextStyle(
                                                                  fontSize: 12,
                                                                  color:
                                                                      Colors
                                                                          .black,
                                                                  fontFamily:
                                                                      'Tajawal',
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        SizedBox(width: 12),
                                                        // Category Image
                                                        Image.network(
                                                          CARcategory.image,
                                                          width:
                                                              screenWidth * 0.25,
                                                          height:
                                                              screenHeight * 0.12,
                                                          fit: BoxFit.contain,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                      }
                                    }),
                                  ),
                                ),

                                Center(
                                  child: Container(
                                    width: screenWidth * 0.9,
                                    height: screenHeight * 0.06,
                                    color: Colors.transparent,
                                    child: ElevatedButton.icon(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.blue[100],
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            5,
                                          ),
                                          side: BorderSide(
                                            color: Colors.blue,
                                            width: 1.0,
                                          ),
                                        ),
                                      ),
                                      onPressed: () async {
                                        Get.dialog(
                                          CategoryDialog(
                                            collection: "CarsCategory",
                                          ),
                                        ).then((_) {
                                          
                                          carcategorycontroller
                                              .fetchCarCategories(
                                                "CarsCategory",

                                              );
                                        });
                                      },
                                      label: Text(
                                        ' اضافة قسم جديد    ',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Cairo',
                                          color: Colors.blue[900],
                                        ),
                                      ),
                                      icon: Icon(
                                        Icons.logout,
                                        color: Colors.blue[900],
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
