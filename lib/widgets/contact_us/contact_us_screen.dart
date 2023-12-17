import 'dart:developer';

import 'package:beauty_queen/const/extensions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../const/app_colors.dart';
import '../../const/app_images.dart';
import 'package:flutter/material.dart';

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
                fontFamily: 'TheSans',
                fontSize: 18.74,
                color: AppColors.mainColor,
                fontWeight: FontWeight.w700,
              ),
            )
          ],
        ),
        10.ph,
        GestureDetector(
          onTap: () {
            _makePhoneCall(SocialMedia.phone);
          },
          child: const Row(
            children: [
              Text(
                'رقـــــــــــــم المتجـــــــــــر',
                style: TextStyle(
                  fontFamily: 'TheSans',
                  fontSize: 15.74,
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(
                SocialMedia.phone,
                style: TextStyle(
                  fontFamily: 'TheSans',
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
          child: const Row(
            children: [
              Text(
                'رقم خدمة العملاء',
                style: TextStyle(
                  fontFamily: 'TheSans',
                  fontSize: 15.74,
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(
                SocialMedia.phone,
                style: TextStyle(
                  fontFamily: 'TheSans',
                  fontSize: 15.74,
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
        15.ph,
        Text(
            tr('des_contact'),
            style: const TextStyle(
              color: AppColors.kTextDGColor,
              fontSize: 14,
              fontWeight: FontWeight.w200,
              fontFamily: 'TheSans',
            )),
      ],
    );
  }
}
