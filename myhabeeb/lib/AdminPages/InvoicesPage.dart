// ignore_for_file: dead_code

import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:myhabeeb/Controllers/invoices_controller.dart';
import 'package:myhabeeb/Models/invoices_model.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class Invoices extends StatefulWidget {
  const Invoices({super.key});

  @override
  State<Invoices> createState() => _InvoicesState();
}

class _InvoicesState extends State<Invoices> {
  final InvoiceController invoiceController = Get.put(InvoiceController());

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
          invoiceController.fetchInvoices();

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
                      "الفواتير",
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
                            '  الغير مجهزة',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue[900],
                              fontFamily: 'Cairo',
                            ),
                          ),
                          Text(
                            '  المجهزة',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue[900],
                              fontFamily: 'Cairo',
                            ),
                          ),
                        ],
                        views: [
                          Obx(() {
                            if (invoiceController.isLoading.value) {
                              return Center(child: CircularProgressIndicator());
                            }

                            if (invoiceController.pendingInvoices.isEmpty) {
                              return Center(
                                child: Text("لا توجد فواتير غير مجهزة"),
                              );
                            }

                            return ListView.builder(
                              itemCount:
                                  invoiceController.pendingInvoices.length,
                              itemBuilder: (context, index) {
                                final invoice =
                                    invoiceController.pendingInvoices[index];
                                return buildInvoiceCard(
                                  invoice,
                                ); // We'll define this below
                              },
                            );
                          }),
                          Obx(() {
                            if (invoiceController.isLoading.value) {
                              return Center(child: CircularProgressIndicator());
                            }

                            if (invoiceController.processedInvoices.isEmpty) {
                              return Center(
                                child: Text("لا توجد فواتير مجهزة أو مرفوضة"),
                              );
                            }

                            return ListView.builder(
                              itemCount:
                                  invoiceController.processedInvoices.length,
                              itemBuilder: (context, index) {
                                final invoice =
                                    invoiceController.processedInvoices[index];
                                return buildInvoiceCard(invoice);
                              },
                            );
                          }),
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

Widget buildInvoiceCard(InvoiceModel invoice) {
  return Container(
    margin: EdgeInsets.all(5),
    height: 180,
    child: Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      elevation: 5,
      shadowColor: Colors.grey[300],
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  invoice.customerShopName ?? '',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    fontFamily: 'Cairo',
                  ),
                ),
               Text(
      DateFormat('dd/MM/yyyy  EEEE', 'ar')
          .format(invoice.invoiceDate), // Ensure the format uses Arabic locale
      style: TextStyle(fontSize: 12),
        ),
              ],
            ),
            Divider(color: Colors.grey[400], thickness: 0.5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  invoice.customerName ?? '',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    fontFamily: 'Cairo',
                  ),
                ),
                CircleAvatar(
                  backgroundImage: AssetImage('assets/images/profile.jpg'),
                  radius: 30,
                ),
              ],
            ),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "مبلغ الفاتورة : ",
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'Cairo',
                    color: Colors.black,
                  ),
                ),
                Text(
                  "${invoice.totalInvoicePrice.toString()} د.ع",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[900],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
