import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../const/app_colors.dart';
import '../../const/app_images.dart';
import '../../const/styles.dart';
import '../../const/vars.dart';

class SortDropDown extends StatelessWidget {
  final String? value;
  final void Function(String?) onChanged;

  const SortDropDown({super.key, this.value, required this.onChanged});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 39.76.h,
      width: 180.w,
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.kPrimaryColor, width: 1.5.w),
      ),
      child: Row(
        children: [
          Expanded(
            child: DropdownButton<String>(
              iconEnabledColor: Colors.transparent,
              isDense: true,
              isExpanded: true,
              underline: const SizedBox(),
              alignment: Alignment.center,
              value: value,
              items: SortTypes.listOfTTypesOfSort.values.map((value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value,
                      style: TextStyle(
                        color: AppColors.kBlackColor,
                        fontSize: 14.sp,
                        fontFamily: kTheArabicSansLight,
                        fontWeight: FontWeight.w400,
                        height: 0,
                      )),
                );
              }).toList(),
              onChanged: onChanged,
              hint: Text(tr('classificationBy'),
                  style: TextStyle(
                    color: AppColors.kBlackColor,
                    fontSize: 16.sp,
                    fontFamily: kTheArabicSansLight,
                    fontWeight: FontWeight.w500,
                    height: 0,
                  )),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 3.w),
            child: SvgPicture.asset(AppImages.sortTypeImage),
          ),
        ],
      ),
    );
  }
}
