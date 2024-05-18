import 'package:badges/badges.dart' as badge;

import '../../../exports.dart';

class ProductDetail extends StatefulWidget {
  const ProductDetail({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  late ReviewsCubit _reviewsCubit;

  @override
  void initState() {
    _reviewsCubit = context.read<ReviewsCubit>();
    _reviewsCubit.fetchReviews(widget.product.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final CartCubit cartCubit = context.read<CartCubit>();
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 30,
                left: 15,
                right: 15,
                bottom: 10,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(
                      Icons.arrow_back,
                    ),
                  ),
                  BlocBuilder<CartCubit, CartState>(
                    builder: (context, state) {
                      return badge.Badge(
                        position: badge.BadgePosition.topEnd(top: 0, end: 3),
                        badgeContent: Text(
                          state.items.length.toString(),
                          style: const TextStyle(color: Colors.white),
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.shopping_bag_outlined),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const Cart(),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                  // GestureDetector(
                  //     onTap: () async {
                  //       final reviewRepository = ReviewRepository();
                  //       await reviewRepository.updateExistingReviewsWithDate();
                  //       // await reviewRepository.addDummyReviewsToProducts();
                  //     },
                  //     child: Icon(Icons.add)),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 15,
                    ),
                    ImageView(
                      images: widget.product.images,
                      colors: widget.product.colors,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppText.medium(
                            widget.product.name,
                            fontWeight: FontWeight.w700,
                            fontSize: 20,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              RatingBar.builder(
                                unratedColor: ColorName.mainGrey,
                                initialRating:
                                    double.parse(widget.product.rating),
                                minRating: 1,
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                // itemCount: 5,
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
                                width: 3,
                              ),
                              AppText.small(
                                widget.product.rating,
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                              ),
                              const SizedBox(
                                width: 3,
                              ),
                              AppText.small(
                                '(${widget.product.reviews} Reviews)',
                                fontSize: 12,
                                color: ColorName.mainGrey,
                                fontWeight: FontWeight.w400,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          AppText.medium(
                            'Size',
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            height: 50,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                itemCount: widget.product.sizes.length,
                                itemBuilder: (context, index) {
                                  var size = widget.product.sizes[index];
                                  return Container(
                                    height: 40,
                                    width: 40,
                                    margin: const EdgeInsets.only(right: 15),
                                    decoration: BoxDecoration(
                                      color: index ==
                                              widget.product.sizes.length - 1
                                          ? Colors.black
                                          : ColorName.whiteColor,
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: ColorName.mainGrey,
                                      ),
                                    ),
                                    child: Center(
                                      child: AppText.medium(
                                        size,
                                        color: index ==
                                                widget.product.sizes.length - 1
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                    ),
                                  );
                                }),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          AppText.medium(
                            'Description',
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          AppText.medium(
                            widget.product.description,
                            color: Colors.grey[600],
                            fontWeight: FontWeight.w400,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          BlocBuilder<ReviewsCubit, ReviewsState>(
                            builder: (context, state) {
                              if (state is ReviewsLoading) {
                                return const Center(
                                    child: CircularProgressIndicator());
                              } else if (state is ReviewsError) {
                                return const Center(
                                    child: Text('Error fetching reviews'));
                              } else if (state is ReviewsLoaded) {
                                final reviews = state.reviews;
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AppText.medium(
                                      'Reviews (${state.totalReviews})',
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Column(
                                      children: reviews
                                          .map((review) => ReviewItem(
                                                review: review,
                                              ))
                                          .toList(),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    SizedBox(
                                      height: 50,
                                      width: ScreenUtil().screenWidth,
                                      child: ElevatedButton(
                                        onPressed: () =>
                                            Navigator.of(context).push(
                                          PageRouteBuilder(
                                            opaque: true,
                                            transitionDuration: const Duration(
                                                milliseconds: 100),
                                            pageBuilder:
                                                (BuildContext context, _, __) {
                                              return Reviews(
                                                productId: widget.product.id,
                                              );
                                            },
                                            transitionsBuilder: (_,
                                                Animation<double> animation,
                                                __,
                                                Widget child) {
                                              return SlideTransition(
                                                position: Tween<Offset>(
                                                  begin: const Offset(10, 10),
                                                  end: Offset.zero,
                                                ).animate(animation),
                                                child: child,
                                              );
                                            },
                                          ),
                                        ),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.transparent,
                                          elevation: 0,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            side: const BorderSide(
                                              color: Colors.grey,
                                              width: 1,
                                            ),
                                          ),
                                        ),
                                        child: AppText.medium(
                                          'SEE ALL REVIEW',
                                          color: Colors.black,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              } else {
                                return const Center(
                                  child: Text('No reviews yet'),
                                );
                              }
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 90,
        padding: const EdgeInsets.all(15),
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: CustomBottomBar(
          title: 'Price',
          amount: '\$${widget.product.price}',
          buttonText: 'ADD TO CART',
          onTap: () => showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (context) {
              return CartAddPop(
                cartCubit: cartCubit,
                product: widget.product,
              );
            },
          ),
        ),
      ),
    );
  }
}
