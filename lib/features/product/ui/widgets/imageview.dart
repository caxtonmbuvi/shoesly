// ignore_for_file: public_member_api_docs, sort_constructors_first
import '../../../../exports.dart';

class ImageView extends StatefulWidget {
  const ImageView({
    super.key,
    required this.images,
    required this.colors,
  });

  final List<String> images;
  final List<String> colors;

  @override
  State<ImageView> createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {
  final PageController _pageController = PageController();
  int currentPage = 0;
  // List<String> images = [
  //   Assets.images.shoe1.path,
  //   Assets.images.shoe2.path,
  //   Assets.images.shoe3.path
  // ];

  // List<Color> colors = [
  //   Colors.white,
  //   Colors.black,
  //   Colors.green,
  //   Colors.blue,
  // ];

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        currentPage = _pageController.page!.round();
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Color _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return Color(int.parse(hexColor, radix: 16));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 315,
      width: ScreenUtil().screenWidth,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Card(
        elevation: 0,
        color: Colors.grey[300],
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 220,
              child: PageView.builder(
                controller: _pageController,
                itemCount: widget.images.length,
                itemBuilder: (context, index) {
                  return Container(
                    height: 150,
                    padding: const EdgeInsets.all(8.0),
                    child: Image.network(
                      widget.images[index],
                      fit: BoxFit.contain,
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      widget.images.length,
                      (index) => Container(
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: currentPage == index
                              ? ColorName.blackColor
                              : ColorName.mainGrey,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: ColorName.whiteColor,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      children: [
                        for (int i = 0; i < widget.colors.length; i++)
                          SizedBox(
                            height: 30,
                            width: 30,
                            child: Card(
                              color: _getColorFromHex(widget.colors[i]),
                              elevation: 1,
                              shape: const CircleBorder(),
                              child: i == 2
                                  ? const Icon(
                                      Icons.check,
                                      size: 14,
                                      color: ColorName.whiteColor,
                                    )
                                  : null,
                            ),
                          )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
