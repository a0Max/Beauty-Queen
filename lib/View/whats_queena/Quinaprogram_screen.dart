// ignore_for_file: unrelated_type_equality_checks, file_names

import 'package:beauty_queen/const/app_images.dart';
import 'package:beauty_queen/const/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../const/styles.dart';
import '../../controller/queen_controller/queen_controller.dart';
import 'QuinaOffers_screen.dart';
import 'Quinaproducts_screen.dart';
import 'WhatisQuina_screen.dart';

class QuinaprogramScreen extends StatelessWidget {
  const QuinaprogramScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final QueenController tabcontroller = Get.put(QueenController());

    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 50.h,
          ),
          Align(
            alignment: Alignment.topLeft,
            child: IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: Icon(
                  Icons.arrow_forward_ios,
                  size: 30.r,
                  color: kBlackColor,
                )),
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
                      border: Border.all(color: kPrimaryColor, width: 1.w),
                      borderRadius: BorderRadius.circular(13.r),
                      color: tabcontroller.currentTab == 0
                          ? kPrimaryColor
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
                              ? kWhiteColor
                              : kPrimaryColor,
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
                      border: Border.all(color: kPrimaryColor, width: 1.w),
                      borderRadius: BorderRadius.circular(13.r),
                      color: tabcontroller.currentTab == 1
                          ? kPrimaryColor
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
                              ? kWhiteColor
                              : kPrimaryColor,
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
                      border: Border.all(color: kPrimaryColor, width: 1.w),
                      borderRadius: BorderRadius.circular(13.r),
                      color: tabcontroller.currentTab == 2
                          ? kPrimaryColor
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
                              ? kWhiteColor
                              : kPrimaryColor,
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
            controller: tabcontroller.tabsController,
            indicatorColor: Colors.transparent,
              dividerColor:Colors.transparent
          ),
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
      ),
    );
  }
}
