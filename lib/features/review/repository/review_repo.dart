import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shoesly/features/review/models/review_model.dart';

class ReviewRepository {
  final FirebaseFirestore _firestore;

  ReviewRepository() : _firestore = FirebaseFirestore.instance;

  // Future<Map<String, dynamic>> fetchReviews(String productId,
  //     {int limit = 3}) async {
  //   final snapshot = await _firestore
  //       .collection('products')
  //       .doc(productId)
  //       .collection('reviews')
  //       .orderBy('rating', descending: true)
  //       .limit(limit)
  //       .get();

  //   final reviews =
  //       snapshot.docs.map((doc) => Review.fromDocument(doc)).toList();
  //   final lastDocument = snapshot.docs.isNotEmpty ? snapshot.docs.last : null;

  //   return {'reviews': reviews, 'lastDocument': lastDocument};
  // }

  // Future<Map<String, dynamic>> fetchMoreReviews(String productId,
  //     {DocumentSnapshot? lastDocument, int limit = 10}) async {
  //   Query query = _firestore
  //       .collection('products')
  //       .doc(productId)
  //       .collection('reviews')
  //       .orderBy('rating', descending: true)
  //       .limit(limit);

  //   if (lastDocument != null) {
  //     query = query.startAfterDocument(lastDocument);
  //   }

  //   final snapshot = await query.get();
  //   final reviews =
  //       snapshot.docs.map((doc) => Review.fromDocument(doc)).toList();
  //   final newLastDocument =
  //       snapshot.docs.isNotEmpty ? snapshot.docs.last : null;

  //   return {'reviews': reviews, 'lastDocument': newLastDocument};
  // }

  Future<List<Review>> fetchReviews(String productId, {int limit = 3}) async {
    final snapshot = await _firestore
        .collection('products')
        .doc(productId)
        .collection('reviews')
        .orderBy('rating', descending: true)
        .limit(limit)
        .get();

    return snapshot.docs.map((doc) => Review.fromDocument(doc)).toList();
  }

  Future<Map<String, dynamic>> fetchMoreReviews(String productId,
      {DocumentSnapshot? lastDocument, int limit = 10}) async {
    Query query = _firestore
        .collection('products')
        .doc(productId)
        .collection('reviews')
        .orderBy('rating', descending: true)
        .limit(limit);

    if (lastDocument != null) {
      query = query.startAfterDocument(lastDocument);
    }

    final snapshot = await query.get();
    final reviews =
        snapshot.docs.map((doc) => Review.fromDocument(doc)).toList();
    final lastDoc = snapshot.docs.isNotEmpty ? snapshot.docs.last : null;

    return {
      'reviews': reviews,
      'lastDocument': lastDoc,
    };
  }

  // final List<Map<String, dynamic>> dummyReviews = [
  //   {
  //     "username": "Hazel Nutt",
  //     "userImage": "https://i.pravatar.cc/150?img=1",
  //     "rating": 5.0,
  //     "reviewText": "This product is amazing! Highly recommend.",
  //     "date": Timestamp.fromDate(DateTime.now().subtract(Duration(days: 1)))
  //   },
  //   {
  //     "username": "Chris P. Bacon",
  //     "userImage": "https://i.pravatar.cc/150?img=2",
  //     "rating": 4.0,
  //     "reviewText": "Good product, but there is room for improvement.",
  //     "date": Timestamp.fromDate(DateTime.now().subtract(Duration(days: 2)))
  //   },
  //   {
  //     "username": "Marsha Mellow",
  //     "userImage": "https://i.pravatar.cc/150?img=5",
  //     "rating": 3.0,
  //     "reviewText": "Average product. It does the job.",
  //     "date": Timestamp.fromDate(DateTime.now().subtract(Duration(days: 3)))
  //   },
  //   {
  //     "username": "Barb Akew",
  //     "userImage": "https://i.pravatar.cc/150?img=7",
  //     "rating": 2.0,
  //     "reviewText": "Not very satisfied with this product.",
  //     "date": Timestamp.fromDate(DateTime.now().subtract(Duration(days: 4)))
  //   },
  //   {
  //     "username": "Ann Chovey",
  //     "userImage": "https://i.pravatar.cc/150?img=9",
  //     "rating": 1.0,
  //     "reviewText": "I do not recommend this product at all.",
  //     "date": Timestamp.fromDate(DateTime.now().subtract(Duration(days: 5)))
  //   },
  //   {
  //     "username": "Maureen Biologist",
  //     "userImage": "https://i.pravatar.cc/150?img=14",
  //     "rating": 4.5,
  //     "reviewText": "Great product with some minor issues.",
  //     "date": Timestamp.fromDate(DateTime.now().subtract(Duration(days: 6)))
  //   },
  //   {
  //     "username": "Teri Dactyl",
  //     "userImage": "https://i.pravatar.cc/150?img=23",
  //     "rating": 3.5,
  //     "reviewText": "Decent product for the price.",
  //     "date": Timestamp.fromDate(DateTime.now().subtract(Duration(days: 7)))
  //   },
  //   {
  //     "username": "A. Mused",
  //     "userImage": "https://i.pravatar.cc/150?img=35",
  //     "rating": 2.5,
  //     "reviewText": "There are better options available.",
  //     "date": Timestamp.fromDate(DateTime.now().subtract(Duration(days: 8)))
  //   },
  //   {
  //     "username": "Ray O’Sun",
  //     "userImage": "https://i.pravatar.cc/150?img=311",
  //     "rating": 5.0,
  //     "reviewText": "Exceeded my expectations!",
  //     "date": Timestamp.fromDate(DateTime.now().subtract(Duration(days: 9)))
  //   },
  //   {
  //     "username": "Paige Turner",
  //     "userImage": "https://i.pravatar.cc/150?img=20",
  //     "rating": 4.0,
  //     "reviewText": "Good value for money.",
  //     "date": Timestamp.fromDate(DateTime.now().subtract(Duration(days: 10)))
  //   }
  // ];

  // Future<void> addDummyReviewsToProducts() async {
  //   print('started adding reviews');
  //   final productsSnapshot = await _firestore.collection('products').get();
  //   for (var productDoc in productsSnapshot.docs) {
  //     final productId = productDoc.id;
  //     for (var review in dummyReviews) {
  //       await _firestore
  //           .collection('products')
  //           .doc(productId)
  //           .collection('reviews')
  //           .add(review);
  //     }
  //   }

  //   print('Done adding reviews');
  // }

  // Future<void> updateExistingReviewsWithDate() async {
  //   print('started adding review Updates');
  //   final productsSnapshot = await _firestore.collection('products').get();
  //   for (var productDoc in productsSnapshot.docs) {
  //     final reviewsSnapshot = await _firestore
  //         .collection('products')
  //         .doc(productDoc.id)
  //         .collection('reviews')
  //         .get();
  //     for (var reviewDoc in reviewsSnapshot.docs) {
  //       if (!reviewDoc.data().containsKey('date')) {
  //         await _firestore
  //             .collection('products')
  //             .doc(productDoc.id)
  //             .collection('reviews')
  //             .doc(reviewDoc.id)
  //             .update({
  //           'date': Timestamp.fromDate(getRandomDate(
  //             start: DateTime.now().subtract(Duration(days: 365)),
  //             end: DateTime.now(),
  //           ))
  //         });
  //       }
  //     }
  //   }

  //   print('Done Updating reviews');
  // }

  // DateTime getRandomDate({required DateTime start, required DateTime end}) {
  //   final random = Random();
  //   int daysDifference = end.difference(start).inDays;
  //   int randomDays = random.nextInt(daysDifference + 1);
  //   return start.add(Duration(days: randomDays));
  // }
}
