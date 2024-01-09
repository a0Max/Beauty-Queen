import 'dart:developer';

import 'package:beauty_queen/const/app_colors.dart';
import 'package:beauty_queen/const/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../const/styles.dart';

class DetailsStatic extends StatelessWidget {
  final String title;
  final String body;
  final String icon;
  final bool? isPhone;
  Future<void> _makePhoneCall(String url) async {
    try {
      await launchUrl(Uri.parse("tel:$url"),
          mode: LaunchMode.externalApplication);
    } catch (e) {
      log('_makePhoneCall: error:$e');
    }
  }

  const DetailsStatic(
      {super.key,
      required this.title,
      required this.body,
      required this.icon,
      this.isPhone});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(bottom: 7, top: 7, right: 15.w),
          decoration: const BoxDecoration(color: AppColors.klPinkColor),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SvgPicture.asset(
                icon,
                color: AppColors.mainColor,
                width: 40.w,
              ),
              const SizedBox(
                width: 14,
              ),
              Container(
                width:
                    MediaQuery.of(context).size.width - (30.w + 30 + 14 + 40.w),
                child: Text(
                  title,
                  style: const TextStyle(
                      fontSize: 16,
                      fontFamily: kTheArabicSansBold,
                      fontWeight: FontWeight.w300,
                      color: AppColors.mainColor),
                  overflow: TextOverflow.visible,
                ),
              ),
            ],
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.only(top: 7, bottom: 7, right: 70),
          decoration: const BoxDecoration(color: AppColors.kcontainerGrayColor),
          alignment: Alignment.centerRight,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 25.pw,
              Text(
                body,
                style: const TextStyle(
                  fontSize: 13,
                  fontFamily: kTheArabicSansLight,
                  fontWeight: FontWeight.w600,
                ),
                overflow: TextOverflow.visible,
              ),

              if (isPhone == true) ...{
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        _makePhoneCall("+218911308356");
                      },
                      child: const Text(
                        '0911308356',
                        style: TextStyle(
                          fontSize: 13,
                          fontFamily: kTheArabicSansLight,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    const Text(
                      '  -   ',
                      style: TextStyle(
                        fontSize: 13,
                        fontFamily: kTheArabicSansLight,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        _makePhoneCall("+218928225378");
                      },
                      child: const Text(
                        '0928225378',
                        style: TextStyle(
                          fontSize: 13,
                          fontFamily: kTheArabicSansLight,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    )
                  ],
                )
              }
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        )
      ],
    );
  }
}
