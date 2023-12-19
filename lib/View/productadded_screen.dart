import 'package:beauty_queen/View/home/bottom_nav_screen.dart';
import 'package:beauty_queen/const/colors.dart';
import 'package:beauty_queen/const/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../const/app_colors.dart';
import '../const/images.dart';
import 'orders/orders_screen.dart';

class ProductAddedScreen extends StatelessWidget {
  const ProductAddedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Center(
              child: Image.asset(
                kcheckImage,
                height: 146.18.h,
                width: 244.48.w,
              ),
            ),
            Text(
              'تم تأكيد طلبك',
              style: TextStyle(
                  fontSize: 38.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.kBlackColor),
            ),
            //////////
            Text.rich(TextSpan(children: [
              TextSpan(
                text: 'رقم الطلب:',
                style: TextStyle(
                    fontFamily: kTheArabicSansLight,
                    fontSize: 17.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.kTextGrayColor),
              ),
              TextSpan(
                text: '749#',
                style: TextStyle(
                    fontFamily: kTheArabicSansLight,
                    fontSize: 22.1.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.kPrimaryColor),
              )
            ])),
            Text(
              'شكرا للتسوق من بيوتي كويين،سيتم\n   إعلامك بالخطوات التالية لطلبك',
              style: TextStyle(
                  fontFamily: kTheArabicSansLight,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.kBlackColor),
            ),
            Stack(children: [
              Image.asset(ksmallcardImage),
              Padding(
                padding: EdgeInsets.only(top: 10.h),
                child: Row(
                  children: [
                    SizedBox(
                      width: 27.w,
                    ),
                    Image.asset(kpaperImage),
                    SizedBox(
                      width: 10.w,
                    ),
                    Text(
                      'فاتورة',
                      style: TextStyle(
                          fontFamily: kTheArabicSansLight,
                          fontSize: 19.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.kPrimaryColor),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    const Expanded(
                      child: Divider(
                        endIndent: 23,
                        thickness: 1,
                        color: AppColors.kPrimaryColor,
                      ),
                    )
                  ],
                ),
              ),
              Positioned(
                top: 50.h,
                right: 27.w,
                child: Row(
                  children: [
                    Image.asset(facepowderImage),
                    Image.asset(makeupboxImage),
                    SizedBox(
                      width: 10.w,
                    ),
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: 'طلــب #LFGG847\n',
                            style: TextStyle(
                                fontFamily: kTheArabicSansLight,
                                fontSize: 21.44.sp,
                                fontWeight: FontWeight.w600,
                                color: AppColors.kBlackColor),
                          ),
                          TextSpan(
                            text: 'التاريخ: 22/10/2022',
                            style: TextStyle(
                                fontFamily: kTheArabicSansLight,
                                fontSize: 16.44.sp,
                                fontWeight: FontWeight.w400,
                                color: AppColors.kTextGrayColor),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              ///////////////
              Positioned(
                top: 120.h,
                right: 27.w,
                child: Row(
                  children: [
                    Container(
                      height: 40.h,
                      width: 40.w,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(9.87.r),
                          color: AppColors.kPrimaryColor),
                      child: Center(
                        child: Text(
                          "3+",
                          style: TextStyle(
                              fontFamily: kTheArabicSansLight,
                              color: AppColors.kWhiteColor,
                              fontSize: 17.54.sp,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    Image.asset(makeupboxImage),
                    SizedBox(
                      width: 10.w,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10.h),
                      child: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: '256 LYD',
                              style: TextStyle(
                                  fontFamily: kTheArabicSansLight,
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.kPrimaryColor),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ]),
            GestureDetector(
              onTap: () {
                Get.to(const MainView());
              },
              child: Container(
                height: 64.26.h,
                width: 398.27.w,
                decoration: BoxDecoration(
                    color: AppColors.kPrimaryColor,
                    borderRadius: BorderRadius.circular(47.34.r)),
                child: Center(
                  child: Text(
                    'الصفحة الرئيسية',
                    style: TextStyle(
                        fontFamily: kTheArabicSansLight,
                        fontSize: 20.85.sp,
                        fontWeight: FontWeight.w700,
                        color: AppColors.kWhiteColor),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Get.off(const OrdersScreen());
              },
              child: Text(
                'تفاصيل الطلب',
                style: TextStyle(
                    fontFamily: kTheArabicSansLight,
                    fontSize: 20.85.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.kPrimaryColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
