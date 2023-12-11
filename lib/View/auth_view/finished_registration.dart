import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../const/app_colors.dart';
import '../../const/app_images.dart';
import '../../const/styles.dart';
import '../home/bottom_nav_screen.dart';

class CongratulationsPage extends StatelessWidget {
  const CongratulationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              SvgPicture.asset(
                AppImages.imageCongratulations,
                // width: 424.17.w,
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
                    tr('congratulations'),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 30.85.sp,
                      fontFamily: kTheArabicSansBold,
                      color: AppColors.kPrimaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Text(
                    tr('account_activated'),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 30.85.sp,
                      fontFamily: kTheArabicSansBold,
                      color: AppColors.kPrimaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 42.h),
              Text(
                tr('account_activated_and_continuous'),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24.sp,
                  fontFamily: kTheArabicSansLight,
                  color: AppColors.kTextDGColor,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(
                height: 90.h,
              ),
              Container(
                height: 64.26.h,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: AppColors.kPinkColor,
                  borderRadius: BorderRadius.circular(9.r),
                ),
                child: TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: AppColors.kWhiteColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(9.r),
                    ),
                  ),
                  onPressed: () {
                    Get.to(const MainView());
                  },
                  child: Text(
                    tr('start_shopping'),
                    style: TextStyle(
                        color: AppColors.kWhiteColor,
                        fontSize: 20.85.sp,
                        fontFamily: kTheArabicSansLight,
                        fontWeight: FontWeight.w700),
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
