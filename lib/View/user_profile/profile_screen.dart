
import 'package:beauty_queen/const/extensions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../const/colors.dart';
import '../../const/styles.dart';
import '../../widgets/contact_us/contact_us_screen.dart';
import '../../widgets/contact_us/location_map.dart';
import '../../widgets/product_profile/comment_widget.dart';
import '../../widgets/contact_us/email_widget.dart';
import '../../widgets/contact_us/social_login.dart';
import '../../widgets/contact_us/work_hours.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: kWhiteColor,
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: kWhiteColor,
        actions: [
          IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(
                Icons.arrow_forward_ios,
                size: 30.r,
                color: kBlackColor,
              )),
        ],
        title: Text(
          tr('contact_us'),
          style: TextStyle(
              fontFamily: kTheArabicSansLight,
              color: kBlackColor,
              fontSize: 27.sp,
              fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                20.ph,
                const ContactUsScreen(),
                25.ph,
                SocialLogin(),
                25.ph,
                const EmailWidget(),
                25.ph,
                CommentWidget(),
                25.ph,
                const WorkHours(),
                25.ph,
                const LocationMap()

              ],
            ),
          )),
    );
  }
}
