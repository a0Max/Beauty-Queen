import 'package:beauty_queen/const/colors.dart';
import 'package:beauty_queen/const/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../View/branddetail_screen.dart';

class CustomProductWidget extends StatelessWidget {
  final String imagePath;
  final String productName;
  final VoidCallback? onTap;

  const CustomProductWidget({
    super.key,
    required this.imagePath,
    required this.productName,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Get.to(const BrandDetailScreen());
        },
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Image.asset(
            imagePath,
            height: 97.h,
            width: 97.w,
          ),
          Text(
            productName,
            style: TextStyle(
              fontFamily: kTheArabicSansLight,
              color: kBlackColor,
              fontSize: 12.64.sp,
              fontWeight: FontWeight.w400,
            ),
          )
        ]));
  }
}
