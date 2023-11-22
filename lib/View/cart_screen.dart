import 'package:beauty_queen/const/colors.dart';
import 'package:beauty_queen/const/styles.dart';
import 'package:beauty_queen/controller/productController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../const/images.dart';
import 'cart_tab_screen.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ProductController productController = Get.put(ProductController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 50.h,
            ),
            Row(
              children: [
                SizedBox(
                  width: 17.w,
                ),
                Image.asset(kcartIconImage),
                SizedBox(
                  width: 9.w,
                ),
                Text(
                  "سلّتي",
                  style: TextStyle(
                      fontFamily: kTheArabicSansLight,
                      fontSize: 23.sp,
                      fontWeight: FontWeight.w700,
                      color: kPrimaryColor),
                ),
                const Spacer(),
                IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: const Icon(
                      Icons.arrow_forward_ios,
                      color: kBlackColor,
                      size: 25,
                    )),
              ],
            ),
            SizedBox(
              height: 17.h,
            ),
            //////////////////container//////////////
            Container(
              color: kPrimaryColor,
              height: 50.83.h,
              width: 438.44.w,
              child: Row(
                children: [
                  SizedBox(
                    width: 17.w,
                  ),
                  Text(
                    "الحد الأدنى للطلب هو 10 د.ل",
                    style: TextStyle(
                        fontFamily: kTheArabicSansLight,
                        fontSize: 19.sp,
                        fontWeight: FontWeight.w600,
                        color: kWhiteColor),
                  ),
                  const Spacer(),
                  Image.asset(kqueencrownImage),
                ],
              ),
            ),
            ////////////////Row data////////////////////

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                children: [
                  Row(
                    children: [
                      Image.asset(
                        krevitImage,
                        height: 97.h,
                        width: 97.w,
                      ),
                      SizedBox(
                        width: 19.w,
                      ),
                      Text(
                        "L’oreal",
                        style: TextStyle(
                            fontFamily: kTheArabicSansLight,
                            fontSize: 18.39.sp,
                            fontWeight: FontWeight.w600,
                            color: kBlackColor),
                      ),
                      const Spacer(),
                      Text(
                        '149.00',
                        style: TextStyle(
                            fontFamily: kTheArabicSansLight,
                            fontSize: 21.47.sp,
                            fontWeight: FontWeight.w400,
                            color: kBlackColor),
                      ),
                      Text(
                        'د.ل',
                        style: TextStyle(
                            fontFamily: kTheArabicSansLight,
                            fontSize: 17.47.sp,
                            fontWeight: FontWeight.w400,
                            color: kBlackColor),
                      ),
                    ],
                  ),
                  Text(
                    '                           كريم لوريال رفيتا ليفت لمحيط العين',
                    style: TextStyle(
                        fontFamily: kTheArabicSansLight,
                        fontSize: 16.55.sp,
                        fontWeight: FontWeight.w400,
                        color: kGrayColor),
                  ),
                  Text(
                    'اللون : أزرق غامق  ',
                    style: TextStyle(
                        fontFamily: kTheArabicSansLight,
                        fontSize: 16.55.sp,
                        fontWeight: FontWeight.w500,
                        color: kGrayColor),
                  ),
                  SizedBox(
                    height: 40.h,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      height: 46.7.h,
                      width: 123.53.w,
                      decoration: BoxDecoration(
                        border: Border.all(width: 1.w, color: kTextGrayColor),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          IconButton(
                              onPressed: () {
                                productController.increment();
                              },
                              icon: const Icon(
                                Icons.add,
                                color: kBlackColor,
                                size: 30,
                              )),
                          Obx(() => Text(
                                '${productController.count}',
                                style: TextStyle(
                                    color: kBlackColor,
                                    fontSize: 21.92.sp,
                                    fontWeight: FontWeight.w600),
                              )),
                          IconButton(
                              onPressed: () {
                                productController.decrement();
                              },
                              icon: Image.asset(
                                kdeleteiconImage,
                                height: 22.01.h,
                                width: 19.26.w,
                              ))
                        ],
                      ),
                    ),
                  ),
                  const Divider(
                    thickness: 1,
                    color: kTextGrayColor,
                  ),
                  SizedBox(
                    height: 18.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'عدد العناصر(1) ',
                        style: TextStyle(
                            fontFamily: kTheArabicSansLight,
                            fontSize: 21.sp,
                            fontWeight: FontWeight.w400,
                            color: kPrimaryColor),
                      ),
                      Text(
                        'الإجمالي: 40.00 دل ',
                        style: TextStyle(
                            fontFamily: kTheArabicSansLight,
                            fontSize: 21.sp,
                            fontWeight: FontWeight.w700,
                            color: kPrimaryColor),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 51.h,
                  ),
                  Container(
                    height: 53.58.h,
                    width: 398.w,
                    decoration: BoxDecoration(
                        border: Border.all(width: 1.w, color: kPrimaryColor),
                        color: klPinkColor,
                        borderRadius: BorderRadius.circular(13.r)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 13.3.w,
                        ),
                        Image.asset(kdiscountImage),
                        Text(
                          'أدخــل رمز التخفيض',
                          style: TextStyle(
                              fontFamily: kTheArabicSansLight,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w500,
                              color: kWhiteColor),
                        ),
                        Container(
                          height: 52.7.h,
                          width: 124.28.w,
                          decoration: BoxDecoration(
                            color: kPrimaryColor,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(13.r),
                                bottomLeft: Radius.circular(13.r)),
                          ),
                          child: Center(
                            child: Text(
                              'إستخدام',
                              style: TextStyle(
                                  fontFamily: kTheArabicSansLight,
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w600,
                                  color: kWhiteColor),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: 35.h),
        child: FloatingActionButton.extended(
          onPressed: () {},
          label: Container(
            height: 157.07.h,
            width: 431.77.w,
            decoration: BoxDecoration(color: kWhiteColor, boxShadow: [
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
                SizedBox(width: 30.w),
                Text.rich(TextSpan(children: [
                  TextSpan(
                    text: 'المجموع\n',
                    style: TextStyle(
                        fontFamily: kTheArabicSansLight,
                        fontSize: 18.83.sp,
                        fontWeight: FontWeight.w500,
                        color: klPinkColor),
                  ),
                  TextSpan(
                    text: '40.00دل',
                    style: TextStyle(
                        fontFamily: kTheArabicSansLight,
                        fontSize: 34.01.sp,
                        fontWeight: FontWeight.w400,
                        color: kPrimaryColor),
                  )
                ])),
                GestureDetector(
                  onTap: () {
                    Get.to(() => const TabView());
                  },
                  child: Container(
                    height: 62.7.h,
                    width: 220.w,
                    decoration: BoxDecoration(
                      color: kPrimaryColor,
                      borderRadius: BorderRadius.circular(46.r),
                    ),
                    child: Center(
                      child: Text(
                        'الإستمرار',
                        style: TextStyle(
                            fontFamily: kTheArabicSansLight,
                            fontSize: 23.sp,
                            fontWeight: FontWeight.w500,
                            color: kWhiteColor),
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
