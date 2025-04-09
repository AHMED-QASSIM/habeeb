import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myhabeeb/Models/category_model.dart';

class CategoryService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Add a new category to Firestore
  Future<void> addCategory(Category category, String collection) async {
    try {
      await _firestore.collection('Categories').doc('U6VWQKmnDWPF2NnH3fiQ').collection(collection)
      .doc(category.id).set(category.toJson());
    } catch (e) {
      throw Exception("Error adding category: $e");
    }
  }

  // Fetch all categories from Firestore for a given collection
 
}
