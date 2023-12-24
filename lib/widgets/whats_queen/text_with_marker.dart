import 'package:beauty_queen/const/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../const/app_images.dart';
import '../../const/styles.dart';

class TextWithMarker extends StatelessWidget{
  final String body;

  const TextWithMarker({super.key, required this.body});
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SvgPicture.asset(
          AppImages.markerImage,
          width: 6.w,
        ),
        5.pw,
        SizedBox(
            width: (MediaQuery.of(context).size.width /
                3) -
                (11.w),
            child: Text(
              body,

              style: const TextStyle(
                color: Colors.black,
                fontSize: 9,
                fontFamily: kTheArabicSansLight,
                fontWeight: FontWeight.w300,
                // height: 0.15,
                // letterSpacing: -0.18,
              ),
              overflow: TextOverflow.visible,
            )),

      ],
    );
  }

}