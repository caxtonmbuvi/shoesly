import '../../exports.dart';

class FirebaseApi {
  static Future<QuerySnapshot> getUsers(int limit,
      {DocumentSnapshot? startAfter}) async {
    final products =
        FirebaseFirestore.instance.collection('products').limit(limit);

    if (startAfter == null) {
      return products.get();
    } else {
      return products.startAfterDocument(startAfter).get();
    }
  }
}
