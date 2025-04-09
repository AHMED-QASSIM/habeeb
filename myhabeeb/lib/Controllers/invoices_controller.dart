import 'package:get/get.dart';
import 'package:myhabeeb/Models/invoices_model.dart';
import 'package:myhabeeb/Services/invoices_service.dart';

class InvoiceController extends GetxController {
  final InvoiceService _invoiceService = InvoiceService();

  var pendingInvoices = <InvoiceModel>[].obs;
  var processedInvoices = <InvoiceModel>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    fetchInvoices();
    super.onInit();
  }

  Future<void> fetchInvoices() async {
    try {
      isLoading.value = true;
      final pending = await _invoiceService.getInvoicesByStatus("pending");
      final accepted = await _invoiceService.getInvoicesByStatus("accepted");
      final rejected = await _invoiceService.getInvoicesByStatus("rejected");

      pendingInvoices.assignAll(pending);
      processedInvoices.assignAll([...accepted, ...rejected]);
    } catch (e) {
      print('Error in controller: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
