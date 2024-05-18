
import '../../../exports.dart';

part 'reviews_state.dart';

class ReviewsCubit extends Cubit<ReviewsState> {
  final ReviewRepository _reviewRepository;

  ReviewsCubit(this._reviewRepository) : super(ReviewsInitial());

  void fetchReviews(String productId, {int limit = 3}) async {
    try {
      emit(ReviewsLoading());
      final reviews =
          await _reviewRepository.fetchReviews(productId, limit: limit);
      final averageRating = _calculateAverageRating(reviews);
      final totalReviews = reviews.length;
      emit(ReviewsLoaded(
        reviews: reviews,
        allReviews: reviews,
        productId: productId,
        averageRating: averageRating,
        totalReviews: totalReviews,
      ));
    } catch (e) {
      emit(ReviewsError(message: e.toString()));
    }
  }

  void fetchMoreReviews(String productId,
      {DocumentSnapshot? lastDocument, int limit = 10}) async {
    if (state is ReviewsLoaded) {
      try {
        final currentState = state as ReviewsLoaded;
        final result = await _reviewRepository.fetchMoreReviews(productId,
            lastDocument: lastDocument, limit: limit);
        final newReviews = result['reviews'] as List<Review>;
        final lastDoc = result['lastDocument'] as DocumentSnapshot?;
        final allReviews = [...currentState.allReviews, ...newReviews];
        final averageRating = _calculateAverageRating(allReviews);
        final totalReviews = allReviews.length;
        emit(currentState.copyWith(
          reviews: [...currentState.reviews, ...newReviews],
          allReviews: allReviews,
          lastDocument: lastDoc,
          averageRating: averageRating,
          totalReviews: totalReviews,
        ));
      } catch (e) {
        emit(ReviewsError(message: e.toString()));
      }
    }
  }

  void applyFilter(int rating) async {
    if (state is ReviewsLoaded) {
      final currentState = state as ReviewsLoaded;
      final filteredReviews = rating == 0
          ? currentState.allReviews
          : currentState.allReviews
              .where((review) => review.rating == rating)
              .toList();
      emit(currentState.copyWith(
          reviews: filteredReviews, selectedRatingFilter: rating));
    }
  }

  double _calculateAverageRating(List<Review> reviews) {
    if (reviews.isEmpty) return 0.0;
    final totalRating = reviews.fold(0.0, (sum, review) => sum + review.rating);
    return (totalRating / reviews.length).roundToDouble();
  }
}
