import 'package:beauty_queen/const/images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../const/colors.dart';
import '../const/styles.dart';
import '../models/sales_products_model.dart';
import '../widgets/CustomCardWidget.dart';

class TabScreenOne extends StatelessWidget {
  const TabScreenOne({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 30.h,
        ),
        Text(
          textAlign: TextAlign.justify,
          "اكتشفي جميع فوائد احمر خدود Bye Bye Pores  الأكثر مبيعًا والحائز على العديد من جوائز الجمال.",
          style: TextStyle(
              fontFamily: kTheArabicSansLight,
              fontSize: 15.sp,
              fontWeight: FontWeight.w400,
              color: kBlackColor),
        ),
        SizedBox(
          height: 17.h,
        ),
        Text(
          textAlign: TextAlign.justify,
          'اكتشفي جميع فوائد احمر خدود Bye Bye Pores  الأكثر مبيعًا والحائز على العديد من جوائز الجمال.اكتشفي جميع فوائد احمر خدود Bye Bye Pores  الأكثر مبيعًا والحائز على العديد من جوائز الجمال.اكتشفي جميع فوائد احمر خدود Bye Bye Pores ',
          style: TextStyle(
              fontFamily: kTheArabicSansLight,
              fontSize: 15.sp,
              fontWeight: FontWeight.w400,
              color: kBlackColor),
        ),
        SizedBox(
          height: 17.h,
        ),
        Text(
          textAlign: TextAlign.justify,
          'اكتشفي جميع فوائد احمر خدود Bye Bye Pores  الأكثر مبيعًا والحائز على العديد من جوائز الجمال.اكتشفي جميع فوائد احمر خدود Bye Bye Pores  الأكثر مبيعًا والحائز على العديد من جوائز الجمال.اكتشفي جميع فوائد احمر خدود Bye Bye Pores ',
          style: TextStyle(
              fontFamily: kTheArabicSansLight,
              fontSize: 15.sp,
              fontWeight: FontWeight.w400,
              color: kBlackColor),
        ),
        SizedBox(
          height: 17.h,
        ),
        Divider(
          thickness: 1.w,
          color: kTextGrayColor,
        ),
        SizedBox(
          height: 47.h,
        ),
        Image.asset(kBannerTwoImage),
        SizedBox(
          height: 32.h,
        ),
        Text(
          "منتجات ذات صلة ...",
          style: TextStyle(
              fontFamily: kTheArabicSansLight,
              fontSize: 17.sp,
              fontWeight: FontWeight.w700,
              color: kPrimaryColor),
        ),
        SizedBox(
          height: 21.h,
        ),
         Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomCardWidget(
                imageUrl: kBaseImage,
                imgtxt: 'Makeup Forever',
                price: '150.00',
                des: 'كريم اساس الترا اتش دي السائل من ميكب',
                disprice: '190.00',
                containertxt: 'تحديد الخيارات', newArrival:SalesProductsModel() ),
            CustomCardWidget(
                imageUrl: kLispticImage,
                imgtxt: 'Rare Beauty',
                price: '94.00',
                des: 'طقم فريش اند ديوي للشفاه والخدود من رير بيوتي',
                disprice: '94.00',
                containertxt: 'إضافة إلي السلة', newArrival:SalesProductsModel() ),
          ],
        ),
        SizedBox(
          height: 21.h,
        ),
        Text(
          'إكتشفي هذه الماركة ... ات كوزميتكس',
          style: TextStyle(
              fontSize: 17.sp,
              fontWeight: FontWeight.w700,
              color: kPrimaryColor),
        ),
        SizedBox(
          height: 10.h,
        ),
        Image.asset(kthinkerImage),
        SizedBox(
          height: 19.h,
        ),
        Text(
          'بالاستعانة بآراء ورؤى خبراء التجميل وأطباء الجلد فيما يتعلق بالمكونات، مع نصائح خبراء العناية بالبشرة، تمكنت IT من ابتكار منتجات تعمل على حل مشاكل الب ...',
          style: TextStyle(
              fontFamily: kTheArabicSansLight,
              fontSize: 17.sp,
              fontWeight: FontWeight.w700,
              color: kBlackColor),
        ),
        SizedBox(
          height: 45.h,
        ),
        Center(
          child: Container(
            height: 45.h,
            width: 241.w,
            color: kPrimaryColor,
            child: Center(
              child: Text(
                'عرض التفاصيل وكل المنتجات',
                style: TextStyle(
                    fontFamily: kTheArabicSansLight,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w700,
                    color: kWhiteColor),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 42.h,
        ),
        Text(
          'منتجات من نفس الماركة ...',
          style: TextStyle(
              fontFamily: kTheArabicSansLight,
              fontSize: 17.sp,
              fontWeight: FontWeight.w700,
              color: kPrimaryColor),
        ),
        SizedBox(
          height: 19.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomCardWidget(
                imageUrl: kBaseImage,
                imgtxt: 'Makeup Forever',
                price: '150.00',
                des: 'كريم اساس الترا اتش دي السائل من ميكب',
                disprice: '190.00',
                containertxt: 'تحديد الخيارات', newArrival:SalesProductsModel() ),
            CustomCardWidget(
                imageUrl: kLispticImage,
                imgtxt: 'Rare Beauty',
                price: '94.00',
                des: 'طقم فريش اند ديوي للشفاه والخدود من رير بيوتي',
                disprice: '94.00',
                containertxt: 'إضافة إلي السلة', newArrival:SalesProductsModel() ),
          ],
        ),
        SizedBox(
          height: 80.h,
        ),
      ],
    );
  }
}
