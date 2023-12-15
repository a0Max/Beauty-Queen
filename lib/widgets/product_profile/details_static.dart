import 'dart:developer';

import 'package:beauty_queen/const/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../const/styles.dart';

class DetailsStatic extends StatelessWidget{
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
  const DetailsStatic({super.key, required this.title, required this.body, required this.icon, this.isPhone});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 30),
          decoration: const BoxDecoration(
            color: AppColors.klPinkColor
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SvgPicture.asset(icon, color: AppColors.mainColor,),
              const SizedBox(width: 14,),
              Text(title, style: const TextStyle(
                fontSize: 16,
                fontFamily: kTheArabicSansLight,
                fontWeight: FontWeight.w400,
                color: AppColors.mainColor
              ),),

            ],
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,

          padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 40),
          decoration: const BoxDecoration(
            color: AppColors.kcontainerGrayColor
          ),
          alignment: Alignment.centerRight,
          child: Column(
            children: [
              Text(body, style: const TextStyle(
                fontSize: 13,
                fontFamily: kTheArabicSansLight,
                fontWeight: FontWeight.w400,
              ),),
              if (isPhone==true)...{
              Row(
                children: [
                  GestureDetector(
                    onTap: (){
                      _makePhoneCall("+218911308356");
                    },
                    child:  const Text('0911308356', style: TextStyle(
                      fontSize: 13,
                      fontFamily: kTheArabicSansLight,
                      fontWeight: FontWeight.w400,
                    ),),
                  ),
                  const Text('  -   ', style: TextStyle(
                    fontSize: 13,
                    fontFamily: kTheArabicSansLight,
                    fontWeight: FontWeight.w400,
                  ),),
                  GestureDetector(
                    onTap: (){
                      _makePhoneCall("+218928225378");
                    },
                    child:  const Text('0928225378', style: TextStyle(
                      fontSize: 13,
                      fontFamily: kTheArabicSansLight,
                      fontWeight: FontWeight.w400,
                    ),),
                  )
                ],
              )
              }
            ],
          ),
        ),
        const SizedBox(height: 10,)
      ],
    );
  }

}