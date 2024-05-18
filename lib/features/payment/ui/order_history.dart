import '../../../exports.dart';

class OrderHistory extends StatefulWidget {
  const OrderHistory({super.key});

  @override
  State<OrderHistory> createState() => _OrderHistoryState();
}

class _OrderHistoryState extends State<OrderHistory> {
  late PaymentCubit _paymentCubit;

  @override
  void initState() {
    _paymentCubit = context.read<PaymentCubit>();
    _paymentCubit.fetchPaymentHistory('user_id');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppText.medium(
          'Order History',
          fontSize: 16,
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(
            Icons.arrow_back,
          ),
        ),
      ),
      body: BlocBuilder<PaymentCubit, PaymentState>(
        builder: (context, paymentState) {
          if (paymentState is PaymentLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (paymentState is PaymentLoaded) {
            if (paymentState.payments.isEmpty) {
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
                            context, Routes.homeScreen,),
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
            }
            final groupedPayments = groupPaymentsByDate(paymentState.payments);
            return SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: groupedPayments.keys.length,
                  itemBuilder: (context, index) {
                    String date = groupedPayments.keys.elementAt(index);
                    List<Payment> paymentsForDate = groupedPayments[date]!;
                    return ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: paymentsForDate.length,
                        itemBuilder: (context, paymentIndex) {
                          var payment = paymentsForDate[paymentIndex];
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppText.medium(
                                date,
                                color: Colors.grey,
                                fontSize: 16,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  AppText.medium('Order: ${payment.id}'),
                                  Row(
                                    children: [
                                      AppText.medium('See More'),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      const Icon(
                                        Icons.arrow_forward_ios,
                                        size: 15,
                                      )
                                    ],
                                  ),
                                ],
                              ),
                              ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: payment.orderDetails.length,
                                itemBuilder: (context, index) {
                                  final orders = payment.orderDetails[index];
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 10,
                                    ),
                                    child: Column(
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              flex: 1,
                                              child: SizedBox(
                                                height: 80,
                                                child: Card(
                                                  color: Colors.grey[300],
                                                  elevation: 0,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                      10,
                                                    ),
                                                    child: Image.network(
                                                      orders['productImage'],
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
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  AppText.medium(
                                                    orders['productName'],
                                                    fontSize: 16,
                                                  ),
                                                  const SizedBox(
                                                    height: 6,
                                                  ),
                                                  AppText.small(
                                                    'Nike . Red Grey . 40',
                                                    color: ColorName.mainGrey,
                                                    fontSize: 12,
                                                  ),
                                                  const SizedBox(
                                                    height: 6,
                                                  ),
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      AppText.medium(
                                                        "\$${orders['price']}  X  ${orders['quantity']}  =  \$${orders['total']}",
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                              index <= (paymentState.payments.length - 2)
                                  ? const Divider(
                                      color: ColorName.mainGrey,
                                    )
                                  : const SizedBox.shrink()
                            ],
                          );
                        });
                  },
                ),
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}
