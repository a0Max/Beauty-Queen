import 'package:beauty_queen/const/extensions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../const/app_colors.dart';
import '../../const/app_images.dart';

import 'package:flutter/material.dart';

import '../../const/styles.dart';
import '../../const/vars.dart';

class EmailWidget extends StatelessWidget {
  const EmailWidget({super.key});

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
                  AppImages.imageEmail,
                  // height: 30,
                  // width: 30,
                )),
            10.pw,
            Text(
              tr('email2'),
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
          onTap: () async {
            await launchUrl(
              Uri.parse('mailto:${SocialMedia.email}'),
              mode: LaunchMode.externalApplication,
            );
          },
          child: const Text(
            SocialMedia.email,
            style: TextStyle(
              fontFamily: kTheArabicSansLight,
              fontSize: 14.74,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }
}
