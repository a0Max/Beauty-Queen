import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../const/styles.dart';

class CurrentPriceWithPink extends StatelessWidget {
  final String price;

  const CurrentPriceWithPink({super.key, required this.price});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Text(
      "$price${tr('Del')}",
      textAlign: TextAlign.right,
      style: TextStyle(
        color: const Color(0xFFDE0F7E),
        fontSize: 15.16.sp,
        fontFamily: kTheArabicSansBold,
        fontWeight: FontWeight.w400,
        height: 0.08,
      ),
    );
  }
}
