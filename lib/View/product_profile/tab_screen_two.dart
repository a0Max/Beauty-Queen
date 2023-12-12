
// import 'package:beauty_queen/const/colors.dart';
import 'package:beauty_queen/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../const/app_colors.dart';
// import '../../const/images.dart';
import '../../const/styles.dart';
import '../../controller/product_controller/product_profile_controller.dart';
import '../../widgets/product_profile/rating_widget.dart';

class TabScreenTwo extends StatelessWidget {
  TabScreenTwo({super.key});
  final TextEditingController commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final ProductProfileController controller =
    Get.put(ProductProfileController());

    // final RxInt currentRating = 0.obs;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 30.h,
        ),
        TextField(
          maxLines: 5, // Set the maximum lines to 5
          controller: commentController,
          decoration: InputDecoration(
              errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.kPrimaryColor, width: 2.w)),
              disabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.kPrimaryColor, width: 2.w)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.kPrimaryColor, width: 2.w)),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.kPrimaryColor, width: 2.w)),
              hintText: 'أكتب تقييماً...',
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.kPrimaryColor, width: 2.w))),
        ),
        const SizedBox(height: 10,),
        Row(
          children: [
            GestureDetector(
              onTap: (){
                controller.getImage();
              },
              child: Text(
                'إضافة صورة',
                style: TextStyle(
                    fontFamily: kTheArabicSansLight,
                    decorationColor: AppColors.kPrimaryColor,
                    decoration: TextDecoration.underline,
                    fontSize: 17.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.kPrimaryColor),
              ),
            ),
            SizedBox(
              width: 16.w,
            ),
            const RatingWidget(maxRating: 5),
          ],
        ),
        SizedBox(
          height: 42.w,
        ),
        GestureDetector(
          onTap: () async {
            LoadingScreen.show(context);
            await controller.verifyToAddReview(comment: commentController.text);
            Navigator.of(context).pop();
            controller.clearData();
            commentController.clear();


          },
          child: Container(
            height: 37.83.h,
            width: 131.w,
            color: AppColors.kPrimaryColor,
            child: Center(
              child: Text(
                'إرسال',
                style: TextStyle(
                    fontFamily: kTheArabicSansLight,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.kWhiteColor),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

