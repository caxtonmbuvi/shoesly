import '../../exports.dart';

class CustomBottomBar extends StatelessWidget {
  const CustomBottomBar({
    super.key,
    required this.title,
    required this.amount,
    required this.buttonText,
    this.onTap,
  });

  final String title;
  final String amount;
  final String buttonText;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText.small(
              title,
              color: ColorName.mainGrey,
              fontSize: 12,
            ),
            AppText.medium(
              amount,
              fontSize: 20,
              fontWeight: FontWeight.w700,
            )
          ],
        ),
        SizedBox(
          height: 50,
          width: 160,
          child: ElevatedButton(
            onPressed: onTap,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: AppText.medium(
              buttonText,
              color: ColorName.whiteColor,
              fontWeight: FontWeight.w700,
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }
}