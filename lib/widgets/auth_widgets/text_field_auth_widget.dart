import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../const/app_colors.dart';
import '../../const/styles.dart';

class TextFieldAuthWidget extends StatelessWidget{
  final String? titleText;
  final String hindText;
  final FormFieldValidator? validatorTextField;
  final TextEditingController? controler;
  final bool? obscureText;
  final Widget? suffixWidget;
  final TextStyle? hintStyle;

  final TextInputType? keyboardType;

  const TextFieldAuthWidget({super.key, this.titleText, required this.hindText, this.controler, this.obscureText, this.suffixWidget, this.keyboardType, this.validatorTextField, this.hintStyle});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if(titleText!=null)...{
          Text(
            titleText!,
            style: TextStyle(
              color: AppColors.kSecondaryColor,
              fontSize: 18.79.sp,
              fontFamily: kTheArabicSansLight,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(height: 10.h),
        },
        TextFormField(
          obscureText: obscureText ?? false,
          controller: controler,

          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hindText,
            hintStyle:hintStyle?? TextStyle(
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
            suffixIcon: suffixWidget,

          ),
          validator: validatorTextField,

        ),
      ],
    );
  }

}