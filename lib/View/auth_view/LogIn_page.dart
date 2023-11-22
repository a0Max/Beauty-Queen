// ignore_for_file: file_names

import 'package:beauty_queen/View/auth_view/signUp_page.dart';
import 'package:beauty_queen/View/bottom_nav_screen.dart';
import 'package:beauty_queen/View/welcome_screen.dart';
import 'package:beauty_queen/controller/auth_controller/login_controler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../const/strings.dart';
import '../../const/colors.dart';
import '../../const/images.dart';
import '../../const/styles.dart';
import '../../widgets/loginVia.dart';

class LogInPage extends StatelessWidget {
  final LogInController _controller = Get.put(LogInController());

  LogInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            centerTitle: true,
            surfaceTintColor: kWhiteColor,
            automaticallyImplyLeading: false,
            actions: [
              IconButton(
                  onPressed: () {
                    Get.off(const WelcomeScreen());
                  },
                  icon: Icon(
                    Icons.arrow_forward_ios,
                    color: kBlackColor,
                    size: 25.r,
                  )),
            ],
            title: Image.asset(
              kBeautyQueenLogoPath,
              height: 55.93.h,
              width: 166.08.w,
            )),
        body: Padding(
          padding: EdgeInsets.all(16.r),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 60.h),
                Text(
                  kWelcomeBack,
                  style: TextStyle(
                    color: const Color(0xFF27292A),
                    fontSize: 28.74.sp,
                    fontFamily: kTheArabicSansLight,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 38.h),
                Text(
                  kPhoneNumber,
                  style: TextStyle(
                    color: const Color(0xFF2C3E50),
                    fontSize: 18.79.sp,
                    fontFamily: kTheArabicSansLight,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 10.h),
                SizedBox(
                  height: 63.02.h,
                  width: 395.8.w,
                  child: TextField(
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      hintText: kEnterYourPhoneNumber,
                      hintStyle: TextStyle(
                        color: const Color(0xFFD5D5D5),
                        fontSize: 17.69.sp,
                        fontFamily: kTheArabicSansLight,
                        fontWeight: FontWeight.w600,
                        height: 0.08.h,
                      ),
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 20.h, horizontal: 15.w),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(11.06.r),
                        borderSide: BorderSide(
                            width: 1.11.w, color: const Color(0xFFD9DEE2)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(11.06.r),
                        borderSide: BorderSide(
                            width: 1.11.w, color: const Color(0xFFD9DEE2)),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 17.h),
                Text(
                  kPassword,
                  style: TextStyle(
                    color: const Color(0xFF2C3E50),
                    fontSize: 18.79.sp,
                    fontFamily: kTheArabicSansLight,
                    fontWeight: FontWeight.w400,
                    height: 1.08.h,
                  ),
                ),
                SizedBox(height: 10.h),
                Obx(
                  () => SizedBox(
                    height: 63.02.h,
                    width: 395.8.w,
                    child: TextField(
                      obscureText: _controller.obscureText.value,
                      decoration: InputDecoration(
                        hintText: kEnterYourPassword,
                        hintStyle: TextStyle(
                          color: const Color(0xFFD5D5D5),
                          fontSize: 17.69.sp,
                          fontFamily: kTheArabicSansLight,
                          fontWeight: FontWeight.w600,
                          height: 0.08,
                        ),
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 20.h, horizontal: 15.w),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(11.06.r),
                          borderSide: BorderSide(
                              width: 1.11.w, color: const Color(0xFFD9DEE2)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(11.06.r),
                          borderSide: BorderSide(
                              width: 1.11.w, color: const Color(0xFFD9DEE2)),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _controller.obscureText.value
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: kTextGrayColor,
                          ),
                          onPressed: _controller.togglePasswordVisibility,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 17.h),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    kForgotPassword,
                    style: TextStyle(
                      color: const Color(0xFF2C3E50),
                      fontSize: 17.69.sp,
                      fontFamily: kTheArabicSansLight,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                SizedBox(height: 38.h),
                GestureDetector(
                  onTap: () {
                    Get.off(const MainView());
                  },
                  child: Container(
                    width: 395.79.w,
                    height: 59.70.h,
                    decoration: ShapeDecoration(
                      color: const Color(0xFFDE0F7E),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.84),
                      ),
                    ),
                    child: Center(
                      child: Text(kLogin,
                          style: TextStyle(
                              fontSize: 22.11.sp,
                              fontWeight: FontWeight.w400,
                              color: kWhiteColor,
                              fontFamily: kTheArabicSansLight)),
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                const LoginVia(),
                SizedBox(
                  height: 38.h,
                ),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      Get.off(SignUpPage());
                    },
                    child: SizedBox(
                      height: 30.h,
                      width: 200.w,
                      child: Text(
                        kDoNotHaveAnAccount,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: const Color(0xFFDE0F7E),
                            fontSize: 21.01.sp,
                            fontFamily: kTheArabicSansLight,
                            fontWeight: FontWeight.w700,
                            decoration: TextDecoration.underline,
                            decorationColor: kPrimaryColor),
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
