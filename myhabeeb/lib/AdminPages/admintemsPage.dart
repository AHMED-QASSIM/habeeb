// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myhabeeb/Controllers/item_controller.dart';
import 'package:myhabeeb/Styles/theme.dart';
import 'package:myhabeeb/UserPages/itemdetails.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class AdminItemsPage extends StatefulWidget {
  final String categoryName;
  final String categoryId;
  final String collection;


  AdminItemsPage({
    required this.categoryName,
    required this.categoryId,
    required this.collection,
  });

  @override
  State<AdminItemsPage> createState() => _AdminItemsPageState();
}

class _AdminItemsPageState extends State<AdminItemsPage> {
  final ItemController itemController = Get.put(ItemController());
final SearchController controller = Get.put(SearchController());

  final RefreshController _refreshController = RefreshController(
    initialRefresh: false,
  );

  @override
  void initState() {
    super.initState();
    itemController.fetchItems(widget.categoryId, widget.collection, widget.categoryName);
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SmartRefresher(
        enablePullDown: true,
        controller: _refreshController,
        onRefresh: () async {
          await Future.delayed(Duration(milliseconds: 1000));
          itemController.fetchItems(widget.categoryId, widget.collection, widget.categoryName);

          _refreshController.refreshCompleted();
        },
        child: SafeArea(
          child: Directionality(
            textDirection: TextDirection.rtl, // Set the page direction to RTL
            child: Container(
              color: Colors.grey[50],
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 12.0, right: 12),
                    child: Container(
                      color: Colors.transparent,
                      height: screenHeight * 0.1,
                      width: screenWidth,
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(
                              Icons.arrow_back,
                              size: 40,
                              color: Colors.blue[900],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 2.0),
                            child: Text(
                              widget.categoryName,
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Cairo',
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  
                  Container(
                    height: screenHeight * 0.85,
                    width: screenWidth,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Obx(() {
                        if (itemController.isLoading.value) {
                          return Center(child: CircularProgressIndicator());
                        } else if (itemController.Items.isEmpty) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 2.0),
                            child: Center(
                              child: Text(
                                ' لا  يوجد منتجات في هذا القسم',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Cairo',
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          );
                        } else {
                          return GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2, // items per row
                              crossAxisSpacing: 2.0,
                              mainAxisSpacing: 2.0,
                              childAspectRatio: 0.8, // Adjust the height/width ratio of each card
                            ),
                            itemCount: itemController.Items.length,
                            itemBuilder: (context, index) {
                              final item = itemController.Items[index];
                              String formattedPrice = formatNumberWithCommas(
                                item.price,
                              );

                              return GestureDetector(
                                onTap: () {
                                  // Uncomment and navigate to item details page
                                 // Get.to(() => ItemDetailsPage(itemIndex: index));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                        color: Colors.grey[300]!,
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(5.0),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.2),
                                          spreadRadius: 1,
                                          blurRadius: 5,
                                          offset: Offset(0, 3), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Image.network(
                                          item.imageUrl, // Image URL from the item object
                                          height: screenHeight * 0.13, // Adjust height of image
                                          fit: BoxFit.cover,
                                        ),
                                        Divider(
                                          color: Colors.grey[300],
                                          thickness: 1,
                                        ),
                                        Text(
                                          item.name, // Item name
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                        SizedBox(height: 4),
                                        Text(
                                          formattedPrice, // Item price
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.blue[900],
                                            fontFamily: 'Cairo',
                                          ),
                                        ),
                                      ],
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}


String formatNumberWithCommas(double number) {
  // Convert the number to a string
  String numberString = number.toStringAsFixed(0); // No decimal part

  // Reverse the string to make it easier to insert commas every 3 digits
  String reversed = numberString.split('').reversed.join();

  // Add commas every 3 characters
  String withCommas = '';
  for (int i = 0; i < reversed.length; i++) {
    if (i > 0 && i % 3 == 0) {
      withCommas += ',';
    }
    withCommas += reversed[i];
  }

  // Reverse the string back to the original order
  String formattedNumber = withCommas.split('').reversed.join();

  // Add "IQD" to the formatted number
  return '$formattedNumber IQD';
}
