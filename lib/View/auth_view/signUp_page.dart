// ignore_for_file: file_names

import 'package:beauty_queen/View/auth_view/otp_page_view.dart';
import 'package:beauty_queen/View/welcome_screen.dart';
import 'package:beauty_queen/controller/auth_controller/signUpcontroller.dart';
import 'package:beauty_queen/widgets/custom_button_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../const/strings.dart';
import '../../const/colors.dart';
import '../../const/styles.dart';
import '../../widgets/CustomTextField.dart';
import '../../widgets/loginVia.dart';
import 'LogIn_page.dart';

class SignUpPage extends StatelessWidget {
  final CombinedController combinedController = CombinedController();
  final ScrollController scrollController = ScrollController();
  SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: kWhiteColor,
        surfaceTintColor: kWhiteColor,
        elevation: 0,
        toolbarHeight: 40.h,
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
      ),
      body: Padding(
        padding: EdgeInsets.all(16.r),
        child: SingleChildScrollView(
          controller: scrollController,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 15.h,
                  ),
                  Text(
                    kWelcome,
                    style: TextStyle(
                      fontSize: 29.02.sp,
                      fontFamily: kTheArabicSansLight,
                      color: kBlackColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    kRegisterNow,
                    textAlign: TextAlign.right,
                    style: TextStyle(
                        color: kTextGrayColor,
                        fontFamily: kTheArabicSansLight,
                        fontWeight: FontWeight.w300,
                        fontSize: 18.sp),
                  ),
                  SizedBox(height: 22.h),
                  CustomTextField(
                    hintText: kFirstNameHint,
                    obscureTextObservable: combinedController.nameObscureText,
                    controller: combinedController,
                  ),
                  SizedBox(height: 15.h),
                  CustomTextField(
                    hintText: kPhoneNumberHint,
                    keyboardType: TextInputType.phone,
                    obscureTextObservable: combinedController.phoneObscureText,
                    controller: combinedController,
                  ),
                  SizedBox(height: 15.h),
                  CustomTextField(
                    hintText: kPasswordHint,
                    initialObscureText: true,
                    suffixIcon: Icons.visibility,
                    obscureTextObservable:
                        combinedController.passwordObscureText,
                    controller: combinedController,
                  ),
                  SizedBox(height: 15.h),
                  CustomTextField(
                    hintText: kConfirmPasswordHint,
                    initialObscureText: true,
                    suffixIcon: Icons.visibility,
                    obscureTextObservable:
                        combinedController.confirmPasswordObscureText,
                    controller: combinedController,
                  ),
                  SizedBox(height: 25.h),
                  const LoginVia(),
                  SizedBox(
                    height: 25.h,
                  ),
                ],
              ),
              CustomButtonTwo(
                  width: 398.27.w,
                  height: 64.26.h,
                  borderRadius: 8.84.r,
                  backgroundColor: kPrimaryColor,
                  text: 'التسجيل',
                  onPressed: () {
                    Get.to(const OtpPage());
                  },
                  textStyle: TextStyle(
                      fontSize: 20.85.sp,
                      fontWeight: FontWeight.w700,
                      color: kWhiteColor,
                      fontFamily: kTheArabicSansLight)),
              SizedBox(
                height: 27.h,
              ),
              InkWell(
                onTap: () {
                  Get.to(LogInPage());
                },
                child: Center(
                  child: Text(
                    kAlreadyHaveAccount,
                    style: TextStyle(
                        decoration: TextDecoration.underline,
                        decorationColor: kPrimaryColor,
                        fontFamily: kTheArabicSansLight,
                        fontSize: 21.21.sp,
                        fontWeight: FontWeight.bold,
                        color: kPrimaryColor),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
