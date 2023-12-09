import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../const/app_colors.dart';

class RatingWidget extends StatelessWidget {
  final int maxRating;
  final RxInt currentRating;

  const RatingWidget(
      {super.key, required this.maxRating, required this.currentRating});

  @override
  Widget build(BuildContext context) {
    return Obx(
          () => Row(
        children: List.generate(
          maxRating,
              (index) => GestureDetector(

            child: Icon(
              // size: 30,
              index < currentRating.value ? Icons.star : Icons.star_border,
              color: index < currentRating.value ? AppColors.kPrimaryColor : AppColors.kPinkColor,
            ),
            onTap: () => currentRating.value = index + 1,
          ),
        ),
      ),
    );
  }
}
