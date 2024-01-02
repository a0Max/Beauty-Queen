import 'package:beauty_queen/const/extensions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geekyants_flutter_gauges/geekyants_flutter_gauges.dart';

import '../../const/app_colors.dart';
import '../../const/styles.dart';

class SeeMoreWidget extends StatelessWidget {
  final String currentDataProductsLength;
  final String totalDataProductsLength;
  final Function() onTap;
  const SeeMoreWidget(
      {super.key,
      required this.currentDataProductsLength,
      required this.totalDataProductsLength,
      required this.onTap});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        50.ph,
        Text(
          '${tr('result')}: ${currentDataProductsLength} ${tr('to')} ${totalDataProductsLength}',
          style: TextStyle(fontFamily: kTheArabicSansBold, fontSize: 15),
        ),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width / 2,
          height: 20,
          child: LinearGauge(
            gaugeOrientation: GaugeOrientation.horizontal,
            start: 0,
            end: double.parse("${totalDataProductsLength}"),
            valueBar: [
              ValueBar(
                  value: double.parse("${currentDataProductsLength}"),
                  color: AppColors.mainColor,
                  borderRadius: 15,
                  valueBarThickness: 5)
            ],
            linearGaugeBoxDecoration: const LinearGaugeBoxDecoration(
                backgroundColor: AppColors.kShadowColor,
                thickness: 5,
                borderRadius: 15),
            rulers: RulerStyle(
              rulerPosition: RulerPosition.center,
              showLabel: false,
              showSecondaryRulers: false,
              showPrimaryRulers: false,
              secondaryRulersHeight: 0,
            ),
          ),
        ),
        GestureDetector(
          onTap: currentDataProductsLength == totalDataProductsLength
              ? null
              : onTap,
          child: Container(
            // height: 59.70.h,
            padding: EdgeInsets.symmetric(vertical: 10.h),
            width: MediaQuery.of(context).size.width / 2,
            decoration: ShapeDecoration(
              color: currentDataProductsLength == totalDataProductsLength
                  ? AppColors.kPrimaryColor.withOpacity(.2)
                  : AppColors.kPrimaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0),
              ),
            ),
            child: Center(
              child: Text(tr('showMore'),
                  style: TextStyle(
                      fontSize: 18.11.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.kWhiteColor,
                      fontFamily: kTheArabicSansLight)),
            ),
          ),
        ),
        20.ph
      ],
    );
  }
}
