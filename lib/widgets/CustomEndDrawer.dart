// ignore_for_file: file_names
import 'package:beauty_queen/View/categories/alkasam_screen.dart';
import 'package:beauty_queen/View/brands/brands_screen.dart';
import 'package:beauty_queen/View/hairdryerscreen.dart';
import 'package:beauty_queen/const/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../View/GuidanceScreen.dart';
import '../View/Quinaprogram_screen.dart';
import '../View/beautypharmacyscreen.dart';
import '../View/beautyscreen.dart';
import '../View/discounts_screen.dart';
import '../View/filterby_screen.dart';
import '../View/normalprofile.dart';
import '../View/orders_screen.dart';
import '../const/colors.dart';

class MyEndDrawer extends StatelessWidget {
  const MyEndDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Align(
        alignment: Alignment.topRight,
        child: Container(
          color: kWhiteColor,
          height: Get.height,
          width: 261.57.w,
          child: ListView(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.to(const OrdersScreen());
                      },
                      child: Container(
                        height: 35.94.h,
                        width: 101.63.w,
                        color: kPinkColor,
                        child: Center(
                          child: Text(
                            ' طلباتي',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: kWhiteColor,
                              fontSize: 16.sp,
                              fontFamily: kTheArabicSansLight,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        Get.to(const NormalProfileScreen());
                      },
                      child: Container(
                        height: 35.94.h,
                        width: 101.63.w,
                        color: kPinkColor,
                        child: Center(
                          child: Text(
                            ' حسابي',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: kWhiteColor,
                              fontSize: 16.sp,
                              fontFamily: kTheArabicSansLight,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 23.h,
              ),
              // Card one portion
              Container(
                height: 37.13.h,
                width: 261.57.w,
                color: klPinkColor,
                child: Padding(
                  padding: EdgeInsets.only(right: 20.w, top: 5.h),
                  child: Text(
                    ' :تسوقي حسب',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: kBlackColor,
                      fontSize: 17.sp,
                      fontFamily: kTheArabicSansLight,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 15.h,
              ),
              GestureDetector(
                onTap: () {
                  Get.to(const AlKasamScreen());
                },
                child: Padding(
                  padding: EdgeInsets.only(right: 20.w),
                  child: Text(
                    'الأقسام',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: kBlackColor,
                      fontSize: 18.sp,
                      fontFamily: kTheArabicSansLight,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const Divider(
                color: klPinkColor,
              ),
              /////////second container//////////
              SizedBox(
                height: 12.h,
              ),
              GestureDetector(
                onTap: () {
                  Get.to(const BrandScreen());
                },
                child: Padding(
                  padding: EdgeInsets.only(right: 20.w),
                  child: Text(
                    'الماركات',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: kBlackColor,
                      fontSize: 18.sp,
                      fontFamily: kTheArabicSansLight,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const Divider(
                color: klPinkColor,
              ),
              ///////////////third//////////////////
              SizedBox(
                height: 11.h,
              ),
              GestureDetector(
                onTap: () {
                  Get.to(const DiscountScreen());
                },
                child: Padding(
                  padding: EdgeInsets.only(right: 20.w),
                  child: Text(
                    'التخفيضات',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: kBlackColor,
                      fontSize: 17.sp,
                      fontFamily: kTheArabicSansLight,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const Divider(
                color: klPinkColor,
              ),
              ////////fourth//////////////
              SizedBox(
                height: 11.h,
              ),
              GestureDetector(
                onTap: () {
                  Get.to(const GuidanceScreen());
                },
                child: Padding(
                  padding: EdgeInsets.only(right: 20.w),
                  child: Text(
                    'الهدايا',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: kBlackColor,
                      fontSize: 17.sp,
                      fontFamily: kTheArabicSansLight,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const Divider(
                color: klPinkColor,
              ),
              /////////////////fifth////////////
              SizedBox(
                height: 11.h,
              ),
              GestureDetector(
                onTap: () {
                  Get.to(const BeautyPharmacyScreen());
                },
                child: Padding(
                  padding: EdgeInsets.only(right: 20.w),
                  child: Text(
                    'عروض بيوتي كوين',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: kBlackColor,
                      fontSize: 17.sp,
                      fontFamily: kTheArabicSansLight,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const Divider(
                color: klPinkColor,
              ),
              //////////////sixth/////////////////////
              SizedBox(
                height: 11.h,
              ),
              GestureDetector(
                onTap: () {
                  Get.to(const BeautyPharmaScreen());
                },
                child: Padding(
                  padding: EdgeInsets.only(right: 20.w),
                  child: Text(
                    'صيدلية الجمال',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: kBlackColor,
                      fontSize: 17.sp,
                      fontFamily: kTheArabicSansLight,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const Divider(
                color: klPinkColor,
              ),
//////////////seventh/////////////////////
              SizedBox(
                height: 11.h,
              ),
              GestureDetector(
                onTap: () {
                  Get.to(const HairDryerScreen());
                },
                child: Padding(
                  padding: EdgeInsets.only(right: 20.w),
                  child: Text(
                    'الأجهزة الكهربائية',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: kBlackColor,
                      fontSize: 17.sp,
                      fontFamily: kTheArabicSansLight,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const Divider(
                color: klPinkColor,
              ),
              SizedBox(
                height: 25.h,
              ),
              // Card Two portion
              Container(
                height: 37.13.h,
                width: 261.57.w,
                color: klPinkColor,
                child: Padding(
                  padding: EdgeInsets.only(right: 20.w, top: 5.h),
                  child: Text(
                    'إكتشفي أيضاً',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: kBlackColor,
                      fontSize: 17.sp,
                      fontFamily: kTheArabicSansLight,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
////////////////second container first text/////////////////
              SizedBox(
                height: 11.h,
              ),
              GestureDetector(
                onTap: () {
                  Get.to(const HairDryerScreen());
                },
                child: Padding(
                  padding: EdgeInsets.only(right: 20.w),
                  child: Text(
                    'مجلة بيوتي كوين',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: kBlackColor,
                      fontSize: 17.sp,
                      fontFamily: kTheArabicSansLight,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const Divider(
                color: klPinkColor,
              ),

              /////////////second text//////////////////
              SizedBox(
                height: 11.h,
              ),
              GestureDetector(
                onTap: () {
                  Get.to(const QuinaprogramScreen());
                },
                child: Padding(
                  padding: EdgeInsets.only(right: 20.w),
                  child: Text(
                    'برنامج كوينا',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: kBlackColor,
                      fontSize: 17.sp,
                      fontFamily: kTheArabicSansLight,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const Divider(
                color: klPinkColor,
              ),
              /////////////third//////////
              SizedBox(
                height: 11.h,
              ),
              GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Padding(
                  padding: EdgeInsets.only(right: 20.w),
                  child: Text(
                    'المعرض',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: kBlackColor,
                      fontSize: 17.sp,
                      fontFamily: kTheArabicSansLight,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const Divider(
                color: klPinkColor,
              ),
              SizedBox(
                height: 25.h,
              ),
              Container(
                height: 37.13.h,
                width: 261.57.w,
                color: klPinkColor,
                child: GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Padding(
                    padding: EdgeInsets.only(right: 20.w, top: 5.h),
                    child: Text(
                      'تواصل معنا',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: kBlackColor,
                        fontSize: 17.sp,
                        fontFamily: kTheArabicSansLight,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 23.h,
              ),
              /////////////// second card portion/////////////
              Container(
                height: 37.13.h,
                width: 261.57.w,
                color: klPinkColor,
                child: GestureDetector(
                  onTap: () {
                    Get.to(const FilterByContainer());
                  },
                  child: Padding(
                    padding: EdgeInsets.only(right: 20.w, top: 5.h),
                    child: Text(
                      'حول متجرنا',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: kBlackColor,
                        fontSize: 17.sp,
                        fontFamily: kTheArabicSansLight,
                        fontWeight: FontWeight.w600,
                      ),
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
