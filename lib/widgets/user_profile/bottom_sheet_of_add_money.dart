import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../const/app_colors.dart';
import '../../const/images.dart';
import '../../const/styles.dart';

void showModalSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: AppColors.kWhiteColor,
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(
                  Icons.close,
                  size: 30.r,
                  color: AppColors.kPrimaryColor,
                )),
          ],
          title: Text(
            "المحفظة",
            style: TextStyle(
                fontFamily: kTheArabicSansLight,
                color: AppColors.kBlackColor,
                fontSize: 23.74.sp,
                fontWeight: FontWeight.w600),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 50.h,
                ),
                Text(
                  "تعبئة رصيد المحفظة ",
                  style: TextStyle(
                      fontFamily: kTheArabicSansLight,
                      color: AppColors.kPrimaryColor,
                      fontSize: 23.74.sp,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 15.h,
                ),
                Container(
                  height: 68.29.h,
                  width: 398.w,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(13.r),
                      border:
                          Border.all(width: 1, color: AppColors.kPrimaryColor)),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        disabledBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        fillColor: AppColors.klPinkColor,
                        prefixIcon: Image.asset(ksubtractImage),
                        hintText: 'أدخل رقم البطاقة',
                        hintStyle: TextStyle(
                            fontFamily: kTheArabicSansLight,
                            color: AppColors.kPrimaryColor,
                            fontSize: 21.1.sp,
                            fontWeight: FontWeight.w600)),
                  ),
                ),
                SizedBox(
                  height: 100.h,
                ),
                Container(
                  height: 68.h,
                  width: 398.w,
                  decoration: BoxDecoration(
                      color: AppColors.kPrimaryColor,
                      borderRadius: BorderRadius.circular(47.r)),
                  child: Center(
                    child: Text(
                      "تعبئة الرصيد ",
                      style: TextStyle(
                          fontFamily: kTheArabicSansLight,
                          color: AppColors.kWhiteColor,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
