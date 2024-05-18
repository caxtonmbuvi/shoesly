import 'package:intl/intl.dart';
import 'package:shoesly/features/review/models/review_model.dart';

import '../../../../exports.dart';

class ReviewItem extends StatelessWidget {
  const ReviewItem({
    super.key,
    required this.review,
  });

  final Review review;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                flex: 1,
                child: CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage(
                    review.userImage,
                  ),
                ),
              ),
              // const SizedBox(
              //   width: 8,
              // ),
              Expanded(
                flex: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppText.medium(
                          review.username,
                          fontSize: 14,
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        AppText.medium(
                          formatDateTime(review.date),
                          fontSize: 12,
                          color: ColorName.mainGrey,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    RatingBar.builder(
                      unratedColor: ColorName.mainGrey,
                      initialRating: review.rating,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemSize: 15.h,
                      itemBuilder: (context, _) => const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {
                        print(rating);
                      },
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    SizedBox(
                      width: ScreenUtil().screenWidth - 80,
                      child: AppText.medium(
                        review.reviewText,
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  String formatDateTime(DateTime dateTime) {
    final DateFormat formatter = DateFormat.yMMMMd().add_jm();
    return formatter.format(dateTime);
  }
}
