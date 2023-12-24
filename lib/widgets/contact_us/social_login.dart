import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:beauty_queen/const/extensions.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../const/app_colors.dart';
import '../../const/app_images.dart';
import '../../models/social_media_model.dart';

class SocialLogin extends StatelessWidget {
  SocialLogin({super.key});
  List<SocialMediaModel> listOfSocialMedia = [
    SocialMediaModel(
        url: 'https://www.tiktok.com/@beautyqueen.ly0?_t=8Y6WKdWaGJi&_r=1',
        image: AppImages.tiktokImage),
    SocialMediaModel(
        url: 'https://www.snapchat.com/add/beautyqueenyl?share_id=ODFGMDlBQzUtMjJFQS00NjBCLTgxRUEtMTIzMTQ1RjQxRDAz&locale=en_LY',
        image: AppImages.snapChatImage),

    SocialMediaModel(
        url: 'https://instagram.com/beautyqueen.ly?igshid=YmMyMTA2M2Y=',
        image: AppImages.instegramImage),

    SocialMediaModel(
        url: 'https://www.facebook.com/beautyqueenmakeup.ly/',
        image: AppImages.facebook1Image),
  ];
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
                fontFamily: 'TheSans',
                fontSize: 18.74,
                color: AppColors.mainColor,
                fontWeight: FontWeight.w700,
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
                          child: SvgPicture.asset(listOfSocialMedia[index].image)),
                      onTap: () async {
                        try {
                          await launchUrl(Uri.parse(listOfSocialMedia[index].url),
                          mode: LaunchMode.externalApplication);
                        } catch (e) {
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
