import 'package:beauty_queen/View/auth_view/finished_registration.dart';
import 'package:beauty_queen/const/styles.dart';
import 'package:beauty_queen/controller/auth_controller/otp_controller.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart' hide TextDirection;
//import 'package:firebase_crashlytics/firebase_crashlytics.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';

import '../../const/app_colors.dart';
import '../../const/app_images.dart';
import '../../widgets/based/custom_button_2.dart';
import '../../widgets/based/error_pop_up.dart';
import '../../widgets/based/loading.dart';
import 'enter_new_password.dart';

class OtpPage extends StatefulWidget {
  final String phone;
  final bool? isForget;
  const OtpPage({super.key, required this.phone, this.isForget});

  @override
  State<StatefulWidget> createState() {
    return _OtpPage();
  }
}

class _OtpPage extends State<OtpPage> {
  final OTPController otpController = Get.put(OTPController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      sendSmsToPhone();
    });
  }

  sendSmsToPhone() async {
    await otpController.updatePhone(phone: widget.phone);
  }

  final TextEditingController _controller = TextEditingController();
  String? _otp;

  checkOTP() async {
    try {
      LoadingScreen.show(context);

      await otpController.checkTheOtp(sms: _otp ?? '');
      if (widget.isForget == true) {
        Get.back();
        Get.to(
          () => EnterNewPassword(
            phone: widget.phone,
          ),
        );
      } else {
        Get.back();
        Get.off(
          const CongratulationsPage(),
        );
      }
    } on DioException catch (e) {
      if (!context.mounted) return;

      Get.back();
      ErrorPopUp(
          message: (e.response?.data as Map).values.first, title: tr('Error'));
    } catch (e, s) {
      //  FirebaseCrashlytics.instance.recordError('Api Crash $e', s);
      if (!context.mounted) return;

      Get.back();
      ErrorPopUp(message: tr('something_wrong'), title: tr('Error'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: AppColors.kWhiteColor,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () {
                // Get.back();
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_forward_ios,
                color: AppColors.kBlackColor,
                size: 25.r,
              )),
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: AppColors.kBlackColor, // Set icon color to black here
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    SvgPicture.asset(
                      AppImages.imageLockOfOtp,
                      height: 50.h,
                      // width: 208.79.w,
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Text(
                      tr('activate_code'),
                      style: TextStyle(
                        color: AppColors.kBlackColor,
                        fontSize: 29.78.sp,
                        fontFamily: 'TheSans',
                        fontWeight: FontWeight.w400,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 10.h,
                ),
                Directionality(
                  // add this
                  textDirection: TextDirection.rtl,
                  child: Text.rich(
                    TextSpan(
                      children: [
                        _buildTextSpan(
                            tr('please_enter_the4_digit_of_otp'),
                            TextStyle(
                                fontFamily: kTheArabicSansLight,
                                fontSize: 19.59.sp,
                                fontWeight: FontWeight.w300,
                                color: AppColors.kTextGrayColor)),
                        _buildTextSpan(
                            ' ${widget.phone}',
                            TextStyle(
                                fontFamily: kTheArabicSansLight,
                                fontSize: 19.59.sp,
                                fontWeight: FontWeight.w600,
                                color: AppColors.kBlackColor)),
                      ],
                    ),
                    textAlign: TextAlign.right,
                  ),
                ),
                SizedBox(height: 10.h),
                Container(
                  // width: 176.61.w,
                  height: 33.h,
                  margin: EdgeInsets.only(bottom: 20.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        tr('phone_not_correct'),
                        style: TextStyle(
                          color: AppColors.klightBlackColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 19.53.sp,
                          fontFamily: kTheArabicSansLight,
                        ),
                      ),
                      SizedBox(
                          width: 8
                              .w), // Adjust the spacing between the texts as necessary
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          tr('edit'),
                          style: TextStyle(
                              fontSize: 17.59.sp,
                              fontFamily: kTheArabicSansLight,
                              color: AppColors.redColor,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                              decorationColor: AppColors.redColor),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.center,
                  child: PinCodeTextField(
                    isCupertino: true,
                    autofocus: true,
                    controller: _controller,
                    highlight: true,
                    highlightColor: AppColors.kPrimaryColor,
                    defaultBorderColor: AppColors.kCDGColor,
                    hasTextBorderColor: AppColors.kCDGColor,
                    maxLength: 4,
                    pinBoxOuterPadding:
                        const EdgeInsets.symmetric(horizontal: 15),
                    hasError: false,
                    pinBoxColor: Theme.of(context).scaffoldBackgroundColor,
                    pinBoxRadius: 13,
                    pinBoxBorderWidth: 1,
                    onTextChanged: (text) {
                      _otp = text;
                    },
                    onDone: (text) {
                      checkOTP();
                    },
                    pinBoxWidth: (MediaQuery.of(context).size.width - 180) / 4,
                    pinBoxHeight: 75,
                    wrapAlignment: WrapAlignment.spaceAround,
                    pinBoxDecoration:
                        ProvidedPinBoxDecoration.defaultPinBoxDecoration,
                    pinTextAnimatedSwitcherTransition:
                        ProvidedPinBoxTextAnimation.scalingTransition,
                    pinTextAnimatedSwitcherDuration:
                        const Duration(milliseconds: 300),
                    highlightAnimationBeginColor: Colors.black,
                    highlightAnimationEndColor: Colors.white12,
                    keyboardType: TextInputType.number,
                  ),
                ),

                SizedBox(height: 16.h), // Optional: add some vertical spacing
                Obx(() => GestureDetector(
                      onTap: () {
                        if (otpController.initialCountdownSeconds.value == 0) {
                          sendSmsToPhone();
                        }
                      },
                      child: otpController.initialCountdownSeconds.value == 0
                          ? Text(
                              tr('Resend'),
                              style: TextStyle(
                                // color: AppColors.kCDGColor,
                                fontSize: 16.50.sp,
                                fontFamily: kTheArabicSansLight,
                                fontWeight: FontWeight.w400,
                                // Adjusted the height to 1.0 instead of 0 to prevent potential issues
                              ),
                            )
                          : Text(
                              '${tr('will_send_the_otp_again')} ${"${(otpController.initialCountdownSeconds.value ~/ 60).toString().padLeft(2, '0')}:${(otpController.initialCountdownSeconds.value % 60).toString().padLeft(2, '0')}"}',
                              textAlign: TextAlign
                                  .center, // Align the text to the center
                              style: TextStyle(
                                color: AppColors.kCDGColor,
                                fontSize: 16.50.sp,
                                fontFamily: kTheArabicSansLight,
                                fontWeight: FontWeight.w400,
                                // Adjusted the height to 1.0 instead of 0 to prevent potential issues
                              ),
                            ),
                    )),
                SizedBox(
                  height: 12.h,
                ),
                CustomButtonTwo(
                    width: MediaQuery.of(context).size.width,
                    height: 59.7.h,
                    borderRadius: 8.84.r,
                    backgroundColor: AppColors.kPrimaryColor,
                    text: tr('make_sure'),
                    onPressed: () {
                      checkOTP();
                    },
                    textStyle: TextStyle(
                      fontFamily: kTheArabicSansLight,
                      fontSize: 20.85.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.kWhiteColor,
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  TextSpan _buildTextSpan(String text, TextStyle? textStyle) {
    return TextSpan(
      text: text,
      style: textStyle,
    );
  }
}
