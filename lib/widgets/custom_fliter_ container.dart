// ignore_for_file: library_private_types_in_public_api, file_names

import 'package:beauty_queen/const/colors.dart';
import 'package:beauty_queen/const/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyCustomContainer extends StatelessWidget {
  final bool isSelected;
  final VoidCallback onTap;
  final String text;
  const MyCustomContainer(
      {Key? key,
      required this.isSelected,
      required this.onTap,
      required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          height: 34.95.h,
          // width: 92.12.w,
          decoration: BoxDecoration(
            border: Border.all(color: kTextGrayColor, width: 1.w),
            borderRadius: BorderRadius.circular(
              9.43.r,
            ),
            color: isSelected ? kTextGrayColor : Colors.transparent,
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                  color: isSelected ? Colors.white : Colors.black,
                  fontFamily: kTheArabicSansLight,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400),
            ),
          ),
        ),
      ),
    );
  }
}
