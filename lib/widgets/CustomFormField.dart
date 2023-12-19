// ignore_for_file: file_names

import 'package:beauty_queen/const/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../const/app_colors.dart';

class ReusableTextFormField extends StatelessWidget {
  final String? labelText;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final bool obscureText;
  final double? height;
  final double? width;
  final Function(String)? onChanged;
  final TextStyle? labelstyle;

  const ReusableTextFormField({
    super.key,
    this.labelText,
    this.height = 64.35,
    this.width = 398,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.onChanged,
    this.labelstyle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(13.r),
          border: Border.all(width: 1.w, color: AppColors.kTextGrayColor)),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscureText,
        onChanged: onChanged,
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: labelstyle,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
