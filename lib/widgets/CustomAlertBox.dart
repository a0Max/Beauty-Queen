// ignore_for_file: file_names

import 'package:beauty_queen/const/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../const/styles.dart';

class CustomAlertDialog extends StatelessWidget {
  final String? dilougText;
  final String? buttonOneText;
  final String? buttonTwoText;
  final double? height;
  final double? width;
  final bool buttonTwo;
  final VoidCallback? onButtonOnePressed;
  const CustomAlertDialog(
      {super.key,
      this.dilougText,
      this.buttonOneText,
      this.buttonTwoText,
      this.height = 124.95,
      this.buttonTwo = true,
      this.onButtonOnePressed,
      this.width = 367.06});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.r),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Container(
        height: height,
        width: width,
        padding: EdgeInsets.symmetric(horizontal: 10.w,vertical:20.h),
        decoration: const BoxDecoration(
          color: kPrimaryColor,
        ),
        child: Column(
          children: <Widget>[
            // SizedBox(height: 23.h),
            Text(
              dilougText.toString(),
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontFamily: kTheArabicSansLight,
                color: kWhiteColor,
                fontSize: 16.39.sp,
              ),
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                    height: 42.65.h,
                    // width: 145.91.w,

                    padding: EdgeInsets.symmetric(horizontal: 7.w),
                    color: kBlackColor,
                    child: Center(
                      child: Text(
                        buttonOneText.toString(),
                        style: TextStyle(
                            fontFamily: kTheArabicSansLight,
                            color: kWhiteColor,
                            fontSize: 14.2.sp,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                ),
                if (buttonTwo)
                  GestureDetector(
                    onTap: () {
                      Get.back();
                      onButtonOnePressed?.call();
                    },
                    child: Container(
                      height: 42.65.h,
                      padding: EdgeInsets.symmetric(horizontal: 7.w),
                      // width: 145.91.w,
                      color: kBlackColor,
                      child: Center(
                        child: Text(
                          buttonTwoText.toString(),
                          style: TextStyle(
                              fontFamily: kTheArabicSansLight,
                              color: kWhiteColor,
                              fontSize: 14.2.sp,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            // SizedBox(height: 13.h),
          ],
        ),
      ),
    );
  }
}
