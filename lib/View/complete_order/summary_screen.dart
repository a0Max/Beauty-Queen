import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../const/app_colors.dart';
import '../../const/images.dart';
import '../../const/styles.dart';
import '../productadded_screen.dart';

class SummaryScreen extends StatelessWidget {
  const SummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                children: [
                  SizedBox(
                    height: 40.h,
                  ),
                  Row(
                    children: [
                      Image.asset(kdollarImage),
                      SizedBox(
                        width: 20.w,
                      ),
                      Text(
                        'الفاتورة',
                        style: TextStyle(
                            fontFamily: kTheArabicSansLight,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.kBlackColor),
                      ),
                      const Spacer(),
                      Text(
                        'عدد العناصر (1)',
                        style: TextStyle(
                            fontFamily: kTheArabicSansLight,
                            fontSize: 24.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.kBlackColor),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Stack(
              children: [
                Image.asset(kcardImage),
                Padding(
                  padding: EdgeInsets.fromLTRB(32.w, 24.h, 32.w, 0.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment
                        .spaceBetween, // To place text on the left and right
                    children: [
                      Text.rich(TextSpan(children: [
                        TextSpan(
                          text: 'تاريخ و وقت الطلب:\n',
                          style: TextStyle(
                            fontFamily: kTheArabicSansLight,
                            fontSize: 17.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColors.kBlackColor,
                          ),
                        ),
                        TextSpan(
                          text: '08/08/2023 04:00',
                          style: TextStyle(
                            fontFamily: kTheArabicSansLight,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.kPrimaryColor,
                          ),
                        )
                      ])),
                      Text.rich(TextSpan(children: [
                        TextSpan(
                          text: 'رقم الطلب:\n',
                          style: TextStyle(
                            fontFamily: kTheArabicSansLight,
                            fontSize: 17.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColors.kBlackColor,
                          ),
                        ),
                        TextSpan(
                          text: '749#',
                          style: TextStyle(
                            fontFamily: kTheArabicSansLight,
                            fontSize: 22.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.kPrimaryColor,
                          ),
                        )
                      ])),
                    ],
                  ),
                ),
                Positioned(
                  top: 120.h,
                  right: 32.w,
                  child: Row(
                    children: [
                      Text(
                        'منتجات (2)',
                        style: TextStyle(
                          fontFamily: kTheArabicSansLight,
                          fontSize: 22.53.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.kBlackColor,
                        ),
                      ),
                    ],
                  ),
                ),

                //////////////////column//////////////
                Padding(
                    padding:
                        EdgeInsets.only(top: 190.h, left: 25.w, right: 20.w),
                    child: Column(children: [
                      SizedBox(
                        height: 107.62.h,
                        width: 346.94.w,
                        child: Stack(
                          children: [
                            Image.asset(
                              krevitImage,
                              height: 97.h,
                              width: 97.w,
                            ),
                            Positioned(
                              right: 110.w,
                              child: Text(
                                "L’oreal",
                                style: TextStyle(
                                    fontFamily: kTheArabicSansLight,
                                    fontSize: 17.44.sp,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.kBlackColor),
                              ),
                            ),
                            Positioned(
                              right: 290.w,
                              child: Text(
                                '149LD',
                                style: TextStyle(
                                    fontFamily: kTheArabicSansLight,
                                    fontSize: 16.57.sp,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.kPrimaryColor),
                              ),
                            ),
                            Positioned(
                              top: 22.h,
                              right: 110.w,
                              child: Text(
                                'كريم لوريال رفيتا ليفت لمحيط \nالعين',
                                style: TextStyle(
                                    fontFamily: kTheArabicSansLight,
                                    fontSize: 15.7.sp,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.kGrayColor),
                              ),
                            ),
                            Positioned(
                              top: 80.h,
                              right: 110.w,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "اللون:",
                                    style: TextStyle(
                                        fontFamily: kTheArabicSansLight,
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.kTextGrayColor),
                                  ),
                                  Text(
                                    ' أزرق غامق',
                                    style: TextStyle(
                                        fontFamily: kTheArabicSansLight,
                                        fontSize: 14.83.sp,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.kBlackColor),
                                  ),
                                  SizedBox(
                                    width: 60.w,
                                  ),
                                  Text(
                                    '1x قطعة',
                                    style: TextStyle(
                                        fontFamily: kTheArabicSansLight,
                                        fontSize: 14.83.sp,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.kBlackColor),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ])),
                //////////////second one////////////////

                Padding(
                    padding:
                        EdgeInsets.only(top: 320.h, left: 25.w, right: 20.w),
                    child: Column(children: [
                      Divider(
                        indent: 20.w,
                        endIndent: 20.w,
                        thickness: 2.w,
                        color: const Color(0xffE9E9E9),
                      ),
                      SizedBox(
                        height: 25.h,
                      ),
                      SizedBox(
                        height: 107.62.h,
                        width: 346.94.w,
                        child: Stack(
                          children: [
                            Image.asset(
                              krevitImage,
                              height: 97.h,
                              width: 97.w,
                            ),
                            Positioned(
                              right: 110.w,
                              child: Text(
                                "L’oreal",
                                style: TextStyle(
                                    fontFamily: kTheArabicSansLight,
                                    fontSize: 17.44.sp,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.kBlackColor),
                              ),
                            ),
                            Positioned(
                              right: 290.w,
                              child: Text(
                                '149LD',
                                style: TextStyle(
                                    fontFamily: kTheArabicSansLight,
                                    fontSize: 16.57.sp,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.kPrimaryColor),
                              ),
                            ),
                            Positioned(
                              top: 22.h,
                              right: 110.w,
                              child: Text(
                                'كريم لوريال رفيتا ليفت لمحيط \nالعين',
                                style: TextStyle(
                                    fontFamily: kTheArabicSansLight,
                                    fontSize: 15.7.sp,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.kGrayColor),
                              ),
                            ),
                            Positioned(
                              top: 80.h,
                              right: 110.w,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "اللون:",
                                    style: TextStyle(
                                        fontFamily: kTheArabicSansLight,
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.kTextGrayColor),
                                  ),
                                  Text(
                                    ' أزرق غامق',
                                    style: TextStyle(
                                        fontFamily: kTheArabicSansLight,
                                        fontSize: 14.83.sp,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.kBlackColor),
                                  ),
                                  SizedBox(
                                    width: 60.w,
                                  ),
                                  Text(
                                    '1x قطعة',
                                    style: TextStyle(
                                        fontFamily: kTheArabicSansLight,
                                        fontSize: 14.83.sp,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.kBlackColor),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ])),
                /////////////end second one/////////////
              ],
            ),

            ////////////////container/////////////////////////

            SizedBox(
              height: 47.h,
            ),
            ////////////////////////////////////////////////
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'خصم البروموكود',
                          style: TextStyle(
                              fontFamily: kTheArabicSansLight,
                              fontSize: 18.1.sp,
                              fontWeight: FontWeight.w400,
                              color: AppColors.kTextGrayColor),
                        ),
                        Text(
                          '00.00',
                          style: TextStyle(
                              fontFamily: kTheArabicSansLight,
                              fontSize: 18.1.sp,
                              fontWeight: FontWeight.w500,
                              color: AppColors.kBlackColor),
                        ),
                      ]),
                  ///////////second row////////
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'خصم البروموكود',
                          style: TextStyle(
                              fontFamily: kTheArabicSansLight,
                              fontSize: 18.1.sp,
                              fontWeight: FontWeight.w400,
                              color: AppColors.kTextGrayColor),
                        ),
                        Text(
                          '00.00',
                          style: TextStyle(
                              fontFamily: kTheArabicSansLight,
                              fontSize: 18.1.sp,
                              fontWeight: FontWeight.w500,
                              color: AppColors.kBlackColor),
                        ),
                      ]),
                  /////////third row//////////////
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'خصم البروموكود',
                          style: TextStyle(
                              fontFamily: kTheArabicSansLight,
                              fontSize: 18.1.sp,
                              fontWeight: FontWeight.w400,
                              color: AppColors.kTextGrayColor),
                        ),
                        Text(
                          '00.00',
                          style: TextStyle(
                              fontFamily: kTheArabicSansLight,
                              fontSize: 18.1.sp,
                              fontWeight: FontWeight.w500,
                              color: AppColors.kBlackColor),
                        ),
                      ]),
                  Divider(
                    color: AppColors.kTextGrayColor,
                    thickness: 1.w,
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'الإجمــالي',
                          style: TextStyle(
                              fontFamily: kTheArabicSansLight,
                              fontSize: 19.sp,
                              fontWeight: FontWeight.w600,
                              color: AppColors.kBlackColor),
                        ),
                        Text(
                          '900 LYD',
                          style: TextStyle(
                              fontFamily: kTheArabicSansLight,
                              fontSize: 22.44.sp,
                              fontWeight: FontWeight.w600,
                              color: AppColors.kPrimaryColor),
                        ),
                      ]),
                ],
              ),
            ),
            SizedBox(
              height: 160.h,
            ),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: 25.h),
        child: FloatingActionButton.extended(
          onPressed: () {},
          label: Container(
            height: 157.07.h,
            width: 431.77.w,
            decoration: BoxDecoration(color: AppColors.kWhiteColor, boxShadow: [
              BoxShadow(
                color: const Color.fromARGB(32, 0, 0, 0),
                blurRadius: 28.r,
                offset: const Offset(0, 4),
                spreadRadius: 0,
              ),
            ]),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  width: 27.w,
                ),
                Text.rich(TextSpan(children: [
                  TextSpan(
                    text: tr('total'),
                    style: TextStyle(
                        fontFamily: kTheArabicSansLight,
                        fontSize: 18.83.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColors.klPinkColor),
                  ),
                  TextSpan(
                    text: '900 دل',
                    style: TextStyle(
                        fontFamily: kTheArabicSansLight,
                        fontSize: 34.01.sp,
                        fontWeight: FontWeight.w700,
                        color: AppColors.kBlackColor),
                  )
                ])),
                // SizedBox(width: 35.w),
                GestureDetector(
                  onTap: () {
                    Get.to(const ProductAddedScreen());
                  },
                  child: Container(
                    height: 62.7.h,
                    width: 220.w,
                    decoration: BoxDecoration(
                      color: AppColors.kPrimaryColor,
                      borderRadius: BorderRadius.circular(46.r),
                    ),
                    child: Center(
                      child: Text(
                        'الإستمرار',
                        style: TextStyle(
                            fontFamily: kTheArabicSansLight,
                            fontSize: 23.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColors.kWhiteColor),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
