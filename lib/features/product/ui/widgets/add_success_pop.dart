import '../../../../exports.dart';

class CartAddedSuccess extends StatelessWidget {
  const CartAddedSuccess({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          left: 15,
          right: 15,
          top: 25,
        ),
        child: SizedBox(
          height: 280,
          child: Column(
            children: [
              Container(
                height: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.black,
                    width: 2,
                  ),
                ),
                child: const Center(
                  child: Icon(
                    Icons.check,
                    size: 30,
                    color: ColorName.mainGrey,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              AppText.medium(
                'Added to cart',
                fontWeight: FontWeight.w700,
                fontSize: 24,
              ),
              const SizedBox(
                height: 5,
              ),
              AppText.small(
                '1 Item Total',
                color: ColorName.mainGrey,
                fontSize: 14,
              ),
              const SizedBox(
                height: 20,
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 150,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: const BorderSide(
                            color: Colors.grey,
                            width: 1,
                          ),
                        ),
                      ),
                      child: AppText.medium(
                        'BACK EXPLORE',
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 150,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () =>
                          Navigator.popAndPushNamed(context, Routes.cart),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: AppText.medium(
                        'TO CART',
                        color: ColorName.whiteColor,
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
