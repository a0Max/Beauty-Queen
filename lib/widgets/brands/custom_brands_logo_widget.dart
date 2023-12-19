import 'package:beauty_queen/const/colors.dart';
import 'package:beauty_queen/const/styles.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../View/brands/branddetail_screen.dart';
import '../../const/app_colors.dart';

class CustomProductWidget extends StatelessWidget {
  final String imagePath;
  final String productName;
  final String brandId;
  final VoidCallback? onTap;

  const CustomProductWidget({
    super.key,
    required this.imagePath,
    required this.productName,
    this.onTap,
    required this.brandId,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Get.to(BrandDetailScreen(
            brandId: int.parse(brandId),
          ));
        },
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          CachedNetworkImage(
            imageUrl: imagePath,
            height: 85.h,
            width: 85.w,
          ),
          Text(
            productName,
            style: TextStyle(
              fontFamily: kTheArabicSansLight,
              color: AppColors.kBlackColor,
              fontSize: 12.64.sp,
              fontWeight: FontWeight.w400,
            ),
          )
        ]));
  }
}
