import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../const/styles.dart';

class CurrentPriceWithBlack extends StatelessWidget {
  final String price;

  const CurrentPriceWithBlack({super.key, required this.price});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Text(
      "$price ${tr('Del')}",
      textAlign: TextAlign.right,
      style: TextStyle(
        color: Colors.black,
        fontSize: 15.16.sp,
        fontFamily: kTheArabicSansBold,
        fontWeight: FontWeight.w400,
        // decoration:
        //     TextDecoration
        //         .lineThrough,
        height: 0.08,
      ),
    );
  }
}
