import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../View/cart/cart_screen.dart';
import '../../const/app_colors.dart';
import '../../const/app_images.dart';
import '../../const/styles.dart';
import '../product_profile/CustomAlertBox.dart';

class GiftWidget extends StatelessWidget {
  final String price;
  final GestureTapCallback? onTap;

  const GiftWidget({super.key, required this.price, this.onTap});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 309.31.h,
      width: 170.w,
      decoration: BoxDecoration(
          color: AppColors.kPrimaryColor,
          borderRadius: BorderRadius.circular(15.r)),
      child: Stack(
        children: [
          Image.asset(AppImages.kgiftImagetwo),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 117.69.h,
              width: 170.w,
              decoration: BoxDecoration(
                  color: AppColors.klPinkColor,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(15.r),
                      bottomRight: Radius.circular(15.r))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "بطاقة هدايا بقيمة $price دينار",
                    style: TextStyle(
                        fontFamily: kTheArabicSansLight,
                        fontWeight: FontWeight.w700,
                        fontSize: 15.sp,
                        color: AppColors.kPrimaryColor),
                    textAlign: TextAlign.center,
                  ),
                  GestureDetector(
                    onTap: onTap,
                    child: Container(
                      height: 36.28.h,
                      width: 132.47.w,
                      decoration: BoxDecoration(
                          color: AppColors.kPrimaryColor,
                          borderRadius: BorderRadius.circular(5.r)),
                      child: Center(
                        child: Text(
                          tr('add_to_bags'),
                          style: TextStyle(
                              fontFamily: kTheArabicSansLight,
                              fontWeight: FontWeight.w400,
                              fontSize: 15.sp,
                              color: AppColors.kWhiteColor),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
