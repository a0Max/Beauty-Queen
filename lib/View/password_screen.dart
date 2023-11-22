import 'package:beauty_queen/const/colors.dart';
import 'package:beauty_queen/widgets/custom_button_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../const/styles.dart';
import '../widgets/CustomFormField.dart';

class PasswordScreen extends StatelessWidget {
  const PasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: kWhiteColor,
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: kWhiteColor,
        actions: [
          IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(
                Icons.arrow_forward_ios,
                size: 30.r,
                color: kBlackColor,
              )),
        ],
        title: Text(
          "كلمة المرور",
          style: TextStyle(
              fontFamily: kTheArabicSansLight,
              color: kBlackColor,
              fontSize: 27.sp,
              fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 82.h,
              ),
              Text(
                " كلمة المرور الحالية",
                style: TextStyle(
                    fontFamily: kTheArabicSansLight,
                    color: kBlackColor,
                    fontSize: 21.sp,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 18.h,
              ),
              ReusableTextFormField(
                height: 64.35.h,
                width: 398.w,
              ),
              SizedBox(
                height: 30.h,
              ),
              Text(
                'كلمة المرور الجديدة',
                style: TextStyle(
                    fontFamily: kTheArabicSansLight,
                    color: kBlackColor,
                    fontSize: 21.sp,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 18.h,
              ),
              ReusableTextFormField(
                height: 64.35.h,
                width: 398.w,
              ),
              SizedBox(
                height: 30.h,
              ),
              Text(
                'تأكيد كلمة المرور',
                style: TextStyle(
                    fontFamily: kTheArabicSansLight,
                    color: kBlackColor,
                    fontSize: 21.sp,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 18.h,
              ),
              ReusableTextFormField(
                height: 64.35.h,
                width: 398.w,
              ),
              SizedBox(
                height: 30.h,
              ),
              Text(
                'نسيت كلمة المرور؟',
                style: TextStyle(
                    fontFamily: kTheArabicSansLight,
                    color: kPrimaryColor,
                    fontSize: 21.sp,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 100.h,
              ),
              CustomButtonTwo(
                  width: 398.w,
                  height: 68.h,
                  borderRadius: 47.r,
                  backgroundColor: kPrimaryColor,
                  text: "حفظ",
                  onPressed: () {},
                  textStyle: TextStyle(
                    fontFamily: kTheArabicSansLight,
                    fontSize: 22.85.sp,
                    fontWeight: FontWeight.w700,
                    color: kWhiteColor,
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
