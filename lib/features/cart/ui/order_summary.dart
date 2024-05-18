import 'dart:math';

import '../../../exports.dart';

class OrderSummary extends StatefulWidget {
  const OrderSummary({super.key});

  @override
  State<OrderSummary> createState() => _OrderSummaryState();
}

class _OrderSummaryState extends State<OrderSummary> {
  late BrandCubit _brandCubit;
  late CartCubit _cartCubit;
  late PaymentCubit _paymentCubit;

  @override
  void initState() {
    _brandCubit = context.read<BrandCubit>();
    _cartCubit = context.read<CartCubit>();
    _paymentCubit = context.read<PaymentCubit>();
    _brandCubit.fetchBrands();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 30, left: 15, right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Icon(
                      Icons.arrow_back,
                    ),
                    AppText.medium(
                      'Order Summary',
                      fontSize: 16,
                    ),
                    const SizedBox()
                  ],
                ),
              ),
              BlocConsumer<PaymentCubit, PaymentState>(
                listener: (context, state) async {
                  if (state is PaymentAdded) {
                    await _cartCubit.clearCart();
                    if (mounted) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ThankYouPage(),
                        ),
                      );
                    }
                  }
                },
                builder: (context, state) {
                  if (state is PaymentLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is PaymentError) {
                    return Center(
                      child: AppText.medium(state.message),
                    );
                  } else {
                    return Padding(
                      padding:
                          const EdgeInsets.only(top: 20, left: 15, right: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppText.medium(
                            'Information',
                            fontSize: 18,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const InformationCard(
                            title: 'Payment Method',
                            subtitle: 'Credit Card',
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Divider(
                            color: Colors.grey[200],
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          const InformationCard(
                            title: 'Location',
                            subtitle: 'Semarang, Indonesia',
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          AppText.medium(
                            'Order Detail',
                            fontSize: 18,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          BlocBuilder<CartCubit, CartState>(
                            builder: (context, cartState) {
                              final brands = _brandCubit.state is BrandLoaded
                                  ? (_brandCubit.state as BrandLoaded).brands
                                  : [];
                              return ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: cartState.items.length,
                                itemBuilder: (context, index) {
                                  final product =
                                      cartState.items.keys.elementAt(index);
                                  final quantity = cartState.items[product]!;

                                  final brand = brands.firstWhere(
                                    (brand) => brand.id == product.brandId,
                                    orElse: () => Brand(
                                      id: 'loading',
                                      name: 'Loading..',
                                      imageUrl: '',
                                    ),
                                  );
                                  return Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 8),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        AppText.medium(product.name),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            AppText.medium(
                                              '$brand . Red Grey . 40 . Qty $quantity',
                                              color: ColorName.mainGrey,
                                            ),
                                            AppText.medium(
                                                '\$${(product.price * quantity).toStringAsFixed(2)}'),
                                          ],
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          AppText.medium(
                            'Payment Detail',
                            fontSize: 18,
                          ),
                          const SizedBox(
                            height: 18,
                          ),
                          PaymentDetail(
                            title: 'Sub total',
                            amount:
                                '\$${_cartCubit.totalPrice.toStringAsFixed(2)}',
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          const PaymentDetail(
                            title: 'Shipping',
                            amount: '\$20.00',
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          PaymentDetail(
                            title: 'Total Order',
                            amount:
                                '\$${_cartCubit.totalOrder.toStringAsFixed(2)}',
                          ),
                        ],
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          return Container(
            height: 90,
            padding: const EdgeInsets.all(15),
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: CustomBottomBar(
              title: 'Grand Total',
              amount: '\$${_cartCubit.totalOrder.toStringAsFixed(2)}',
              buttonText: 'PAYMENT',
              onTap: () async {
                List<Map<String, dynamic>> orderDetails =
                    _cartCubit.convertOrderDetails(_cartCubit.state.items);

                final payment = Payment(
                  id: _generatePaymentID(),
                  userId: 'user_id',
                  location: 'User Location',
                  paymentMethod: 'Credit Card',
                  orderDetails: orderDetails,
                  totalPayment: _cartCubit.totalOrder,
                  timestamp: DateTime.now(),
                );

                _paymentCubit.addPayment(payment);
              },
            ),
          );
        },
      ),
    );
  }
}

String _generatePaymentID() {
  final random = Random();
  final paymentID = List.generate(12, (_) => random.nextInt(10)).join();
  return paymentID;
}
