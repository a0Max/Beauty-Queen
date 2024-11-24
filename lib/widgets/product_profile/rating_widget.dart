import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../const/app_colors.dart';
import '../../controller/product_controller/product_profile_controller.dart';
import '../../controller/product_controller/product_profile_controller_provider.dart';

class RatingWidget extends StatelessWidget {
  final int maxRating;
  int? currentRating;
  bool allowToEdit;

  RatingWidget(
      {super.key,
      required this.maxRating,
      this.currentRating,
      required this.allowToEdit});

  @override
  Widget build(BuildContext context) {
    // final ProductProfileController controller =
    //     Get.put(ProductProfileController());
    final controller = context.watch<ProductProfileControllerProvider>();

    // currentRating = int.parse("${currentRating??0}");
    return allowToEdit == true
        ? Row(
            children: List.generate(
              maxRating,
              (index) => GestureDetector(
                  child: Icon(
                    ((allowToEdit == true)
                            ? index < controller.rate
                            : index < int.parse("${currentRating ?? 0}"))
                        ? Icons.star
                        : Icons.star_border,
                    color: ((allowToEdit == true)
                            ? index < controller.rate
                            : index < int.parse("${currentRating ?? 0}"))
                        ? AppColors.kPrimaryColor
                        : AppColors.kPinkColor,
                  ),
                  onTap: () {
                    print('allowToEdit:$allowToEdit');
                    if (allowToEdit == true) {
                      // currentRating = index + 1;
                      context
                          .read<ProductProfileControllerProvider>()
                          .currentRate(newRate: index + 1);
                    }
                  }),
            ),
          )
        : Row(
            children: List.generate(
              maxRating,
              (index) => GestureDetector(
                  child: Icon(
                    index < int.parse("${currentRating ?? 0}")
                        ? Icons.star
                        : Icons.star_border,
                    color: index < int.parse("${currentRating ?? 0}")
                        ? AppColors.kPrimaryColor
                        : AppColors.kPinkColor,
                  ),
                  onTap: () {}),
            ),
          );
  }
}
