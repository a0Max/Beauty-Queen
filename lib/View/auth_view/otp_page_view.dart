import 'package:beauty_queen/View/auth_view/finished_registration.dart';
import 'package:beauty_queen/const/styles.dart';
import 'package:beauty_queen/controller/auth_controller/otp_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../const/colors.dart';
import '../../widgets/custom_button_2.dart';

class OtpPage extends StatefulWidget {
  const OtpPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _OtpPage();
  }
}
class _OtpPage extends State<OtpPage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: kWhiteColor,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(
                Icons.arrow_forward_ios,
                color: kBlackColor,
                size: 25.r,
              )),
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.black, // Set icon color to black here
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(16.r),
            child: const OTPWidget(),
          ),
        ),
      ),
    );
  }
}

class OTPWidget extends StatelessWidget {
  const OTPWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final OTPController otpController = Get.put(OTPController());
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            "assets/images/code_lock.png",
            height: 50.h,
            width: 208.79.w,
          ),
          SizedBox(
            height: 20.h,
          ),
          SizedBox(
            width: 381.51.w,
            child: Text.rich(
              TextSpan(
                children: [
                  _buildTextSpan(
                      'الرجاء إدخال الرمز المكون من 6 أرقام المرسل إلى',
                      0xFFAAAAAA,
                      TextStyle(
                          fontFamily: kTheArabicSansLight,
                          fontSize: 16.59.sp,
                          fontWeight: FontWeight.w300,
                          color: kTextGrayColor)),
                  _buildTextSpan(
                      ' 21 54 558 092',
                      0xFF171617,
                      TextStyle(
                          fontFamily: kTheArabicSansLight,
                          fontSize: 19.59.sp,
                          fontWeight: FontWeight.w600,
                          color: kBlackColor)),
                ],
              ),
              textAlign: TextAlign.right,
            ),
          ),

          SizedBox(height: 21.h),
          Container(
            width: 176.61.w,
            height: 33.h,
            margin: EdgeInsets.only(bottom: 20.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'رقم غير صحيح؟',
                  style: TextStyle(
                    color: const Color(0xFF1A1C1E),
                    fontWeight: FontWeight.w600,
                    fontSize: 17.53.sp,
                    fontFamily: kTheArabicSansLight,
                  ),
                ),
                SizedBox(
                    width: 8
                        .w), // Adjust the spacing between the texts as necessary
                Text(
                  'تعديل',
                  style: TextStyle(
                    fontSize: 19.59.sp,
                    fontFamily: kTheArabicSansLight,
                    color: const Color(0xFFDE4747),
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              buildOTPField(context, otpController.focusNode1,
                  otpController.focusNode2, otpController.isFocused1),
              buildOTPField(context, otpController.focusNode2,
                  otpController.focusNode3, otpController.isFocused2),
              buildOTPField(context, otpController.focusNode3,
                  otpController.focusNode4, otpController.isFocused3),
              buildOTPField(context, otpController.focusNode4, null,
                  otpController.isFocused4),
            ],
          ),

          SizedBox(height: 26.h), // Optional: add some vertical spacing
          GestureDetector(
            onTap: () {},
            child: Text(
              'سيتم إعادة إرسال الرمز في 00:59',
              textAlign: TextAlign.center, // Align the text to the center
              style: TextStyle(
                color: const Color(0xFFC2C2C2),
                fontSize: 16.50.sp,
                fontFamily: kTheArabicSansLight,
                fontWeight: FontWeight.w400,
                // Adjusted the height to 1.0 instead of 0 to prevent potential issues
              ),
            ),
          ),
          SizedBox(
            height: 12.h,
          ),
          CustomButtonTwo(
              width: 395.27.w,
              height: 59.7.h,
              borderRadius: 8.84.r,
              backgroundColor: kPrimaryColor,
              text: "تحقق",
              onPressed: () {
                Get.to(const CongratulationsPage());
              },
              textStyle: TextStyle(
                fontFamily: kTheArabicSansLight,
                fontSize: 20.85.sp,
                fontWeight: FontWeight.w500,
                color: kWhiteColor,
              )),
        ],
      ),
    );
  }

  TextSpan _buildTextSpan(String text, int color, TextStyle? textStyle) {
    return TextSpan(
      text: text,
      style: textStyle,
    );
  }

  Widget buildOTPField(BuildContext context, FocusNode focusNode,
      FocusNode? nextFocusNode, RxBool isFocused) {
    return Obx(
      () => Container(
        width: 75.27.w,
        height: 93.83.h,
        margin: EdgeInsets.symmetric(vertical: 5.h),
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            side: BorderSide(
              width: 1.5.w,
              color: Color(
                isFocused.value ? 0xFFDE0F7E : 0xFFEAE8E8,
              ),
            ),
            borderRadius: BorderRadius.circular(12.37.r),
          ),
        ),
        child: Center(
          child: TextFormField(
            focusNode: focusNode,
            decoration: const InputDecoration(
              border: InputBorder.none,
              counterText: "",
            ),
            style: TextStyle(fontSize: 24.sp),
            textAlign: TextAlign.center,
            maxLength: 1,
            onChanged: (value) {
              if (value.length == 1 && nextFocusNode != null) {
                FocusScope.of(context).requestFocus(nextFocusNode);
              }
            },
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly,
            ],
          ),
        ),
      ),
    );
  }
}
