import 'dart:async';

import 'package:shoesly/exports.dart';
import 'package:shoesly/features/home/ui/home_screen.dart';
// import 'package:flutter_svg/svg.dart';

class ThankYouPage extends StatefulWidget {
  const ThankYouPage({
    super.key,
  });

  @override
  State<ThankYouPage> createState() => _ThankYouPageState();
}


class _ThankYouPageState extends State<ThankYouPage> {
  double screenWidth = 600;
  double screenHeight = 400;
  
  @override
  void initState() {
    super.initState();
    // Wait for 3 seconds and then redirect
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 170,
              padding: const EdgeInsets.all(35),
              decoration: const BoxDecoration(
                color: ColorName.success,
                shape: BoxShape.circle,
              ),
              child: Image.asset(
                Assets.images.card.path,
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(height: screenHeight * 0.1),
            AppText.medium(
              "Thank You!",
              color: ColorName.success,
                fontWeight: FontWeight.w600,
                fontSize: 36,
            ),
            SizedBox(height: screenHeight * 0.01),
            AppText.medium(
              'Payment done Successfully',
              fontWeight: FontWeight.w400,
              fontSize: 17,
              color: Colors.black,
            ),
            SizedBox(height: screenHeight * 0.05),
            AppText.medium(
              "You will be redirected to the home page shortly\nor click here to return to home page",
              color: Colors.black,
              fontWeight: FontWeight.w400,
              fontSize: 14,
            ),
            SizedBox(height: screenHeight * 0.06),
            SizedBox(
                height: 50,
                width: 160,
                child: ElevatedButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ThankYouPage(),
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: AppText.medium(
                    'HOME',
                    color: ColorName.whiteColor,
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
