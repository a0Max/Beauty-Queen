import 'dart:io';

import 'package:beauty_queen/View/auth_view/signUp_page.dart';
import 'package:beauty_queen/View/home/bottom_nav_screen.dart';
import 'package:beauty_queen/View/welcome/welcome_screen.dart';
import 'package:beauty_queen/controller/auth_controller/auth_controler.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
//import 'package:firebase_crashlytics/firebase_crashlytics.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../const/app_colors.dart';
import '../../const/app_images.dart';
import '../../const/styles.dart';
import '../../const/validator.dart';
import '../../widgets/auth_widgets/text_field_auth_widget.dart';
import '../../widgets/based/error_pop_up.dart';
import '../../widgets/based/loading.dart';
import '../../widgets/auth_widgets/loginVia.dart';
import 'enter_phone_screen.dart';
import 'otp_page_view.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _LogInPage();
  }
}

class _LogInPage extends State<LogInPage> {
  final AuthController _controller = Get.put(AuthController());
  // 0927386249
  TextEditingController phoneController =
      TextEditingController(text: kDebugMode ? "0922255002" : "");
  // 012895550899
  TextEditingController passwordController =
      TextEditingController(text: kDebugMode ? "moly123456" : "");
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();
    try {
      LoadingScreen.show(context);

      await _controller.login(phoneController.text, passwordController.text);
      if (!context.mounted) return;

      Navigator.of(context).pop();

      if (_controller.userData.value.isPhoneVerified == "0") {
        Get.to(OtpPage(
          phone: _controller.userData.value.phone ?? '',
        ));
      } else {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const MainView(),
            ),
            (route) => false);
      }
    } on DioException catch (e) {
      if (!context.mounted) return;

      Navigator.of(context).pop();
      ErrorPopUp(
          message: (e.response?.data as Map).values.first, title: tr('Error'));
    } catch (e, s) {
      //  FirebaseCrashlytics.instance.recordError('Api Crash $e', s);
      if (!context.mounted) return;

      Navigator.of(context).pop();
      ErrorPopUp(message: tr('something_wrong'), title: tr('Error'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: SafeArea(
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(55.93.h),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(),
                  SvgPicture.asset(
                    AppImages.imageLogoLogin,
                    height: 55.93.h,
                    width: 166.08.w,
                    fit: BoxFit.cover,
                  ),
                  IconButton(
                      onPressed: () {
                        Get.off(const WelcomeScreen());
                      },
                      icon: Icon(
                        Icons.arrow_forward_ios,
                        color: AppColors.kBlackColor,
                        size: 25.r,
                      )),
                ],
              ),
            ),
          ),
          body: Padding(
            padding: EdgeInsets.all(16.r),
            child: SingleChildScrollView(
              child: Form(
                  key: _formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 60.h),
                      Text(
                        tr('kWelcomeBack'),
                        style: TextStyle(
                          color: AppColors.kTextBlackColor,
                          fontSize: 28.74.sp,
                          fontFamily: kTheArabicSansLight,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 38.h),
                      TextFieldAuthWidget(
                        hindText: tr('kEnterYourPhoneNumber'),
                        titleText: tr('kPhoneNumber'),
                        controler: phoneController,
                        keyboardType: TextInputType.phone,
                        validatorTextField: (val) {
                          return Validator().validatorPhoneNumber(val);
                        },
                      ),
                      SizedBox(height: 17.h),
                      Obx(() => TextFieldAuthWidget(
                            hindText: tr('kEnterYourPassword'),
                            titleText: tr('kPassword'),
                            controler: passwordController,
                            keyboardType: TextInputType.text,
                            obscureText: _controller.obscureText.value,
                            suffixWidget: IconButton(
                              icon: Icon(
                                _controller.obscureText.value
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: AppColors.kTextGrayColor,
                              ),
                              onPressed: _controller.togglePasswordVisibility,
                            ),
                            validatorTextField: (val) {
                              return Validator().validatorPassword(val);
                            },
                          )),
                      SizedBox(height: 17.h),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: GestureDetector(
                          onTap: () => Get.to(const EnterPhoneScreen()),
                          child: Text(
                            tr('kForgotPassword'),
                            style: TextStyle(
                              color: AppColors.kSecondaryColor,
                              fontSize: 14.sp,
                              fontFamily: kTheArabicSansLight,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 38.h),
                      GestureDetector(
                        onTap: () {
                          _submit();
                        },
                        child: Container(
                          height: 59.70.h,
                          decoration: ShapeDecoration(
                            color: AppColors.kPrimaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.84),
                            ),
                          ),
                          child: Center(
                            child: Text(tr('kLogin'),
                                style: TextStyle(
                                    fontSize: 22.11.sp,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.kWhiteColor,
                                    fontFamily: kTheArabicSansLight)),
                          ),
                        ),
                      ),
                      SizedBox(height: 40.h),
                      if (Platform.isAndroid) ...{
                        const LoginVia(),
                        SizedBox(
                          height: 20.h,
                        ),
                      },
                      Center(
                        child: GestureDetector(
                          onTap: () {
                            Get.off(const SignUpPage());
                          },
                          child: Text(
                            tr('kDoNotHaveAnAccount'),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: AppColors.kPrimaryColor,
                                fontSize: 18.sp,
                                fontFamily: kTheArabicSansLight,
                                fontWeight: FontWeight.w700,
                                decoration: TextDecoration.underline,
                                decorationColor: AppColors.kPrimaryColor),
                          ),
                        ),
                      ),
                    ],
                  )),
            ),
          ),
        ),
      ),
    );
  }
}
