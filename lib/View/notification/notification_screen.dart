import 'package:beauty_queen/const/app_colors.dart';
import 'package:beauty_queen/const/app_images.dart';
import 'package:beauty_queen/const/extensions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../const/styles.dart';
import '../../controller/notification_controller/notification_controller.dart';
import '../../widgets/shimmer/shimmer_notification.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _NotificationScreen();
  }
}

class _NotificationScreen extends State<NotificationScreen> {
  NotificationController controller = Get.put(NotificationController());

  @override
  void initState() {
    super.initState();
    controller.getAllNotification();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
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
          tr('notification'),
          style: TextStyle(
              fontFamily: kTheArabicSansLight,
              color: AppColors.kBlackColor,
              fontSize: 27.sp,
              fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: Obx(() => controller.loadingNotification.value == true
          ? const ShimmerNotification()
          : ListView.builder(
              itemCount: controller.notificationList.value.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: const BoxDecoration(
                                color: AppColors.klPinkColor,
                                shape: BoxShape.circle),
                            child: SvgPicture.asset(
                              AppImages.notificationImage,
                              height: 22,
                              width: 22,
                            ),
                          ),
                          15.pw,
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  controller
                                          .notificationList.value[index].text ??
                                      '',
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 17.15,
                                    fontFamily: 'TheSans',
                                    fontWeight: FontWeight.w400,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                                if (controller.notificationList.value[index]
                                        .specialLine !=
                                    null)
                                  Text(
                                    controller.notificationList.value[index]
                                            .specialLine ??
                                        '',
                                    style: const TextStyle(
                                      color: AppColors.mainColor,
                                      fontSize: 17.15,
                                      fontFamily: 'TheSans',
                                      fontWeight: FontWeight.w400,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                10.ph,
                                Text(
                                  controller.notificationList.value[index]
                                          .createdAt
                                          .split('T')
                                          .first ??
                                      '',
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 18.12,
                                    fontFamily: 'TheSans',
                                    fontWeight: FontWeight.w400,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      if (index !=
                          controller.notificationList.value.length - 1) ...{
                        const Divider()
                      }
                    ],
                  ),
                );
              })),
    );
  }
}
