import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myhabeeb/Models/item_model.dart';
class ItemService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addItem(
    ItemModel item,
    String category,
    String subCategory,
    String id,
  ) async {
    try {
      print(
        "Adding item: ${item.name} to category: $category, subcategory: $subCategory",
      );

      DocumentReference docRef = _firestore
          .collection('Categories')
          .doc('U6VWQKmnDWPF2NnH3fiQ') // Main category document
          .collection(category) // Subcategory collection
          .doc(id)
          .collection('items')
          .doc(); // Auto-generate unique ID

      item.id = docRef.id;

      await docRef.set(item.toMap());

      // Increment the itemCount field in the parent document
      await _firestore
          .collection('Categories')
          .doc('U6VWQKmnDWPF2NnH3fiQ')
          .collection(category)
          .doc(id)
          .update({
        'itemCount': FieldValue.increment(1),
      });

      print("Item added successfully with ID: ${item.id}");
    } catch (e) {
      print("❌ Error adding item: $e");
      rethrow; // Optional: rethrow to handle the error in the UI or higher level
    }
  }
}
