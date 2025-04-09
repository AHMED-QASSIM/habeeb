import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myhabeeb/Models/invoices_model.dart';

class InvoiceService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<InvoiceModel>> getInvoicesByStatus(String status) async {
    try {
      print('tttttest');
      print(status);

      final querySnapshot =
          await _firestore
              .collection('invoices')
              .where('status', isEqualTo: status)
              .get();

      return querySnapshot.docs
          .map((doc) {
            try {
              return InvoiceModel.fromFirestore(doc);
            } catch (e) {
              print('Error mapping doc: $e');
              return null;
            }
          })
          .where((invoice) => invoice != null)
          .cast<InvoiceModel>()
          .toList();
          

        
    } catch (e) {
      print('Error fetching invoices by status: $e');
      return [];
    }
  }

  // Optional: Add other service methods (e.g. addInvoice, deleteInvoice) here
}
