import 'package:beauty_queen/const/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../const/app_colors.dart';
import '../../const/app_images.dart';
import '../../const/styles.dart';

class WorkHours extends StatelessWidget {
  const WorkHours({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Transform.flip(
                flipX: true,
                child: SvgPicture.asset(
                  AppImages.imageClock,
                  // height: 30,
                  // width: 30,
                )),
            10.pw,
            const Text(
              'ساعات العمل',
              style: TextStyle(
                fontFamily: kTheArabicSansBold,
                fontSize: 18.74,
                color: AppColors.mainColor,
                fontWeight: FontWeight.w500,
              ),
            )
          ],
        ),
        15.ph,
        const Text('كل أيام الأسبوع من الساعة 10 صباحاً إلى الساعة 8:30 مساءاً',
            style: TextStyle(
              color: AppColors.kTextDGColor,
              fontSize: 12,
              fontWeight: FontWeight.w200,
              fontFamily: kTheArabicSansLight,
            )),
        const Text('يوم الجمعة من الساعة 4 بعد الظهر إلى الساعة 8.300 مساءً',
            style: TextStyle(
              color: AppColors.kTextDGColor,
              fontSize: 12,
              fontWeight: FontWeight.w200,
              fontFamily: kTheArabicSansLight,
            )),
      ],
    );
  }
}
