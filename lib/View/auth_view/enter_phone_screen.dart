import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../const/app_colors.dart';
import '../../const/styles.dart';
import '../../const/validator.dart';
import '../../controller/auth_controller/otp_controller.dart';
import '../../widgets/auth_widgets/text_field_auth_widget.dart';
import '../../widgets/based/error_pop_up.dart';
import '../welcome/welcome_screen.dart';
import 'otp_page_view.dart';

class EnterPhoneScreen extends StatefulWidget {
  const EnterPhoneScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _EnterPhoneScreen();
  }
}

class _EnterPhoneScreen extends State<EnterPhoneScreen> {
  TextEditingController phoneController =
      TextEditingController(text: kDebugMode ? '0927386249' : '');
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();
    try {
      // LoadingScreen.show(context);

      // await _controller.updatePhone(phone:phoneController.text);
      // if (!context.mounted) return;

      // Navigator.of(context).pop();

      Get.off(
        OtpPage(phone: phoneController.text, isForget: true),
      );
    } on DioException catch (e) {
      if (!context.mounted) return;

      Navigator.of(context).pop();
      ErrorPopUp(
          message: (e.response?.data as Map).values.first, title: tr('Error'));
    } catch (e) {
      if (!context.mounted) return;

      Navigator.of(context).pop();
      ErrorPopUp(message: tr('something_wrong'), title: tr('Error'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        surfaceTintColor: AppColors.kWhiteColor,
        automaticallyImplyLeading: false,
        actions: [
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
      body: Padding(
          padding: EdgeInsets.all(16.r),
          child: SingleChildScrollView(
              child: Form(
                  key: _formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          tr('backPassword'),
                          style: TextStyle(
                            color: AppColors.kBlackColor,
                            fontSize: 29.78.sp,
                            fontFamily: 'TheSans',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(tr('backYourAccount'),
                            style: TextStyle(
                                fontFamily: kTheArabicSansLight,
                                fontSize: 19.59.sp,
                                fontWeight: FontWeight.w300,
                                color: AppColors.kTextGrayColor)),
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
                              child: Text(tr('continuation'),
                                  style: TextStyle(
                                      fontSize: 22.11.sp,
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.kWhiteColor,
                                      fontFamily: kTheArabicSansLight)),
                            ),
                          ),
                        ),
                      ])))),
    );
  }
}
