import 'package:beauty_queen/const/colors.dart';
import 'package:beauty_queen/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../const/styles.dart';
import '../widgets/CustomDropDownTextFIled.dart';
import '../widgets/CustomFormField.dart';

class MyDataScreen extends StatelessWidget {
  const MyDataScreen({super.key});

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
          "بياناتي",
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
                height: 68.h,
              ),
              Row(
                children: [
                  Text(
                    "الإسم",
                    style: TextStyle(
                        fontFamily: kTheArabicSansLight,
                        color: kBlackColor,
                        fontSize: 21.sp,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    width: 160.w,
                  ),
                  Text(
                    "اللقب",
                    style: TextStyle(
                        fontFamily: kTheArabicSansLight,
                        color: kBlackColor,
                        fontSize: 21.sp,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              SizedBox(
                height: 18.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ReusableTextFormField(
                    height: 64.35.h,
                    width: 160.w,
                  ),
                  ReusableTextFormField(
                    height: 64.35.h,
                    width: 160.w,
                  )
                ],
              ),
              SizedBox(
                height: 28.75.h,
              ),
              Text(
                "تاريخ الميلاد",
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
                height: 28.75.h,
              ),
              ///////////second/////////////
              Text(
                "رقم الهاتف",
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
              ///////////////third////////////
              SizedBox(
                height: 28.75.h,
              ),
              Text(
                "المدينة",
                style: TextStyle(
                    fontFamily: kTheArabicSansLight,
                    color: kBlackColor,
                    fontSize: 21.sp,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 18.h,
              ),
              TextFieldWithDropdown(
                hintText: '',
                dropdownItems: const ['     '],
                selectedDropdownValue: '',
                onDropdownChanged: (String? value) {},
                onTextChanged: (String value) {},
              ),
              SizedBox(
                height: 28.75.h,
              ),
              Text(
                "المنطقة",
                style: TextStyle(
                    fontFamily: kTheArabicSansLight,
                    color: kBlackColor,
                    fontSize: 21.sp,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 18.h,
              ),
              TextFieldWithDropdown(
                hintText: '',
                dropdownItems: const ['     '],
                selectedDropdownValue: '',
                onDropdownChanged: (String? value) {},
                onTextChanged: (String value) {},
              ),
              SizedBox(
                height: 50.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomButton(
                      text: "حفظ",
                      backgroundColor: kPrimaryColor,
                      width: 160.w,
                      height: 58.26.h,
                      borderRadius: 47.34.r,
                      onPressed: () {},
                      textStyle: TextStyle(
                          fontFamily: kTheArabicSansLight,
                          fontSize: 20.85.sp,
                          color: kWhiteColor,
                          fontWeight: FontWeight.w700)),
                  CustomButton(
                      border: Border.all(color: kPrimaryColor, width: 1.56.w),
                      text: "تعديــل",
                      backgroundColor: kWhiteColor,
                      width: 160.w,
                      height: 58.26.h,
                      borderRadius: 47.34.r,
                      onPressed: () {},
                      textStyle: TextStyle(
                          fontFamily: kTheArabicSansLight,
                          fontSize: 20.85.sp,
                          color: kPrimaryColor,
                          fontWeight: FontWeight.w700))
                ],
              ),

              SizedBox(
                height: 60.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
