import '../../../../exports.dart';

class CartAddPop extends StatefulWidget {
  const CartAddPop({
    super.key,
    required this.cartCubit,
    required this.product,
  });

  final CartCubit cartCubit;
  final Product product;

  @override
  State<CartAddPop> createState() => _CartAddPopState();
}

class _CartAddPopState extends State<CartAddPop> {
  late TextEditingController quatityController;

  @override
  void initState() {
    final initialQuantity = widget.cartCubit.state.items[widget.product] ?? 1;
    quatityController = TextEditingController(text: initialQuantity.toString());
    super.initState();
  }

  @override
  void dispose() {
    quatityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final quantity = widget.cartCubit.state.items[widget.product] ?? 1;
    // quatityController.text = quantity.toString();
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          left: 15,
          right: 15,
          top: 15,
        ),
        child: Column(
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: const BoxDecoration(
                color: ColorName.mainGrey,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppText.medium(
                      'Add to cart',
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(
                        Icons.close,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                AppText.medium(
                  'Quantity',
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                ),
                TextFormField(
                  controller: quatityController,
                  autofocus: true,
                  keyboardType: TextInputType.number,
                  onTapOutside: (event) {
                    FocusManager.instance.primaryFocus?.unfocus();
                  },
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      final int newQuantity = int.tryParse(value) ?? 1;
                      if (newQuantity < 1) {
                        quatityController.text = '1';
                        widget.cartCubit.updateQuantity(widget.product, 1);
                      } else {
                        setState(() => widget.cartCubit
                            .updateQuantity(widget.product, newQuantity));
                      }
                    }
                  },
                  decoration: InputDecoration(
                    suffixIcon: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GestureDetector(
                          // onTap: () => quantity == 1 ? null : setState(() {
                          //   widget.cartCubit.decrementQuantity(widget.product);
                          //   quatityController.text = quantity.toString();
                          // }),
                          onTap: quantity > 1
                              ? () {
                                  setState(() {
                                    widget.cartCubit
                                        .decrementQuantity(widget.product);
                                    quatityController.text =
                                        (quantity - 1).toString();
                                  });
                                }
                              : null,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: int.parse(quatityController.text) <= 1
                                    ? Colors.grey
                                    : Colors.black,
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
                        GestureDetector(
                          onTap: () => setState(() {
                            widget.cartCubit.incrementQuantity(widget.product);
                            quatityController.text = (quantity + 1).toString();
                          }),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: Colors.black,
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
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomBottomBar(
                  title: 'Price',
                  amount: quantity <= 0
                      ? '\$$widget.product.price'
                      : '\$${quantity * widget.product.price}',
                  buttonText: 'ADD TO CART',
                  onTap: () async {
                    if (quantity <= 0) {
                    } else {
                      final int newQuantity =
                          int.tryParse(quatityController.text) ?? 1;
                      widget.cartCubit.addToCart(widget.product, newQuantity);
                      Navigator.pop(context);
                      await showModalBottomSheet(
                        context: context,
                        isDismissible: false,
                        isScrollControlled: true,
                        builder: (context) {
                          return const CartAddedSuccess();
                        },
                      );
                    }
                  },
                ),
                SizedBox(
                  height: 20.h,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
