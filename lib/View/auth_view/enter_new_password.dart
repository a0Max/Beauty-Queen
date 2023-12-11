import 'dart:io';

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart' hide Response;
// import 'package:get/get_core/src/get_main.dart';

import '../../const/app_colors.dart';
import '../../const/app_images.dart';
import '../../const/styles.dart';
import '../../const/validator.dart';
import '../../controller/auth_controller/auth_controler.dart';
import '../../controller/auth_controller/otp_controller.dart';
import '../../widgets/auth_widgets/text_field_auth_widget.dart';
import '../../widgets/custom_button_2.dart';
import '../../widgets/error_pop_up.dart';
import '../../widgets/loading.dart';
import '../welcome/welcome_screen.dart';
import 'login_page.dart';

class EnterNewPassword extends StatefulWidget {
  final String phone;

  const EnterNewPassword({super.key, required this.phone});
  @override
  State<StatefulWidget> createState() {
    return _EnterNewPassword();
  }
}

class _EnterNewPassword extends State<EnterNewPassword> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final AuthController _controller = Get.put(AuthController());
  final OTPController otpController = Get.put(OTPController());

  TextEditingController passwordController = TextEditingController();
  TextEditingController rePasswordController = TextEditingController();
  _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();
    try {
      LoadingScreen.show(context);

      await otpController.updatePassword(
          phone: widget.phone,
          password: passwordController.text,
          rePassword: rePasswordController.text);
      // if (!context.mounted) return;

      // Get.back();
      Get.off(const LogInPage());
    } on DioException catch (e, s) {
      Get.back();
      Navigator.of(context).pop();
    } catch (e, s) {
      Navigator.of(context).pop();
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
            ],),
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
                            ),),
                          Text(tr('enterPasswordForYourAccount'),
                              style: TextStyle(
                                  fontFamily: kTheArabicSansLight,
                                  fontSize: 19.59.sp,
                                  fontWeight: FontWeight.w300,
                                  color: AppColors.kTextGrayColor)
                          ),

                          SizedBox(height: 38.h),
                          Obx(() => TextFieldAuthWidget(
                            titleText: tr('kPasswordHint'),
                                hindText: '',
                                controler: passwordController,
                                hintStyle: TextStyle(
                                  color: const Color(0xFF2C3E50),
                                  fontSize: 17.69.sp,
                                  fontFamily: kTheArabicSansLight,
                                  fontWeight: FontWeight.w600,
                                ),
                                obscureText:
                                    _controller.passwordObscureText.value,
                                // keyboardType: TextInputType.phone,
                                validatorTextField: (val) {
                                  return Validator().validatorPassword(val);
                                },
                                suffixWidget: IconButton(
                                  icon: Icon(
                                    _controller.passwordObscureText.value
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: AppColors.kTextGrayColor,
                                  ),
                                  onPressed: _controller
                                      .toggleSignUpPasswordVisibility,
                                ),
                              )),
                          SizedBox(height: 15.h),
                          Obx(() => TextFieldAuthWidget(
                            titleText: tr('kConfirmPasswordHint'),
                            hindText:'',
                            controler: rePasswordController,
                            obscureText:
                                _controller.confirmPasswordObscureText.value,
                            hintStyle: TextStyle(
                              color: const Color(0xFF2C3E50),
                              fontSize: 17.69.sp,
                              fontFamily: kTheArabicSansLight,
                              fontWeight: FontWeight.w600,
                            ),
                            suffixWidget: IconButton(
                              icon: Icon(
                                _controller.confirmPasswordObscureText.value
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: AppColors.kTextGrayColor,
                              ),
                              onPressed: _controller
                                  .toggleSignUpConfirmPasswordVisibility,
                            ),
                            // keyboardType: TextInputType.phone,
                            validatorTextField: (val) {
                              return Validator().validatorRePassword(
                                  val, passwordController.text);
                            },
                          )),
                          const SizedBox(
                            height: 20,
                          ),
                          CustomButtonTwo(
                              width: MediaQuery.of(context).size.width,
                              height: 50.26.h,
                              borderRadius: 8.84.r,
                              backgroundColor: AppColors.kPrimaryColor,
                              text: tr('makeSure'),
                              onPressed:(){ _submit();},
                              textStyle: TextStyle(
                                  fontSize: 20.85.sp,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.kWhiteColor,
                                  fontFamily: kTheArabicSansLight)),
                        ])))));
  }
}
