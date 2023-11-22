import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../const/strings.dart';
import '../../const/colors.dart';
import '../../const/styles.dart';
import '../bottom_nav_screen.dart';

class CongratulationsPage extends StatelessWidget {
  const CongratulationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 72.h,
              ),
              Image.asset(
                'assets/images/congrads.png',
                width: 424.17.w,
                height: 315.27.h,
              ),
              SizedBox(
                height: 64.h,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    kCongratulationsMessage,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 30.85.sp,
                      fontFamily: kTheArabicSansBold,
                      color: kPrimaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Text(
                    kAccountActivationSuccessMessage,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 30.85.sp,
                      fontFamily: kTheArabicSansBold,
                      color: kPrimaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 42.h),
              Text(
                kShoppingPromptMessage,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24.sp,
                  fontFamily: kTheArabicSansLight,
                  color: kTextDGColor,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(
                height: 90.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Container(
                  height: 64.26.h,
                  width: 398.w,
                  decoration: BoxDecoration(
                    color: kPinkColor,
                    borderRadius: BorderRadius.circular(9.r),
                  ),
                  child: TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: kWhiteColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(9.r),
                      ),
                    ),
                    onPressed: () {
                      Get.to(const MainView());
                    },
                    child: Text(
                      kStartShopping,
                      style: TextStyle(
                          color: kWhiteColor,
                          fontSize: 20.85.sp,
                          fontFamily: kTheArabicSansLight,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
