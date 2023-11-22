// ignore_for_file: file_names

import 'package:beauty_queen/const/colors.dart';
import 'package:beauty_queen/const/images.dart';
import 'package:beauty_queen/const/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/custom_stack.dart';

class WhatisQuinaScreen extends StatelessWidget {
  const WhatisQuinaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 34.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 14.w),
              child: Text(
                "اجعلي لمشترياتك قيمة اكثر واكثر، فمع برنامج كوينا تسوقي افضل المنتجات واجمعي ملصقات بيوتي كوين لتستبدليها لاحقاً بجوائز قيمة ومزايا حصرية.",
                style: TextStyle(
                  fontFamily: kTheArabicSansLight,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  color: kBlackColor,
                ),
                textAlign: TextAlign.justify,
              ),
            ),
            SizedBox(
              height: 34.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  kflowerImage,
                  height: 89.h,
                  width: 86.w,
                ),
                Image.asset(
                  karrowrightImage,
                  height: 17.57.h,
                  width: 54.w,
                ),
                Image.asset(
                  kbatchesImage,
                  height: 89.h,
                  width: 86.w,
                ),
                Image.asset(
                  karrowrightImage,
                  height: 17.57.h,
                  width: 54.w,
                ),
                Image.asset(
                  kgifImage,
                  height: 89.h,
                  width: 86.w,
                ),
              ],
            ),
            SizedBox(
              height: 30.h,
            ),
            const ImageWithTextOverlay(
              text1: 'كيف اجد ملصقات كوينا؟',
              text2:
                  'انها مخبئة مع مئات المنتجات في الموقع ، لتجديها عليك اولاً ترقية حسابك العادي الى حساب كوينا لتظهر لك هذه الملصقات الوردية واضحة على صور المنتجات المميزة.',
            ),
            SizedBox(
              height: 21.h,
            ),
            const ImageWithTextOverlay(
              text1: 'كيف اجد ملصقات كوينا؟',
              text2:
                  'انها مخبئة مع مئات المنتجات في الموقع ، لتجديها عليك اولاً ترقية حسابك العادي الى حساب كوينا لتظهر لك هذه الملصقات الوردية واضحة على صور المنتجات المميزة.',
            ),
            SizedBox(
              height: 21.h,
            ),
            const ImageWithTextOverlay(
              text1: 'كيف اجد ملصقات كوينا؟',
              text2:
                  'انها مخبئة مع مئات المنتجات في الموقع ، لتجديها عليك اولاً ترقية حسابك العادي الى حساب كوينا لتظهر لك هذه الملصقات الوردية واضحة على صور المنتجات المميزة.',
            ),
            SizedBox(
              height: 21.h,
            ),
            const ImageWithTextOverlay(
              text1: 'كيف اجد ملصقات كوينا؟',
              text2:
                  'انها مخبئة مع مئات المنتجات في الموقع ، لتجديها عليك اولاً ترقية حسابك العادي الى حساب كوينا لتظهر لك هذه الملصقات الوردية واضحة على صور المنتجات المميزة.',
            ),
            SizedBox(
              height: 21.h,
            ),
            const ImageWithTextOverlay(
              text1: 'كيف اجد ملصقات كوينا؟',
              text2:
                  'انها مخبئة مع مئات المنتجات في الموقع ، لتجديها عليك اولاً ترقية حسابك العادي الى حساب كوينا لتظهر لك هذه الملصقات الوردية واضحة على صور المنتجات المميزة.',
            ),
            SizedBox(
              height: 21.h,
            ),
            const ImageWithTextOverlay(
              text1: 'كيف اجد ملصقات كوينا؟',
              text2:
                  'انها مخبئة مع مئات المنتجات في الموقع ، لتجديها عليك اولاً ترقية حسابك العادي الى حساب كوينا لتظهر لك هذه الملصقات الوردية واضحة على صور المنتجات المميزة.',
            ),
            SizedBox(
              height: 21.h,
            ),
            const ImageWithTextOverlay(
              text1: 'كيف اجد ملصقات كوينا؟',
              text2:
                  'انها مخبئة مع مئات المنتجات في الموقع ، لتجديها عليك اولاً ترقية حسابك العادي الى حساب كوينا لتظهر لك هذه الملصقات الوردية واضحة على صور المنتجات المميزة.',
            ),
            SizedBox(
              height: 21.h,
            ),
            const ImageWithTextOverlay(
              text1: 'كيف اجد ملصقات كوينا؟',
              text2:
                  'انها مخبئة مع مئات المنتجات في الموقع ، لتجديها عليك اولاً ترقية حسابك العادي الى حساب كوينا لتظهر لك هذه الملصقات الوردية واضحة على صور المنتجات المميزة.',
            ),
            SizedBox(
              height: 33.h,
            ),
            Image.asset(kbatchImage),
            SizedBox(
              height: 47.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  kImageone,
                  height: 341.11.h,
                  width: 122.51.w,
                ),
                Image.asset(
                  kImagethree,
                  height: 341.11.h,
                  width: 122.51.w,
                ),
                Image.asset(
                  kImagetwo,
                  height: 341.11.h,
                  width: 122.51.w,
                ),
              ],
            ),
            SizedBox(
              height: 27.h,
            ),
            const ImageWithTextOverlay(
              text1: 'كيف اجد ملصقات كوينا؟',
              text2:
                  'انها مخبئة مع مئات المنتجات في الموقع ، لتجديها عليك اولاً ترقية حسابك العادي الى حساب كوينا لتظهر لك هذه الملصقات الوردية واضحة على صور المنتجات المميزة.',
            ),
            SizedBox(
              height: 33.h,
            ),
          ],
        ),
      ),
    );
  }
}
