// ignore_for_file: prefer_const_constructors


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io';

import 'package:myhabeeb/Models/customer_model.dart';
import 'package:myhabeeb/Services/customer_services.dart';
import 'package:myhabeeb/helpers/snackbar.dart';

class customersController extends GetxController {

  final customersService _CustomerService = customersService();
  final customersService CustomerService = customersService();


  var isLoading = false.obs;
  var customers = <CustomerModel>[].obs;
  var customer = Rxn<CustomerModel>(); // Assuming Manager is your model class

 var activeCustomers = <CustomerModel>[].obs;
  var pendingCustomers = <CustomerModel>[].obs;


  @override
  void onInit() {
    fetchCustomers();

    super.onInit();
  }



  Future<void> fetchCustomers() async {
    isLoading.value = true;
    activeCustomers.value = await _CustomerService.getCustomersByStatus(true);
    pendingCustomers.value = await _CustomerService.getCustomersByStatus(false);
    isLoading.value = false;
  }

  Future<void> refreshCustomers() async {
    await fetchCustomers();
  }

  Future<void> addCustomer(CustomerModel customer, File? imageFile) async {
    isLoading.value = true;

    try {
      if (imageFile != null) {
        String? imageUrl =
            await _CustomerService.uploadImage(imageFile, customer.id);
        if (imageUrl != null) {
          customer.imageUrl = imageUrl;
        }
      }

      await _CustomerService.addcustomer(customer);
      customers.add(customer);
      Get.back(); // Go back to the previous screen
     showStyledSnackbar(
      title: "نجاح",
      message: "تم إضافة الحساب بنجاح",
      backgroundColor: Colors.green,
      icon: Icons.check_circle,
    );
    } catch (e) {
      print(e);
    } finally {
      isLoading.value = false;
    }
  }
}
