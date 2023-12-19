// ignore_for_file: file_names

import 'package:beauty_queen/const/app_colors.dart';
import 'package:beauty_queen/const/app_images.dart';
import 'package:beauty_queen/const/extensions.dart';
import 'package:beauty_queen/const/images.dart';
import 'package:beauty_queen/const/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../widgets/whats_queen/custom_stack.dart';

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
            Container(
              margin: EdgeInsets.symmetric(horizontal: 14.w),
              child: Text(
                "اجعلي لمشترياتك قيمة اكثر واكثر، فمع برنامج كوينا تسوقي افضل المنتجات واجمعي ملصقات بيوتي كوين لتستبدليها لاحقاً بجوائز قيمة ومزايا حصرية.",
                style: TextStyle(
                  fontFamily: kTheArabicSansLight,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.kBlackColor,
                ),
                textAlign: TextAlign.justify,
              ),
            ),
            SizedBox(
              height: 34.h,
            ),
            Image.asset(AppImages.queena2Image),
            SizedBox(
              height: 30.h,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 14.w),
              child: Column(
                children: [
                  const ImageWithTextOverlay(
                    text1: 'كيف اجد ملصقات كوينا؟',
                    text2:
                        'انها مخبئة مع مئات المنتجات في الموقع ، لتجديها عليك اولاً ترقية حسابك العادي الى حساب كوينا لتظهر لك هذه الملصقات الوردية واضحة على صور المنتجات المميزة.',
                  ),
                  SizedBox(
                    height: 21.h,
                  ),
                  const ImageWithTextOverlay(
                    text1: 'كيف اعرف قيمة ملصقات كوينا؟',
                    text2:
                        'كل منتج مميز يحتوي على عدد معين من الملصقات تختلف قيمتها حسب سعر المنتج ، وهذه القيمة موضحة في صفحة المنتج.',
                  ),
                  SizedBox(
                    height: 21.h,
                  ),
                  const ImageWithTextOverlay(
                    text1: 'كيف اعرف عدد ملصقاتي التي قمت بتجميعها؟',
                    text2:
                        'بالدخول على حسابك والضغط على زر ملصقاتي في اعلى صفحة حسابي، ستجدين العدد الإجمالي للملصقات التي قمتي بتجميعها وكيف حصلتي عليها.',
                  ),
                  SizedBox(
                    height: 21.h,
                  ),
                  const ImageWithTextOverlay(
                    text1:
                        'ما هي الجوائز التي سأحصل عليها مقابل تجميع الملصقات؟',
                    text2:
                        'الكثير والكثير من المزايا والهدايا والخصومات والقيم المالية، والتي تختلف كل مرة حسب عدد الملصقات التي قمتي بتجميعها.',
                  ),
                  SizedBox(
                    height: 21.h,
                  ),
                  const ImageWithTextOverlay(
                    text1: 'متي احصل على الهدايا والجوائز؟',
                    text2:
                        'ستحصلين على الهدايا مع كل مدالية من مداليات كوينا للولاء نمنحك إياها عندما تجمعي عدد الملصقات المطلوب.',
                  ),
                  SizedBox(
                    height: 21.h,
                  ),
                  const ImageWithTextOverlay(
                    text1: 'كيف يمكنني ترقية حسابي الى حساب كوينا؟',
                    text2:
                        'بالدخول على حسابك والضغط على زر ترقية حسابي الموجود اسفل صفحة حسابي وملاء الخانات المعلمة باللون الأحمر ثم مصادقة رقم هاتفك.',
                  ),
                  SizedBox(
                    height: 21.h,
                  ),
                  const ImageWithTextOverlay(
                    text1:
                        'ما هي المزايا التي احصل عليها عند ترقية حسابي الى حساب كوينا؟',
                    text2:
                        'سيصبح لديك محفظتك الخاصة لتوفير المبالغ المالية والدفع منها لاحقاَ و وقتما ترغبين، كما ستحصلين على بوكس الرسائل الخاص بك لتصلك عليه الاشعارات المتعلقة بحسابك، كما ستكون لك الأولوية في ارسال الإعلانات الترويجية الحصرية وعروض التخفيض الخاصة بالإضافة الى اخبار المتجر مسبقاً.',
                  ),
                  SizedBox(
                    height: 21.h,
                  ),
                  const ImageWithTextOverlay(
                    text1: 'ماهي مداليات كوينا؟',
                    text2:
                        'انت ثلاثة مداليات الكترونية، كل مدالية تحصلين عليها بتجميع عدد معين من الملصقات ومعها هدايا ومزايا خاصة موضحة كما في الأسفل.',
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Image.asset(AppImages.lineOfBadgeImage),
            SizedBox(
              height: 20.h,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(child: Image.asset(AppImages.queenaSilverImage)),
                  5.pw,
                  Expanded(child: Image.asset(AppImages.queenaGoldImage)),
                  5.pw,
                  Expanded(child: Image.asset(AppImages.queenaPinkImage))
                ],
              ),
            ),
            SizedBox(
              height: 27.h,
            ),
            const ImageWithTextOverlay(
              text1: 'وماذا بعد حصولي على المدالية الوردية؟',
              text2:
                  'اذا حصلتي على المدالية الوردية فهذا يعني انك حصلتي على مزايا دائمة في موقعنا، والتي تشمل حصولك على هدية مميزة في كل مرة تجمعين فيها 300 ملصق جديد، عروض حصرية لا تظهر الا لحاملي المدالية الوردية، وهدية خاصة في عيد ميلادك، بالإضافة الى مفاجئات جديدة وفعاليات مستمرة لتتميزي معنا دائماً.',
            ),
            SizedBox(
              height: 33.h,
            ),
            Image.asset(AppImages.queenaPageImage)
          ],
        ),
      ),
    );
  }
}
