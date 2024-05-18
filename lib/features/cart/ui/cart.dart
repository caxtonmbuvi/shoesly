import '../../../exports.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  late CartCubit _cartCubit;
  late BrandCubit _brandCubit;

  @override
  void initState() {
    _brandCubit = context.read<BrandCubit>();
    _cartCubit = context.read<CartCubit>();
    _brandCubit.fetchBrands();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: AppText.medium(
          'Cart',
          fontSize: 16,
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(
            Icons.arrow_back,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const OrderHistory(),
              ),
            ),
            icon: const Icon(Icons.history),
          ),
        ],
      ),
      body: SafeArea(
        child: BlocBuilder<CartCubit, CartState>(
          builder: (context, state) {
            if (state.items.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(Assets.images.empty.path),
                    const SizedBox(
                      height: 10,
                    ),
                    AppText.medium('Oops,your Cart is empty'),
                    AppText.medium('Explore and add items to your cart'),
                    const SizedBox(
                      height: 80,
                    ),
                    SizedBox(
                      height: 50,
                      width: 160,
                      child: ElevatedButton(
                        onPressed: () => Navigator.pushReplacementNamed(
                          context,
                          Routes.homeScreen,
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: AppText.medium(
                          'Explore',
                          color: ColorName.whiteColor,
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            } else {
              final brands = _brandCubit.state is BrandLoaded
                  ? (_brandCubit.state as BrandLoaded).brands
                  : [];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: ListView.builder(
                  // physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: state.items.length,
                  itemBuilder: (context, index) {
                    final product = state.items.keys.elementAt(index);
                    final quantity = state.items[product]!;

                    final brand = brands.firstWhere(
                      (brand) => brand.id == product.brandId,
                      orElse: () => Brand(
                        id: 'loading',
                        name: 'Loading..',
                        imageUrl: '',
                      ),
                    );
                    return Dismissible(
                      direction: DismissDirection.endToStart,
                      background: const Card(
                        shape: BeveledRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                            topRight: Radius.zero,
                            bottomRight: Radius.zero,
                          ),
                        ),
                        color: Color(0xFFFF4C5E),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Icon(
                              Icons.delete_outline,
                              color: Colors.white,
                              size: 24,
                            ),
                            SizedBox(
                              width: 20,
                            )
                          ],
                        ),
                      ),
                      key: Key(product.id),
                      onDismissed: (direction) async {
                        // _cartCubit.removeFromCart(product);
                        setState(() {
                          _cartCubit.removeFromCart(product);
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: SizedBox(
                                    height: 80,
                                    child: Card(
                                      color: Colors.grey[300],
                                      elevation: 0,
                                      child: Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Image.network(
                                          product.images.first,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      AppText.medium(
                                        product.name,
                                        fontSize: 16,
                                      ),
                                      const SizedBox(
                                        height: 6,
                                      ),
                                      AppText.small(
                                        '${brand.name} . Red Grey . 40',
                                        color: ColorName.mainGrey,
                                        fontSize: 12,
                                      ),
                                      const SizedBox(
                                        height: 6,
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          AppText.medium(
                                              '\$${(product.price * quantity).toStringAsFixed(2)}'),
                                          Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              GestureDetector(
                                                onTap: () => quantity - 1 == 0
                                                    ? _cartCubit
                                                        .removeFromCart(product)
                                                    : setState(() {
                                                        _cartCubit
                                                            .decrementQuantity(
                                                          product,
                                                        );
                                                      }),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    border: Border.all(
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                  child: const Center(
                                                    child: Icon(
                                                      Icons.remove,
                                                      size: 18,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              AppText.medium(
                                                  quantity.toString()),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              GestureDetector(
                                                onTap: () => setState(
                                                  () => _cartCubit
                                                      .incrementQuantity(
                                                    product,
                                                  ),
                                                ),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    border: Border.all(
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                  child: const Center(
                                                    child: Icon(
                                                      Icons.add,
                                                      size: 18,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            }
          },
        ),
      ),
      bottomNavigationBar: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          if (state.items.isNotEmpty) {
            return Container(
              height: 90,
              padding: const EdgeInsets.all(15),
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: CustomBottomBar(
                title: 'Grand Total',
                amount: '\$${_cartCubit.totalPrice.toStringAsFixed(2)}',
                buttonText: 'CHECK OUT',
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const OrderSummary(),
                  ),
                ),
              ),
            );
          } else {
            return Container(
              height: 90,
            );
          }
        },
      ),
    );
  }
}
