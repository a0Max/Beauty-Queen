// ignore_for_file: file_names

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../const/app_colors.dart';
import '../const/styles.dart';

class CustomProductCard extends StatelessWidget {
  final String imageUrl;
  final String description;
  final String buttonText;
  final Function()? onPressed;

  const CustomProductCard({
    super.key,
    required this.imageUrl,
    required this.description,
    required this.buttonText,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 183.26.w,
      height: 311.79.h,
      margin: EdgeInsets.only(bottom: 16.h),
      child: Stack(
        children: [
          Positioned(
            left: 0,
            top: 0,
            child: Container(
              width: 183.26.w,
              height: 183.26.h,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: CachedNetworkImageProvider(imageUrl),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          Positioned(
            left: 0.53.w,
            top: 183.26.h,
            child: Container(
              width: 182.74.w,
              height: 128.53.h,
              decoration: const BoxDecoration(
                color: AppColors.klPinkColor,
              ),
            ),
          ),
          Positioned(
            left: 5.71.w,
            top: 201.82.h,
            child: SizedBox(
              width: 169.07.w,
              child: Text(
                description,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 11.85.sp,
                  fontFamily: kTheArabicSansLight,
                  fontWeight: FontWeight.w300,
                  height: 1.3,
                ),
              ),
            ),
          ),
          Positioned(
            left: 61.68.w,
            top: 283.83.h,
            child: Text(
              buttonText,
              textAlign: TextAlign.right,
              style: TextStyle(
                color: AppColors.kBlackRedColor,
                fontSize: 13.sp,
                fontFamily: kTheArabicSansLight,
                fontWeight: FontWeight.w600,
                decoration: TextDecoration.underline,
                height: 0.11,
                letterSpacing: -0.13,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
