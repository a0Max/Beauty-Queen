// ignore_for_file: file_names

import 'package:beauty_queen/View/auth_view/otp_page_view.dart';
import 'package:beauty_queen/View/welcome/welcome_screen.dart';
import 'package:beauty_queen/widgets/custom_button_2.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../const/app_colors.dart';
import '../../const/styles.dart';
import '../../const/validator.dart';
import '../../controller/auth_controller/auth_controler.dart';
import '../../widgets/auth_widgets/text_field_auth_widget.dart';
import '../../widgets/error_pop_up.dart';
import '../../widgets/based/loading.dart';
import '../../widgets/loginVia.dart';
import 'login_page.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _SignUpPage();
  }
}
class _SignUpPage extends State<SignUpPage>{
  final AuthController _controller = AuthController();

  final ScrollController scrollController = ScrollController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController rePasswordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();
    try {
      LoadingScreen.show(context);

      await _controller.signUp(phone:phoneController.text,password: passwordController.text, name:nameController.text, rePassword: rePasswordController.text );
      if (!context.mounted) return;

      Navigator.of(context).pop();

      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => OtpPage(phone: phoneController.text,),
          ),
              (route) => false);
    } on DioError catch (e) {
      if (!context.mounted) return;

      Navigator.of(context).pop();

      ErrorPopUp(message: (e.response?.data as Map).values.first, title: tr('Error'));

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
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.kWhiteColor,
        surfaceTintColor: AppColors.kWhiteColor,
        elevation: 0,
        toolbarHeight: 40.h,
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
          controller: scrollController,
          child:Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
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
                    tr('kWelcome'),
                    style: TextStyle(
                      fontSize: 29.02.sp,
                      fontFamily: kTheArabicSansLight,
                      color: AppColors.kBlackColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 5.h),
                  Text(
                    tr('detailsOfSignUp'),
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: AppColors.kCDGColor2,
                      fontSize: 17.21.sp,
                      fontFamily: kTheArabicSansLight,
                      fontWeight: FontWeight.w300,
                      // Adjusted the height to 1.0 instead of 0 to prevent potential issues
                    ),
                  ),
                  SizedBox(height: 10.h),
                  TextFieldAuthWidget(
                    hindText: tr('kFirstNameHint'),
                    controler: nameController,
                    hintStyle: TextStyle(
                      color: const Color(0xFF2C3E50),
                      fontSize: 17.69.sp,
                      fontFamily: kTheArabicSansLight,
                      fontWeight: FontWeight.w600,
                    ),
                    keyboardType: TextInputType.name,
                    validatorTextField: (val) {
                      return Validator().validatorName(val);
                    },
                  ),
                  SizedBox(height: 15.h),
                  TextFieldAuthWidget(
                    hindText: tr('kPhoneNumberHint'),
                    controler: phoneController,
                    hintStyle: TextStyle(
                      color: const Color(0xFF2C3E50),
                      fontSize: 17.69.sp,
                      fontFamily: kTheArabicSansLight,
                      fontWeight: FontWeight.w600,
                    ),
                    keyboardType: TextInputType.phone,
                    validatorTextField: (val) {
                      return Validator().validatorPhoneNumber(val);
                    },
                  ),
                  SizedBox(height: 15.h),
                  Obx(() => TextFieldAuthWidget(
                    hindText: tr('kPasswordHint'),
                    controler: passwordController,
                    hintStyle: TextStyle(
                      color: const Color(0xFF2C3E50),
                      fontSize: 17.69.sp,
                      fontFamily: kTheArabicSansLight,
                      fontWeight: FontWeight.w600,
                    ),
                    obscureText: _controller.passwordObscureText.value,

                    keyboardType: TextInputType.name,
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
                      onPressed: _controller.toggleSignUpPasswordVisibility,
                    ),
                  )),
                  SizedBox(height: 15.h),
                  Obx(() => TextFieldAuthWidget(
                    hindText: tr('kConfirmPasswordHint'),
                    controler: rePasswordController,
                    obscureText: _controller.confirmPasswordObscureText.value,

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
                      onPressed: _controller.toggleSignUpConfirmPasswordVisibility,
                    ),
                    keyboardType: TextInputType.name,
                    validatorTextField: (val) {
                      return Validator().validatorRePassword(val, passwordController.text);
                    },
                  )),
                  SizedBox(height: 25.h),
                  const LoginVia(),
                  SizedBox(
                    height: 25.h,
                  ),
                ],
              ),
              CustomButtonTwo(
                  width: MediaQuery.of(context).size.width,
                  height: 50.26.h,
                  borderRadius: 8.84.r,
                  backgroundColor: AppColors.kPrimaryColor,
                  text: tr('signUp'),
                  onPressed: _submit,
                  textStyle: TextStyle(
                      fontSize: 20.85.sp,
                      fontWeight: FontWeight.w700,
                      color: AppColors.kWhiteColor,
                      fontFamily: kTheArabicSansLight)),
              SizedBox(
                height: 27.h,
              ),
              InkWell(
                onTap: () {
                  Get.to(const LogInPage());
                },
                child: Center(
                  child: Text(
                    tr('kAlreadyHaveAccount'),
                    style: TextStyle(
                        decoration: TextDecoration.underline,
                        decorationColor: AppColors.kPrimaryColor,
                        fontFamily: kTheArabicSansLight,
                        fontSize: 21.21.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.kPrimaryColor),
                  ),
                ),
              ),
            ],
          ),)
        ),
      ),
    );
  }
}
