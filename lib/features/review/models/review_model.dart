import 'package:cloud_firestore/cloud_firestore.dart';

class Review {
  final String id;
  final String username;
  final String userImage;
  final double rating;
  final String reviewText;
  final DateTime date;

  Review({
    required this.id,
    required this.username,
    required this.userImage,
    required this.rating,
    required this.reviewText,
    required this.date,
  });

  factory Review.fromDocument(DocumentSnapshot doc) {
    return Review(
      id: doc.id,
      username: doc['username'],
      userImage: doc['userImage'],
      rating: doc['rating'].toDouble(),
      reviewText: doc['reviewText'],
      date: (doc['date'] as Timestamp).toDate(), // Convert Firestore Timestamp to DateTime
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'userImage': userImage,
      'rating': rating,
      'reviewText': reviewText,
      'date': Timestamp.fromDate(date),
    };
  }
}