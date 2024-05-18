import '../../../exports.dart';
import '../models/brands_model.dart';

class BrandRepository {
  final FirebaseFirestore _firestore;

  BrandRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  Future<List<Brand>> fetchBrands() async {
    QuerySnapshot querySnapshot = await _firestore.collection('brands').get();
    return querySnapshot.docs.map((doc) => Brand.fromDocument(doc)).toList();
  }


  //Fetching Products once and aggregating Locally(Speeds up execution)
  Future<Map<String, int>> fetchBrandProductCounts() async {
    final snapshot = await _firestore.collection('products').get();
    final Map<String, int> brandCounts = {};

    for (final doc in snapshot.docs) {
      final brandId = doc['brandId'] as String;
      if (brandCounts.containsKey(brandId)) {
        brandCounts[brandId] = brandCounts[brandId]! + 1;
      } else {
        brandCounts[brandId] = 1;
      }
    }

    return brandCounts;
  }
}
