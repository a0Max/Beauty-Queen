// ignore_for_file: file_names
import 'package:beauty_queen/View/categories/alkasam_screen.dart';
import 'package:beauty_queen/View/brands/brands_screen.dart';
import 'package:beauty_queen/const/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../View/about_me/about_app.dart';
import '../../View/categories/filter_screen.dart';
import '../../View/events/events_screen.dart';
import '../../View/gifts/GuidanceScreen.dart';
import '../../View/magazine/magazine_screen.dart';
import '../../View/user_profile/contact_us_screen.dart';
import '../../View/whats_queena/Quinaprogram_screen.dart';
import '../../View/offers/beautypharmacyscreen.dart';
import '../../View/discount/discounts_screen.dart';
import '../../View/user_profile/normalprofile.dart';
import '../../View/orders/orders_screen.dart';
import '../../const/app_colors.dart';
import '../../controller/AlKasam_controller/alkasam_controller.dart';

class MyEndDrawer extends StatelessWidget {
  const MyEndDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final AlkasamController controller = Get.put(AlkasamController());

    return Directionality(
      textDirection: TextDirection.ltr,
      child: Align(
        alignment: Alignment.topRight,
        child: Container(
          color: AppColors.kWhiteColor,
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
                        Get.to(const OrdersScreen(),
                            routeName: '/OrdersScreen');
                      },
                      child: Container(
                        height: 35.94.h,
                        width: 101.63.w,
                        color: AppColors.kPinkColor,
                        child: Center(
                          child: Text(
                            ' طلباتي',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: AppColors.kWhiteColor,
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
                        color: AppColors.kPinkColor,
                        child: Center(
                          child: Text(
                            ' حسابي',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: AppColors.kWhiteColor,
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
                color: AppColors.klPinkColor,
                child: Padding(
                  padding: EdgeInsets.only(right: 20.w, top: 5.h),
                  child: Text(
                    ' :تسوقي حسب',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: AppColors.kBlackColor,
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
                  Get.to(const AlKasamScreen(
                    showBack: true,
                  ));
                },
                child: Padding(
                  padding: EdgeInsets.only(right: 20.w),
                  child: Text(
                    'الأقسام',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: AppColors.kBlackColor,
                      fontSize: 18.sp,
                      fontFamily: kTheArabicSansLight,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const Divider(
                color: AppColors.klPinkColor,
              ),
              /////////second container//////////
              SizedBox(
                height: 12.h,
              ),
              GestureDetector(
                onTap: () {
                  Get.to(const BrandScreen(
                    showBack: true,
                  ));
                },
                child: Padding(
                  padding: EdgeInsets.only(right: 20.w),
                  child: Text(
                    'الماركات',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: AppColors.kBlackColor,
                      fontSize: 18.sp,
                      fontFamily: kTheArabicSansLight,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const Divider(
                color: AppColors.klPinkColor,
              ),
              ///////////////third//////////////////
              SizedBox(
                height: 11.h,
              ),
              GestureDetector(
                onTap: () {
                  Get.to(const DiscountScreen(
                    showBack: true,
                  ));
                },
                child: Padding(
                  padding: EdgeInsets.only(right: 20.w),
                  child: Text(
                    'التخفيضات',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: AppColors.kBlackColor,
                      fontSize: 17.sp,
                      fontFamily: kTheArabicSansLight,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const Divider(
                color: AppColors.klPinkColor,
              ),
              ////////fourth//////////////
              SizedBox(
                height: 11.h,
              ),
              GestureDetector(
                onTap: () {
                  Get.to(const GuidanceScreen(
                    showBack: true,
                  ));
                },
                child: Padding(
                  padding: EdgeInsets.only(right: 20.w),
                  child: Text(
                    'الهدايا',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: AppColors.kBlackColor,
                      fontSize: 17.sp,
                      fontFamily: kTheArabicSansLight,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const Divider(
                color: AppColors.klPinkColor,
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
                      color: AppColors.mainColor,
                      fontSize: 17.sp,
                      fontFamily: kTheArabicSansLight,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const Divider(
                color: AppColors.klPinkColor,
              ),
              //////////////sixth/////////////////////
              SizedBox(
                height: 11.h,
              ),
              GestureDetector(
                onTap: () {
                  controller.updateCurrentCategoryId(
                      newId: 183, getChild: false);
                  Get.to(const FliterScreen(
                    categoryId: 183,
                  ));
                },
                child: Padding(
                  padding: EdgeInsets.only(right: 20.w),
                  child: Text(
                    'صيدلية الجمال',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: AppColors.kBlackColor,
                      fontSize: 17.sp,
                      fontFamily: kTheArabicSansLight,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const Divider(
                color: AppColors.klPinkColor,
              ),
//////////////seventh/////////////////////
              SizedBox(
                height: 11.h,
              ),
              GestureDetector(
                onTap: () {
                  controller.updateCurrentCategoryId(
                      newId: 53, getChild: false);
                  Get.to(const FliterScreen(
                    categoryId: 53,
                  ));
                },
                child: Padding(
                  padding: EdgeInsets.only(right: 20.w),
                  child: Text(
                    'الأجهزة الكهربائية',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: AppColors.kBlackColor,
                      fontSize: 17.sp,
                      fontFamily: kTheArabicSansLight,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const Divider(
                color: AppColors.klPinkColor,
              ),
              SizedBox(
                height: 25.h,
              ),
              // Card Two portion
              Container(
                height: 37.13.h,
                width: 261.57.w,
                color: AppColors.klPinkColor,
                child: Padding(
                  padding: EdgeInsets.only(right: 20.w, top: 5.h),
                  child: Text(
                    'إكتشفي أيضاً',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: AppColors.kBlackColor,
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
                  Get.to(const MagazineScreen());
                },
                child: Padding(
                  padding: EdgeInsets.only(right: 20.w),
                  child: Text(
                    'مجلة بيوتي كوين',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: AppColors.kBlackColor,
                      fontSize: 17.sp,
                      fontFamily: kTheArabicSansLight,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const Divider(
                color: AppColors.klPinkColor,
              ),

              /////////////second text//////////////////
              SizedBox(
                height: 11.h,
              ),
              GestureDetector(
                onTap: () {
                  Get.to(
                      QuinaprogramScreen(
                        reCreate: true,
                      ),
                      routeName: '/QuinaprogramScreen');
                },
                child: Padding(
                  padding: EdgeInsets.only(right: 20.w),
                  child: Text(
                    'برنامج كوينا',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: AppColors.kBlackColor,
                      fontSize: 17.sp,
                      fontFamily: kTheArabicSansLight,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const Divider(
                color: AppColors.klPinkColor,
              ),
              /////////////third//////////
              SizedBox(
                height: 11.h,
              ),
              GestureDetector(
                onTap: () {
                  Get.to(const EventsScreen());
                },
                child: Padding(
                  padding: EdgeInsets.only(right: 20.w),
                  child: Text(
                    'المعرض',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: AppColors.kBlackColor,
                      fontSize: 17.sp,
                      fontFamily: kTheArabicSansLight,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const Divider(
                color: AppColors.klPinkColor,
              ),
              SizedBox(
                height: 25.h,
              ),
              Container(
                height: 37.13.h,
                width: 261.57.w,
                color: AppColors.klPinkColor,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ContactUsScreen()));
                  },
                  child: Padding(
                    padding: EdgeInsets.only(right: 20.w, top: 5.h),
                    child: Text(
                      'تواصل معنا',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: AppColors.kBlackColor,
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
                color: AppColors.klPinkColor,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AboutAppScreen()));
                  },
                  child: Padding(
                    padding: EdgeInsets.only(right: 20.w, top: 5.h),
                    child: Text(
                      'حول متجرنا',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: AppColors.kBlackColor,
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
