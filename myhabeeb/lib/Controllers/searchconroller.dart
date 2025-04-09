import 'package:get/get.dart';
import 'package:myhabeeb/Services/algolia_service.dart';

class mySearchController extends GetxController {
  var searchResults = [].obs;
  var isSearching = false.obs;

  Future<void> search(String query) async {
    if (query.isEmpty) {
      isSearching.value = false;
      return;
    }

    isSearching.value = true;

    final results = await AlgoliaService().searchItems(query);
    searchResults.assignAll(results);
  }
}