import '../../../../exports.dart';

class InformationCard extends StatelessWidget {
  const InformationCard({
    super.key,
    required this.title,
    required this.subtitle,
    this.onTap,
  });

  final String title;
  final String subtitle;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText.medium(title),
              const SizedBox(
                height: 5,
              ),
              AppText.medium(
                subtitle,
                color: ColorName.mainGrey,
              ),
            ],
          ),
          const Icon(
            Icons.arrow_forward_ios,
            color: ColorName.mainGrey,
            size: 16,
          ),
        ],
      ),
    );
  }
}