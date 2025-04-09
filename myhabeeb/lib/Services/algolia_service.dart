
import 'package:algolia/algolia.dart';



class AlgoliaService {
  static const Algolia algolia = Algolia.init(
    applicationId: '1LOXGYNPGM',
    apiKey: '9b1a15b8d1a70f04946903931b7ce238',
  );
Future<List<AlgoliaObjectSnapshot>> searchItems(String query) async {
  // Perform the search on the items index
  final response = await algolia.index('items').search(query).getObjects();
  return response.hits;
}
}
