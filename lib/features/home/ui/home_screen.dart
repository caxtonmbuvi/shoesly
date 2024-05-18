import 'package:badges/badges.dart' as badge;

import '../../../exports.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List shoes = [
    {
      "brand": "Nike",
      "colors": ["Red", "White"],
      "description": "High-performance running shoes with cushioned soles.",
      "images": [
        "https://example.com/nike1.jpg",
        "https://example.com/nike2.jpg"
      ],
      "name": "Nike Air Max",
      "rating": 4.5,
      "reviews": 1200,
      "sizes": ["7", "8", "9", "10", "11"],
      "price": 120.0
    },
    {
      "brand": "Adidas",
      "colors": ["Black", "Blue"],
      "description": "Comfortable everyday sneakers with breathable fabric.",
      "images": [
        "https://example.com/adidas1.jpg",
        "https://example.com/adidas2.jpg"
      ],
      "name": "Adidas Ultraboost",
      "rating": 4.7,
      "reviews": 950,
      "sizes": ["6", "7", "8", "9", "10"],
      "price": 140.0
    },
    {
      "brand": "Puma",
      "colors": ["Green", "Black"],
      "description": "Stylish shoes for casual wear and light workouts.",
      "images": [
        "https://example.com/puma1.jpg",
        "https://example.com/puma2.jpg"
      ],
      "name": "Puma Future Rider",
      "rating": 4.3,
      "reviews": 800,
      "sizes": ["7", "8", "9", "10", "11", "12"],
      "price": 90.0
    },
    {
      "brand": "Reebok",
      "colors": ["White", "Grey"],
      "description": "Classic design with a modern twist for everyday wear.",
      "images": [
        "https://example.com/reebok1.jpg",
        "https://example.com/reebok2.jpg"
      ],
      "name": "Reebok Classic",
      "rating": 4.6,
      "reviews": 1100,
      "sizes": ["6", "7", "8", "9", "10", "11"],
      "price": 100.0
    },
    {
      "brand": "New Balance",
      "colors": ["Blue", "White"],
      "description": "Perfect for long walks and light running activities.",
      "images": ["https://example.com/nb1.jpg", "https://example.com/nb2.jpg"],
      "name": "New Balance 574",
      "rating": 4.4,
      "reviews": 850,
      "sizes": ["7", "8", "9", "10", "11"],
      "price": 95.0
    },
    {
      "brand": "Asics",
      "colors": ["Black", "Yellow"],
      "description": "Designed for optimal performance in various sports.",
      "images": [
        "https://example.com/asics1.jpg",
        "https://example.com/asics2.jpg"
      ],
      "name": "Asics Gel-Kayano",
      "rating": 4.8,
      "reviews": 1300,
      "sizes": ["6", "7", "8", "9", "10", "11", "12"],
      "price": 150.0
    },
    {
      "brand": "Under Armour",
      "colors": ["Grey", "Black"],
      "description": "Lightweight and breathable with great support.",
      "images": ["https://example.com/ua1.jpg", "https://example.com/ua2.jpg"],
      "name": "Under Armour HOVR",
      "rating": 4.5,
      "reviews": 700,
      "sizes": ["7", "8", "9", "10", "11"],
      "price": 130.0
    },
    {
      "brand": "Skechers",
      "colors": ["Pink", "White"],
      "description": "Comfortable and stylish with memory foam insoles.",
      "images": [
        "https://example.com/skechers1.jpg",
        "https://example.com/skechers2.jpg"
      ],
      "name": "Skechers Go Walk",
      "rating": 4.6,
      "reviews": 900,
      "sizes": ["6", "7", "8", "9", "10"],
      "price": 80.0
    },
    {
      "brand": "Converse",
      "colors": ["Black", "White"],
      "description": "Iconic design with a timeless appeal.",
      "images": [
        "https://example.com/converse1.jpg",
        "https://example.com/converse2.jpg"
      ],
      "name": "Converse Chuck Taylor",
      "rating": 4.7,
      "reviews": 1050,
      "sizes": ["7", "8", "9", "10", "11", "12"],
      "price": 70.0
    },
    {
      "brand": "Vans",
      "colors": ["Red", "Black"],
      "description": "Skate shoes with a classic look and durable design.",
      "images": [
        "https://example.com/vans1.jpg",
        "https://example.com/vans2.jpg"
      ],
      "name": "Vans Old Skool",
      "rating": 4.5,
      "reviews": 1150,
      "sizes": ["6", "7", "8", "9", "10", "11"],
      "price": 75.0
    },
    {
      "brand": "FILA",
      "colors": ["White", "Blue"],
      "description": "Sporty and stylish sneakers for everyday wear.",
      "images": [
        "https://example.com/fila1.jpg",
        "https://example.com/fila2.jpg"
      ],
      "name": "FILA Disruptor",
      "rating": 4.4,
      "reviews": 950,
      "sizes": ["7", "8", "9", "10"],
      "price": 85.0
    },
    {
      "brand": "Under Armour",
      "colors": ["Black", "Yellow"],
      "description": "Lightweight and durable shoes for training sessions.",
      "images": ["https://example.com/ua1.jpg", "https://example.com/ua2.jpg"],
      "name": "Under Armour Charged Assert",
      "rating": 4.6,
      "reviews": 1100,
      "sizes": ["7", "8", "9", "10", "11"],
      "price": 95.0
    },
    {
      "brand": "Brooks",
      "colors": ["Grey", "Black"],
      "description":
          "Designed for runners seeking maximum cushioning and support.",
      "images": [
        "https://example.com/brooks1.jpg",
        "https://example.com/brooks2.jpg"
      ],
      "name": "Brooks Ghost",
      "rating": 4.7,
      "reviews": 1200,
      "sizes": ["7", "8", "9", "10", "11", "12"],
      "price": 130.0
    },
    {
      "brand": "Salomon",
      "colors": ["Black", "Green"],
      "description": "Trail running shoes with excellent grip and stability.",
      "images": [
        "https://example.com/salomon1.jpg",
        "https://example.com/salomon2.jpg"
      ],
      "name": "Salomon Speedcross",
      "rating": 4.8,
      "reviews": 1350,
      "sizes": ["6", "7", "8", "9", "10", "11"],
      "price": 150.0
    },
    {
      "brand": "Merrell",
      "colors": ["Brown", "Orange"],
      "description": "Versatile outdoor shoes for hiking and backpacking.",
      "images": [
        "https://example.com/merrell1.jpg",
        "https://example.com/merrell2.jpg"
      ],
      "name": "Merrell Moab",
      "rating": 4.5,
      "reviews": 1000,
      "sizes": ["7", "8", "9", "10", "11"],
      "price": 120.0
    },
    {
      "brand": "Saucony",
      "colors": ["Blue", "White"],
      "description":
          "High-performance running shoes with responsive cushioning.",
      "images": [
        "https://example.com/saucony1.jpg",
        "https://example.com/saucony2.jpg"
      ],
      "name": "Saucony Ride",
      "rating": 4.6,
      "reviews": 1050,
      "sizes": ["7", "8", "9", "10", "11"],
      "price": 110.0
    }
// Add more items as needed
  ];
  List<DocumentSnapshot> products = [];
  late ProductCubit _productCubit;
  late BrandCubit _brandCubit;
  late FilterCubit _filterCubit;
  final _scrollController = ScrollController();

  @override
  void initState() {
    _productCubit = context.read<ProductCubit>();
    _brandCubit = context.read<BrandCubit>();
    _productCubit.fetchProducts();
    _brandCubit.fetchBrands();
    _filterCubit = context.read<FilterCubit>();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        final currentState = _productCubit.state;
        if (currentState is ProductLoaded &&
            currentState.lastDocument != null) {
          _productCubit.fetchProducts(lastDocument: currentState.lastDocument);
        }
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
  //Method To add data to firebase
  // postData() async {
  //   await _brandCubit.addBrandsToFirebase();
  //   // for (var shoe in shoes) {
  //   //   await _productCubit.saveShoeDataToFirebase(
  //   //     brand: shoe['brand'],
  //   //     colors: List<String>.from(shoe['colors']),
  //   //     description: shoe['description'],
  //   //     images: List<String>.from(shoe['images']),
  //   //     name: shoe['name'],
  //   //     rating: shoe['rating'].toDouble(),
  //   //     reviews: shoe['reviews'],
  //   //     sizes: List<String>.from(shoe['sizes']),
  //   //     price: shoe['price'].toDouble(),
  //   //   );
  //   // }

  //   print('Done here');
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppText.large('Discover'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        automaticallyImplyLeading: false,
        actions: [
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
          const SizedBox(
            width: 15,
          ),
          // IconButton(
          //     onPressed: () {
          //       ProductRepository().addFieldToProducts();
          //     },
          //     icon: Icon(Icons.add),)
        ],
      ),
      body: BlocBuilder<BrandCubit, BrandState>(
        builder: (context, state) {
          if (state is BrandLoaded) {
            var brands = state.brands;
            return SafeArea(
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  BlocBuilder<ProductCubit, ProductState>(
                    builder: (context, productState) {
                      return Container(
                        height: 30.h,
                        padding: const EdgeInsets.only(left: 15),
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: brands.length,
                          itemBuilder: (context, index) {
                            var brand = brands[index];
                            final isSelected =
                                _filterCubit.state.brand == brand.id;
                            return GestureDetector(
                              onTap: () {
                                _filterCubit.updateBrand(brand.id);
                                _productCubit.applyFilters();
                              },
                              child: Padding(
                                padding: index == 0
                                    ? const EdgeInsets.only(right: 10)
                                    : const EdgeInsets.symmetric(
                                        horizontal: 10,
                                      ),
                                child: AppText.medium(
                                  brand.name,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                  color: isSelected
                                      ? ColorName.blackColor
                                      : ColorName.mainGrey,
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: BlocBuilder<ProductCubit, ProductState>(
                      builder: (context, state) {
                        if (state is ProductInitial) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (state is ProductLoading &&
                            state.isFirstFetch) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (state is ProductError) {
                          return Center(child: Text(state.message));
                        } else {
                          final List<Product> products = state is ProductLoading
                              ? (state).oldProducts
                              : (state as ProductLoaded).products;

                          final bool isLoading =
                              state is ProductLoading && state.isFirstFetch;

                          final brands = _brandCubit.state is BrandLoaded
                              ? (_brandCubit.state as BrandLoaded).brands
                              : [];

                          if (products.isEmpty) {
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
                                  AppText.medium('Oops,no items available'),
                                  const SizedBox(
                                    height: 80,
                                  ),
                                ],
                              ),
                            );
                          } else {
                            return Padding(
                              padding: EdgeInsets.symmetric(horizontal: 15.w),
                              child: GridView.builder(
                                controller: _scrollController,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: (130 / 180),
                                  crossAxisSpacing: 20,
                                  mainAxisSpacing: 20,
                                ),
                                itemCount: isLoading
                                    ? products.length + 1
                                    : products.length,
                                itemBuilder: (context, index) {
                                  if (index < products.length) {
                                    final product = products[index];
                                    final brand = brands.firstWhere(
                                      (brand) => brand.id == product.brandId,
                                      orElse: () => Brand(
                                        id: 'unknown',
                                        name: 'Unknown',
                                        imageUrl: '',
                                      ),
                                    );
                                    return ProductCard(
                                      brand: brand,
                                      product: product,
                                    );
                                  } else {
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }
                                },
                              ),
                            );
                          }
                        }
                      },
                    ),
                  ),
                ],
              ),
            );
          } else if (state is BrandError) {
            return Center(child: Text(state.message));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: SizedBox(
        height: 40,
        width: 120,
        child: ElevatedButton(
          onPressed: () async {
            await Navigator.of(context).push(
              PageRouteBuilder(
                opaque: true,
                transitionDuration: const Duration(seconds: 1),
                pageBuilder: (BuildContext context, _, __) {
                  return const FilterScreen();
                },
                transitionsBuilder:
                    (_, Animation<double> animation, __, Widget child) {
                  return SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(2, 2),
                      end: Offset.zero,
                    ).animate(animation),
                    child: child,
                  );
                },
              ),
            );
            // Apply filters if any were set
            _applyFilters();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black,
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                20,
              ),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(Assets.images.filter.path),
              AppText.medium(
                'FILTER',
                color: ColorName.whiteColor,
                fontWeight: FontWeight.w700,
              )
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  void _applyFilters() {
    _productCubit.applyFilters();
  }
}

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.brand,
    required this.product,
  });

  final Brand brand;
  final Product product;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProductDetail(
            product: product,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 150,
            child: Card(
              color: Colors.grey[300],
              elevation: 0,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 15,
                  horizontal: 10,
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image(
                          height: 15,
                          width: 20,
                          image: NetworkImage(
                            brand.imageUrl,
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.h),
                      child: Image.network(
                        product.images.first,
                        height: 80,
                        width: 100,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 5,
              vertical: 8,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText.small(
                  product.name,
                  fontSize: 12,
                  textOverflow: TextOverflow.ellipsis,
                ),
                const SizedBox(
                  height: 3,
                ),
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
                      AppText.small(
                        product.rating,
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                      const SizedBox(
                        width: 3,
                      ),
                      AppText.small(
                        '(${product.reviews} Reviews)',
                        fontSize: 12,
                        color: ColorName.mainGrey,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 3,
                ),
                AppText.small(
                  '\$${product.price}',
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
