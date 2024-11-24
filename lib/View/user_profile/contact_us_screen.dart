import 'package:beauty_queen/const/extensions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';

import '../../const/api_connrction/user_data_apis.dart';
import '../../const/app_colors.dart';
import '../../const/styles.dart';
import '../../controller/about_controller/about_app_controller.dart';
import '../../widgets/contact_us/contact_us_screen.dart';
import '../../widgets/contact_us/location_map.dart';
import '../../widgets/home/CustomNavBar2.dart';
import '../../widgets/product_profile/comment_widget.dart';
import '../../widgets/contact_us/email_widget.dart';
import '../../widgets/contact_us/social_login.dart';
import '../../widgets/contact_us/work_hours.dart';

class ContactUsScreen extends StatefulWidget {
  ContactUsScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ContactUsScreen();
  }
}

class _ContactUsScreen extends State<ContactUsScreen> {
  final AboutAppController userController = Get.put(AboutAppController());
  @override
  void initState() {
    userController.getMyContact();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const ReusableBottomNavigationBar2(),
      appBar: AppBar(
        surfaceTintColor: AppColors.kWhiteColor,
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: AppColors.kWhiteColor,
        actions: [
          IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(
                Icons.arrow_forward_ios,
                size: 30.r,
                color: AppColors.kBlackColor,
              )),
        ],
        title: Text(
          tr('contact_us'),
          style: TextStyle(
              color: AppColors.mainColor,
              fontSize: 27.sp,
              fontFamily: kTheArabicSansBold,
              fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
          child: Obx(() => Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: (userController.isLoading.value == true)
                    ? const Center(child: CircularProgressIndicator())
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          20.ph,
                          const ContactUsScreen0(),
                          HtmlWidget(
                            userController.myContactData.callSection ?? '',
                            textStyle:
                                TextStyle(fontFamily: kTheArabicSansBold),
                          ),
                          40.ph,
                          SocialLogin(
                              face: userController.myContactData.facebook,
                              ins: userController.myContactData.instagram,
                              tiktok: userController.myContactData.tiktok,
                              snap: userController.myContactData.snapchat),
                          40.ph,
                          EmailWidget(
                              email: userController.myContactData.email ?? ''),
                          40.ph,
                          CommentWidget(),
                          40.ph,
                          const WorkHours(),
                          HtmlWidget(
                            userController.myContactData.workingHours ?? '',
                            textStyle:
                                TextStyle(fontFamily: kTheArabicSansBold),
                          ),
                          40.ph,
                          const LocationMap()
                        ],
                      ),
              ))),
    );
  }
}
