import 'package:shoesly/features/home/cubit/filter_cubit.dart';

import '../../../exports.dart';
import '../models/product_model.dart';

class ProductRepository {
  final FirebaseFirestore _firestore;

  ProductRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  Future<Map<String, dynamic>> fetchProducts({
    DocumentSnapshot? lastDocument,
    String? brandId,
    String? gender,
    String? color,
    SortCriteria? sortCriteria,
    double? minPrice,
    double? maxPrice,
    int limit = 7,
  }) async {
    Query query = _firestore.collection('products');

    if (brandId != null) {
      query = query.where('brandId', isEqualTo: brandId);
    }

    if (gender != null) {
      query = query.where('gender', isEqualTo: gender);
    }

    if (color != null) {
      query = query.where('colors', arrayContains: color);
    }

    if (minPrice != null) {
      query = query.where('price', isGreaterThanOrEqualTo: minPrice);
    }

    if (maxPrice != null && maxPrice != 1000) {
      query = query.where('price', isLessThanOrEqualTo: maxPrice);
    }

    // Order by price first if price range filter is applied
    if (minPrice != null || (maxPrice != null && maxPrice != 1000)) {
      query = query.orderBy('price', descending: sortCriteria == SortCriteria.highestReviews ? true : false);
    }

    if (sortCriteria != null) {
      switch (sortCriteria) {
        case SortCriteria.lowestPrice:
          query = query.orderBy('price', descending: false);
          break;
        case SortCriteria.highestReviews:
          query = query.orderBy('reviews', descending: true);
          break;
        case SortCriteria.mostRecent:
        default:
          query = query.orderBy('createdAt', descending: true);
          break;
      }
    } else {
      query = query.orderBy('createdAt', descending: true);
    }

    if (lastDocument != null) {
      query = query.startAfterDocument(lastDocument);
    }

    print("Query: ${query.parameters}");

    QuerySnapshot querySnapshot = await query.limit(limit).get();
    List<Product> products =
        querySnapshot.docs.map((doc) => Product.fromDocument(doc)).toList();
    DocumentSnapshot? lastDoc =
        querySnapshot.docs.isNotEmpty ? querySnapshot.docs.last : null;

    return {
      'products': products,
      'lastDocument': lastDoc,
    };
  }

  // Future<void> addFieldToProducts() async {
  //   try {
  //     print("Process Started");
  //     // Fetch all documents from the products collection
  //     QuerySnapshot querySnapshot =
  //         await _firestore.collection('products').get();

  //     // Create a batch to perform multiple writes
  //     WriteBatch batch = _firestore.batch();

  //     for (QueryDocumentSnapshot doc in querySnapshot.docs) {
  //       // Create a new date field
  //       Map<String, dynamic> updatedData = {
  //         'gender': getRandomGender(), // Or any specific data you want to set
  //       };

  //       // Add the update to the batch
  //       batch.update(doc.reference, updatedData);
  //     }

  //     // Commit the batch
  //     await batch.commit();
  //     print('Successfully added data field to all products');
  //   } catch (e) {
  //     print('Failed to add data field to products: $e');
  //   }
  // }

  // String getRandomGender() {
  //   final List<String> genders = ['male', 'female', 'unisex'];
  //   final Random random = Random();
  //   return genders[random.nextInt(genders.length)];
  // }

  // DateTime getRandomDate({required DateTime start, required DateTime end}) {
  //   final random = Random();
  //   int daysDifference = end.difference(start).inDays;
  //   int randomDays = random.nextInt(daysDifference + 1);
  //   return start.add(Duration(days: randomDays));
  // }

  // Future<Map<String, dynamic>> fetchProducts(
  //     {DocumentSnapshot? lastDocument, String? brandId, int limit = 7}) async {
  //   Query query =
  //       _firestore.collection('products').orderBy('name').limit(limit);

  //   if (brandId != null) {
  //     query = query.where('brandId', isEqualTo: brandId);
  //   }

  //   if (lastDocument != null) {
  //     query = query.startAfterDocument(lastDocument);
  //   }

  //   QuerySnapshot querySnapshot = await query.get();
  //   List<Product> products =
  //       querySnapshot.docs.map((doc) => Product.fromDocument(doc)).toList();
  //   DocumentSnapshot? lastDoc =
  //       querySnapshot.docs.isNotEmpty ? querySnapshot.docs.last : null;

  //   return {
  //     'products': products,
  //     'lastDocument': lastDoc,
  //   };
  // }

  // Future<Map<String, dynamic>> fetchProducts({DocumentSnapshot? lastDocument, int limit = 7}) async {
  //   Query query = _firestore.collection('products').orderBy('name').limit(limit);

  //   if (lastDocument != null) {
  //     query = query.startAfterDocument(lastDocument);
  //   }

  //   QuerySnapshot querySnapshot = await query.get();
  //   List<Product> products = querySnapshot.docs.map((doc) => Product.fromDocument(doc)).toList();
  //   DocumentSnapshot? lastDoc = querySnapshot.docs.isNotEmpty ? querySnapshot.docs.last : null;

  //   return {
  //     'products': products,
  //     'lastDocument': lastDoc,
  //   };
  // }
}
