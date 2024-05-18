import 'package:flutter/material.dart';

import '../../../../exports.dart';

class BrandFilterWidget extends StatelessWidget {
  final String brandName;
  final String imageUrl;
  final bool isSelected;
  final VoidCallback onTap;
  final int productCount;

  const BrandFilterWidget({super.key, 
    required this.brandName,
    required this.imageUrl,
    required this.isSelected,
    required this.onTap,
    required this.productCount,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(right: 15),
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 60,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey[200],
                  ),
                  child: Center(
                    child: Image.network(
                      imageUrl,
                      color: Colors.black,
                    ),
                  ),
                ),
                if (isSelected)
                  Positioned(
                    bottom: 0,
                    right: 4,
                    child: Container(
                      padding: const EdgeInsets.all(3),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.black,
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 13,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            AppText.medium(
              brandName,
            ),
            AppText.small(
              '$productCount Items',
              fontSize: 12,
            )
          ],
        ),
      ),
    );
  }
}
