import '../../../exports.dart';

class Reviews extends StatefulWidget {
  const Reviews({
    super.key,
    required this.productId,
  });

  final String productId;

  @override
  State<Reviews> createState() => _ReviewsState();
}

class _ReviewsState extends State<Reviews> {
  late ReviewsCubit _reviewsCubit;

  @override
  void initState() {
    _reviewsCubit = context.read<ReviewsCubit>();
    _reviewsCubit.fetchReviews(widget.productId, limit: 10);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(
            Icons.arrow_back,
          ),
        ),
        title: BlocBuilder<ReviewsCubit, ReviewsState>(
          builder: (context, state) {
            return AppText.medium(
              'Reviews (${(state is ReviewsLoaded) ? state.totalReviews : 0})',
              fontSize: 16,
            );
          },
        ),
        actions: [
          SizedBox(
            child: Row(
              children: [
                Icon(
                  Icons.star,
                  color: Colors.amber,
                  size: 12.sp,
                ),
                const SizedBox(
                  width: 3,
                ),
                BlocBuilder<ReviewsCubit, ReviewsState>(
                  builder: (context, state) {
                    return AppText.medium((state is ReviewsLoaded) ? state.averageRating.toString() : '0.0' , fontSize: 14);
                  },
                ),
                const SizedBox(
                  width: 10,
                )
              ],
            ),
          ),
        ],
        backgroundColor: Colors.grey[100],
        foregroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size(double.infinity, 30),
          child: BlocBuilder<ReviewsCubit, ReviewsState>(
            builder: (context, state) {
              return _buildFilterOptions();
            },
          ),
        ),
      ),
      body: SafeArea(child: BlocBuilder<ReviewsCubit, ReviewsState>(
        builder: (context, state) {
          if (state is ReviewsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ReviewsError) {
            return const Center(child: Text('Error fetching reviews'));
          } else if (state is ReviewsLoaded) {
            final reviews = state.reviews;
            if (reviews.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      Assets.images.emptysearch.path,
                      height: 100,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    AppText.medium('Oops,no reviews available'),
                    const SizedBox(
                      height: 80,
                    ),
                  ],
                ),
              );
            } else {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                child: ListView.builder(
                  itemCount: reviews.length,
                  itemBuilder: (context, index) {
                    return ReviewItem(review: reviews[index]);
                  },
                ),
              );
            }
          } else {
            return const Center(child: Text('No reviews yet'));
          }
        },
      )),
    );
  }

  Column _buildFilterOptions() {
    final filterOptions = [
      Filteritem(name: 'All', rating: 0),
      Filteritem(name: '5 Stars', rating: 5),
      Filteritem(name: '4 Stars', rating: 4),
      Filteritem(name: '3 Stars', rating: 3),
      Filteritem(name: '2 Stars', rating: 2),
      Filteritem(name: '1 Stars', rating: 1),
    ];
    return Column(
      children: [
        Container(
          height: 30.h,
          padding: const EdgeInsets.only(left: 15),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemCount: filterOptions.length,
            itemBuilder: (context, index) {
              final filter = filterOptions[index];
              final isSelected = _reviewsCubit.state is ReviewsLoaded &&
                  (_reviewsCubit.state as ReviewsLoaded).selectedRatingFilter ==
                      filter.rating;

              return GestureDetector(
                onTap: () => _reviewsCubit.applyFilter(filter.rating),
                child: Padding(
                  padding: index == 0
                      ? const EdgeInsets.only(right: 10)
                      : const EdgeInsets.symmetric(horizontal: 10),
                  child: AppText.medium(
                    filter.name,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color:
                        isSelected ? ColorName.blackColor : ColorName.mainGrey,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class Filteritem {
  final String name;
  final int rating;
  Filteritem({
    required this.name,
    required this.rating,
  });
}
