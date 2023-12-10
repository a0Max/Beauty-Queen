import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../const/app_colors.dart';
import '../../controller/product_controller/product_profile_controller.dart';

class RatingWidget extends StatelessWidget {
  final int maxRating;
  // int currentRating;

  RatingWidget(
      {super.key, required this.maxRating,});

  @override
  Widget build(BuildContext context) {
    final ProductProfileController controller =
    Get.put(ProductProfileController());

    return Obx(
          () => Row(
        children: List.generate(
          maxRating,
              (index) => GestureDetector(

            child: Icon(
              // size: 30,
              index < controller.rate.value ? Icons.star : Icons.star_border,
              color: index < controller.rate.value ? AppColors.kPrimaryColor : AppColors.kPinkColor,
            ),
            onTap: () {

              // currentRating = index + 1;
              controller.currentRate(newRate:index + 1);
            }
          ),
        ),
      ),
    );
  }
}
