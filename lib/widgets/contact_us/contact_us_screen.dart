import 'dart:developer';

import 'package:beauty_queen/const/extensions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../const/app_colors.dart';
import '../../const/app_images.dart';
import 'package:flutter/material.dart';

import '../../const/styles.dart';
import '../../const/vars.dart';

class ContactUsScreen0 extends StatelessWidget {
  const ContactUsScreen0({super.key});
  Future<void> _makePhoneCall(String url) async {
    try {
      await launchUrl(Uri.parse("tel:$url"),
          mode: LaunchMode.externalApplication);
    } catch (e) {
      log('_makePhoneCall: error:$e');
    }
  }

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
                  AppImages.imagePhoneCall,
                  // height: 20,
                  // width: 20,
                )),
            10.pw,
            Text(
              tr('call_us'),
              style: const TextStyle(
                fontFamily: kTheArabicSansBold,
                fontSize: 18.74,
                color: AppColors.mainColor,
                fontWeight: FontWeight.w500,
              ),
            )
          ],
        ),
        10.ph,
        GestureDetector(
          onTap: () {
            _makePhoneCall(SocialMedia.phone);
          },
          child: Row(
            children: [
              Text(
                'رقـــــــــــــم المتجـــــــــــر',
                style: TextStyle(
                  fontFamily: kTheArabicSansLight,
                  fontSize: 15.74,
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                ),
              ),
              20.pw,
              Text(
                SocialMedia.phone,
                style: TextStyle(
                  fontFamily: kTheArabicSansLight,
                  fontSize: 15.74,
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
        5.ph,
        GestureDetector(
          onTap: () {
            _makePhoneCall(SocialMedia.phone);
          },
          child: Row(
            children: [
              Text(
                'رقم خدمة العملاء',
                style: TextStyle(
                  fontFamily: kTheArabicSansLight,
                  fontSize: 15.74,
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                ),
              ),
              24.pw,
              Text(
                SocialMedia.phone,
                style: TextStyle(
                  fontFamily: kTheArabicSansLight,
                  fontSize: 15.74,
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
        15.ph,
        Text(tr('des_contact'),
            style: const TextStyle(
              color: AppColors.kTextDGColor,
              fontSize: 14,
              fontWeight: FontWeight.w200,
              fontFamily: kTheArabicSansLight,
            )),
      ],
    );
  }
}
