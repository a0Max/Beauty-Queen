// ignore_for_file: file_names

import 'package:beauty_queen/const/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../const/colors.dart';
import '../const/images.dart';

class QuinaOffersScreen extends StatelessWidget {
  const QuinaOffersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 35.h,
            ),
            Center(child: Image.asset(kbagImage)),
            SizedBox(
              height: 35.h,
            ),
            Center(
              child: Text('لا توجد أي عروض في الوقت الحالي!',
                  style: TextStyle(
                    fontFamily: kTheArabicSansLight,
                    color: kBlackColor,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w400,
                  )),
            ),
            SizedBox(
              height: 16.h,
            ),
            Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: Text('العروض حصرية لحساب كوينا الذهبي وكوينا الوردي',
                    style: TextStyle(
                      fontFamily: kTheArabicSansLight,
                      color: kTextGrayColor,
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w400,
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
