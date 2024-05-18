part of 'reviews_cubit.dart';

abstract class ReviewsState extends Equatable {
  const ReviewsState();

  @override
  List<Object> get props => [];
}

class ReviewsInitial extends ReviewsState {}

class ReviewsLoading extends ReviewsState {}

class ReviewsLoaded extends ReviewsState {
  final List<Review> reviews;
  final List<Review> allReviews;
  final String productId;
  final DocumentSnapshot? lastDocument;
  final double averageRating;
  final int totalReviews;
  final int selectedRatingFilter;

  ReviewsLoaded({
    required this.reviews,
    required this.allReviews,
    required this.productId,
    this.lastDocument,
    required this.averageRating,
    required this.totalReviews,
    this.selectedRatingFilter = 0,
  });

  ReviewsLoaded copyWith({
    List<Review>? reviews,
    List<Review>? allReviews,
    DocumentSnapshot? lastDocument,
    double? averageRating,
    int? totalReviews,
    int? selectedRatingFilter,
  }) {
    return ReviewsLoaded(
      reviews: reviews ?? this.reviews,
      allReviews: allReviews ?? this.allReviews,
      productId: this.productId,
      lastDocument: lastDocument ?? this.lastDocument,
      averageRating: averageRating ?? this.averageRating,
      totalReviews: totalReviews ?? this.totalReviews,
      selectedRatingFilter: selectedRatingFilter ?? this.selectedRatingFilter,
    );
  }

  @override
  List<Object> get props => [
        reviews,
        allReviews,
        productId,
        if (lastDocument != null) lastDocument!,
        averageRating,
        totalReviews,
        selectedRatingFilter,
      ];
}

class ReviewsError extends ReviewsState {
  final String message;

  ReviewsError({required this.message});

  @override
  List<Object> get props => [message];
}
