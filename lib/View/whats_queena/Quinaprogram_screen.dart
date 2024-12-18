// ignore_for_file: unrelated_type_equality_checks, file_names

import 'package:beauty_queen/const/app_images.dart';
import 'package:beauty_queen/const/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../const/app_colors.dart';
import '../../const/styles.dart';
import '../../controller/queen_controller/queen_controller.dart';
import '../../widgets/home/CustomNavBar2.dart';
import '../cart/cart_screen.dart';
import 'QuinaOffers_screen.dart';
import 'Quinaproducts_screen.dart';
import 'WhatisQuina_screen.dart';

class QuinaprogramScreen extends StatelessWidget {
  final bool? reCreate;
  QuinaprogramScreen({super.key, this.reCreate});
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    if (reCreate == true) {
      final QueenController tabcontroller = Get.put(QueenController());
    }
    return Scaffold(
      bottomNavigationBar: const ReusableBottomNavigationBar2(),
      body: GetBuilder<QueenController>(builder: (tabcontroller) {
        tabcontroller = Get.put(QueenController());
        return Column(
          children: [
            SizedBox(
              height: 50.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    10.pw,
                    GestureDetector(
                      onTap: () {
                        scaffoldKey.currentState?.openEndDrawer();
                      },
                      child: SvgPicture.asset(
                        AppImages.imageMenu,
                        height: 20.h,
                        width: 20.w,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.to(const CartScreen());
                      },
                      child: SvgPicture.asset(
                        AppImages.imageShop,
                        height: 30.h,
                        width: 30.w,
                      ),
                    ),
                    10.pw,
                    IconButton(
                        onPressed: () {
                          Get.back();
                        },
                        icon: const Icon(
                          Icons.arrow_forward_ios,
                          color: AppColors.kBlackColor,
                          size: 25,
                        )),
                    10.pw,
                  ],
                ),
              ],
            ),
            Image.asset(AppImages.queenaImage),
            SizedBox(
              height: 20.h,
            ),
            TabBar(
                onTap: (index) {
                  tabcontroller.changeTab(index);
                },
                tabs: [
                  Obx(
                    () => Tab(
                      icon: Container(
                        height: 64.h,
                        // width: 115.w,
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: AppColors.kPrimaryColor, width: 1.w),
                          borderRadius: BorderRadius.circular(13.r),
                          color: tabcontroller.currentTab == 0
                              ? AppColors.kPrimaryColor
                              : Colors.white,
                        ),
                        child: Center(
                          child: Text(
                            "ما هو برنامج كوينا؟",
                            style: TextStyle(
                              fontFamily: kTheArabicSansLight,
                              fontSize: 13.83.sp,
                              fontWeight: FontWeight.w400,
                              color: tabcontroller.currentTab == 0
                                  ? AppColors.kWhiteColor
                                  : AppColors.kPrimaryColor,
                            ),
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.visible,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Obx(
                    () => Tab(
                      icon: Container(
                        height: 41.h,
                        // width: 115.w,
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: AppColors.kPrimaryColor, width: 1.w),
                          borderRadius: BorderRadius.circular(13.r),
                          color: tabcontroller.currentTab == 1
                              ? AppColors.kPrimaryColor
                              : Colors.white,
                        ),
                        child: Center(
                          child: Text(
                            'منتجات كوينا',
                            style: TextStyle(
                              fontFamily: kTheArabicSansLight,
                              fontSize: 13.83.sp,
                              fontWeight: FontWeight.w400,
                              color: tabcontroller.currentTab == 1
                                  ? AppColors.kWhiteColor
                                  : AppColors.kPrimaryColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Obx(
                    () => Tab(
                      icon: Container(
                        height: 41.h,
                        // width: 115.w,
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: AppColors.kPrimaryColor, width: 1.w),
                          borderRadius: BorderRadius.circular(13.r),
                          color: tabcontroller.currentTab == 2
                              ? AppColors.kPrimaryColor
                              : Colors.white,
                        ),
                        child: Center(
                          child: Text(
                            'عروض كوينا',
                            style: TextStyle(
                              fontFamily: kTheArabicSansLight,
                              fontSize: 13.83.sp,
                              fontWeight: FontWeight.w400,
                              color: tabcontroller.currentTab == 2
                                  ? AppColors.kWhiteColor
                                  : AppColors.kPrimaryColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
                controller: tabcontroller.tabsController,
                indicatorColor: Colors.transparent,
                dividerColor: Colors.transparent),
            Expanded(
              child: TabBarView(
                controller: tabcontroller.tabsController,
                children: const [
                  WhatisQuinaScreen(),
                  QuinaproductsScreen(),
                  QuinaOffersScreen(),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}
