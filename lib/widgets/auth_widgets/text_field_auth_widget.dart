import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../const/app_colors.dart';
import '../../const/styles.dart';

class TextFieldAuthWidget extends StatelessWidget {
  final String? titleText;
  final String hindText;
  final FormFieldValidator? validatorTextField;
  final TextEditingController? controler;
  final bool? obscureText;
  final Function()? onTap;
  final bool? readOnly;
  final Widget? suffixWidget;
  final TextStyle? hintStyle;

  final TextInputType? keyboardType;

  const TextFieldAuthWidget(
      {super.key,
      this.onTap,
      this.readOnly,
      this.titleText,
      required this.hindText,
      this.controler,
      this.obscureText,
      this.suffixWidget,
      this.keyboardType,
      this.validatorTextField,
      this.hintStyle});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (titleText != null) ...{
          Text(
            titleText!,
            style: TextStyle(
              color: AppColors.kSecondaryColor,
              fontSize: 18.79.sp,
              fontFamily: kTheArabicSansLight,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 10.h),
        },
        TextFormField(
          style: TextStyle(
            color: Colors.black,
            fontSize: 12.74.sp,
            fontFamily: kTheArabicSansLight,
            fontWeight: FontWeight.w600,
          ),
          obscureText: obscureText ?? false,
          controller: controler,
          readOnly: readOnly ?? false,
          onTap: onTap,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hindText,
            errorStyle: TextStyle(
              color: Colors.red,
              fontSize: 9.74.sp,
              fontFamily: kTheArabicSansLight,
              fontWeight: FontWeight.w600,
            ),
            hintStyle: hintStyle ??
                TextStyle(
                  color: const Color(0xFFD5D5D5),
                  fontSize: 17.69.sp,
                  fontFamily: kTheArabicSansLight,
                  fontWeight: FontWeight.w600,
                ),
            contentPadding:
                EdgeInsets.symmetric(vertical: 15.h, horizontal: 15.w),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(11.06.r),
              borderSide:
                  BorderSide(width: 1.11.w, color: const Color(0xFFD9DEE2)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(11.06.r),
              borderSide:
                  BorderSide(width: 1.11.w, color: const Color(0xFFD9DEE2)),
            ),
            suffixIcon: suffixWidget,
          ),
          validator: validatorTextField,
        ),
      ],
    );
  }
}
