import '../../../../exports.dart';

class PaymentDetail extends StatelessWidget {
  const PaymentDetail({
    super.key,
    required this.title,
    required this.amount,
  });

  final String title;
  final String amount;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        AppText.medium(
          title,
          color: ColorName.mainGrey,
        ),
        AppText.medium(amount),
      ],
    );
  }
}