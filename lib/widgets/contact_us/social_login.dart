import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
//import 'package:firebase_crashlytics/firebase_crashlytics.dart';

import 'package:flutter/material.dart';
import 'package:beauty_queen/const/extensions.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../const/app_colors.dart';
import '../../const/app_images.dart';
import '../../const/styles.dart';
import '../../models/social_media_model.dart';

class SocialLogin extends StatelessWidget {
  final String? face;
  final String? ins;
  final String? tiktok;
  final String? snap;
  SocialLogin({super.key, this.face, this.ins, this.tiktok, this.snap}) {
    listOfSocialMedia = [
      SocialMediaModel(url: tiktok ?? '', image: AppImages.tiktokImage),
      SocialMediaModel(url: snap ?? '', image: AppImages.snapChatImage),
      SocialMediaModel(
          url:
              ins ?? 'https://instagram.com/beautyqueen.ly?igshid=YmMyMTA2M2Y=',
          image: AppImages.instegramImage),
      SocialMediaModel(
          url: face ?? 'https://www.facebook.com/beautyqueenmakeup.ly/',
          image: AppImages.facebook1Image),
    ];
  }
  List<SocialMediaModel> listOfSocialMedia = [];
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
                  AppImages.imagesInternet,
                  // height: 30,
                  // width: 30,
                )),
            10.pw,
            Text(
              tr('soutiol_media'),
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
        Row(
          children: List.generate(
              listOfSocialMedia.length,
              (index) => Container(
                    margin: const EdgeInsets.only(left: 12),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.black),
                    width: 40,
                    height: 40,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(5),
                      child: Container(
                          padding: const EdgeInsets.all(7),
                          child:
                              SvgPicture.asset(listOfSocialMedia[index].image)),
                      onTap: () async {
                        try {
                          await launchUrl(
                              Uri.parse(listOfSocialMedia[index].url),
                              mode: LaunchMode.externalApplication);
                        } catch (e, s) {
                          // FirebaseCrashlytics.instance
                          //     .recordError('Api Crash $e', s);
                          log('_makePhoneCall: error:$e');
                        }
                      },
                      // child: ,
                    ),
                  )),
        ),
      ],
    );
  }
}
