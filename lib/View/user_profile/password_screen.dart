import 'package:beauty_queen/widgets/based/custom_button_2.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
//import 'package:firebase_crashlytics/firebase_crashlytics.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../const/app_colors.dart';
import '../../const/styles.dart';
import '../../const/validator.dart';
import '../../controller/auth_controller/auth_controler.dart';
import '../../widgets/auth_widgets/text_field_auth_widget.dart';
import '../../widgets/based/error_pop_up.dart';
import '../../widgets/based/loading.dart';
import '../auth_view/login_page.dart';

class PasswordScreen extends StatefulWidget {
  const PasswordScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _PasswordScreen();
  }
}

class _PasswordScreen extends State<PasswordScreen> {
  TextEditingController currentPasswordController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController rePasswordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AuthController controller = Get.put(AuthController());

  _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();
    try {
      LoadingScreen.show(context);

      await controller.applyToChangePassword(
          currentPassword: currentPasswordController.text,
          newPassword: passwordController.text,
          reNewPassword: rePasswordController.text);
      if (!context.mounted) return;

      Navigator.of(context).pop();
      ErrorPopUp(
          message: tr('update_success'), title: tr('message'), isError: false);
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const LogInPage(),
          ),
          (route) => false);
    } on DioError catch (e) {
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
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: AppColors.kWhiteColor,
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: AppColors.kWhiteColor,
        actions: [
          IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(
                Icons.arrow_forward_ios,
                size: 30.r,
                color: AppColors.kBlackColor,
              )),
        ],
        title: Text(
          tr('kPasswordHint'),
          style: TextStyle(
              fontFamily: kTheArabicSansLight,
              color: AppColors.kBlackColor,
              fontSize: 27.sp,
              fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 22.h,
                  ),
                  TextFieldAuthWidget(
                    hindText: tr('currentPassword'),
                    titleText: tr('currentPassword'),
                    controler: currentPasswordController,
                    hintStyle: TextStyle(
                      color: const Color(0xFF2C3E50),
                      fontSize: 17.69.sp,
                      fontFamily: kTheArabicSansLight,
                      fontWeight: FontWeight.w600,
                    ),
                    obscureText: controller.passwordObscureText.value,
                    keyboardType: TextInputType.phone,
                    validatorTextField: (val) {
                      return Validator().validatorPassword(val);
                    },
                  ),
                  SizedBox(height: 15.h),
                  Obx(() => TextFieldAuthWidget(
                        hindText: tr('enterNewPassword'),
                        titleText: tr('enterNewPassword'),
                        controler: passwordController,
                        hintStyle: TextStyle(
                          color: const Color(0xFF2C3E50),
                          fontSize: 17.69.sp,
                          fontFamily: kTheArabicSansLight,
                          fontWeight: FontWeight.w600,
                        ),
                        obscureText: controller.passwordObscureText.value,
                        keyboardType: TextInputType.phone,
                        validatorTextField: (val) {
                          return Validator().validatorPassword(val);
                        },
                        suffixWidget: IconButton(
                          icon: Icon(
                            controller.passwordObscureText.value
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: AppColors.kTextGrayColor,
                          ),
                          onPressed: controller.toggleSignUpPasswordVisibility,
                        ),
                      )),
                  SizedBox(height: 15.h),
                  Obx(() => TextFieldAuthWidget(
                        hindText: tr('enterNewPassword2'),
                        titleText: tr('enterNewPassword2'),
                        controler: rePasswordController,
                        obscureText:
                            controller.confirmPasswordObscureText.value,
                        hintStyle: TextStyle(
                          color: const Color(0xFF2C3E50),
                          fontSize: 17.69.sp,
                          fontFamily: kTheArabicSansLight,
                          fontWeight: FontWeight.w600,
                        ),
                        suffixWidget: IconButton(
                          icon: Icon(
                            controller.confirmPasswordObscureText.value
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: AppColors.kTextGrayColor,
                          ),
                          onPressed:
                              controller.toggleSignUpConfirmPasswordVisibility,
                        ),
                        keyboardType: TextInputType.phone,
                        validatorTextField: (val) {
                          return Validator().validatorRePassword(
                              val, passwordController.text);
                        },
                      )),
                  SizedBox(height: 35.h),
                  GestureDetector(
                    onTap: () {
                      controller.logoutUserData();
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LogInPage(),
                          ),
                          (route) => false);
                    },
                    child: Text(
                      tr('forget_password'),
                      style: TextStyle(
                          fontFamily: kTheArabicSansLight,
                          color: AppColors.kPrimaryColor,
                          fontSize: 21.sp,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  SizedBox(
                    height: 100.h,
                  ),
                  CustomButtonTwo(
                      width: MediaQuery.of(context).size.width,
                      height: 50.h,
                      borderRadius: 47.r,
                      backgroundColor: AppColors.kPrimaryColor,
                      text: tr('save'),
                      onPressed: _submit,
                      textStyle: TextStyle(
                        fontFamily: kTheArabicSansLight,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w700,
                        color: AppColors.kWhiteColor,
                      ))
                ],
              ),
            )),
      ),
    );
  }
}
