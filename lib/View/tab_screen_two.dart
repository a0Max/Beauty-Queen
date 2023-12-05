import 'dart:developer';

import 'package:beauty_queen/const/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../const/images.dart';
import '../const/styles.dart';
import '../models/sales_products_model.dart';
import '../widgets/CustomAlertBox.dart';
import '../widgets/CustomCardWidget.dart';

class TabScreenTwo extends StatelessWidget {
  const TabScreenTwo({super.key});

  @override
  Widget build(BuildContext context) {
    final RxInt currentRating = 0.obs;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 30.h,
        ),
        TextField(
          maxLines: 5, // Set the maximum lines to 5
          decoration: InputDecoration(
              errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: kPrimaryColor, width: 2.w)),
              disabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: kPrimaryColor, width: 2.w)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: kPrimaryColor, width: 2.w)),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: kPrimaryColor, width: 2.w)),
              hintText: 'أكتب تقييماً...',
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: kPrimaryColor, width: 2.w))),
        ),
        Row(
          children: [
            Text(
              'إضافة صورة',
              style: TextStyle(
                  fontFamily: kTheArabicSansLight,
                  decorationColor: kPrimaryColor,
                  decoration: TextDecoration.underline,
                  fontSize: 17.sp,
                  fontWeight: FontWeight.w400,
                  color: kPrimaryColor),
            ),
            SizedBox(
              width: 26.w,
            ),
            RatingWidget(maxRating: 5, currentRating: currentRating),
          ],
        ),
        SizedBox(
          height: 42.w,
        ),
        GestureDetector(
          onTap: () {
            log("print dailoug");
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return CustomAlertDialog(
                    buttonTwo: false,
                    height: 172.29.h,
                    width: 339.97.w,
                    dilougText:
                        'تم ارسال تقييمك بنجاح. سيتم نشره حال موافقة مسؤولين المتجر عليه',
                    buttonOneText: 'حسناً',
                  );
                });
          },
          child: Container(
            height: 37.83.h,
            width: 131.w,
            color: kPrimaryColor,
            child: Center(
              child: Text(
                'إرسال',
                style: TextStyle(
                    fontFamily: kTheArabicSansLight,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w700,
                    color: kWhiteColor),
              ),
            ),
          ),
        ),
        //////////////////////////////////
        SizedBox(
          height: 42.h,
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
                containertxt: 'إضافة إلي السلة', newArrival:SalesProductsModel() ,),
          ],
        ),
        SizedBox(
          height: 21.h,
        ),
        Text(
          'إكتشفي هذه الماركة ... ات كوزميتكس',
          style: TextStyle(
              fontFamily: kTheArabicSansLight,
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

class RatingWidget extends StatelessWidget {
  final int maxRating;
  final RxInt currentRating;

  const RatingWidget(
      {super.key, required this.maxRating, required this.currentRating});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Row(
        children: List.generate(
          maxRating,
          (index) => IconButton(
            icon: Icon(
              size: 30,
              index < currentRating.value ? Icons.star : Icons.star_border,
              color: index < currentRating.value ? kPrimaryColor : kPinkColor,
            ),
            onPressed: () => currentRating.value = index + 1,
          ),
        ),
      ),
    );
  }
}
