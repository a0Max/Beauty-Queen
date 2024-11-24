import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../const/app_colors.dart';
import '../../const/app_images.dart';
import '../../const/styles.dart';

class FilterWidget extends StatelessWidget {
  final Function() onTap;

  const FilterWidget({super.key, required this.onTap});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 39.76.h,
      width: 180.w,
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.kPrimaryColor, width: 1.5.w),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          GestureDetector(
            onTap: onTap,
            child: Text(tr('filter_result'),
                style: TextStyle(
                  color: AppColors.kBlackColor,
                  fontSize: 18.sp,
                  fontFamily: kTheArabicSansLight,
                  fontWeight: FontWeight.w400,
                  height: 0,
                )),
          ),
          Padding(
            padding: EdgeInsets.only(left: 3.w),
            child: SvgPicture.asset(AppImages.filterTypeImage),
          ),
        ],
      ),
    );
  }
}
