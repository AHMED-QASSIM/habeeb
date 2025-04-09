

import 'package:get/get.dart';
import 'package:myhabeeb/Controllers/customer_controller.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {

Get.put(customersController());
   
  }
}
