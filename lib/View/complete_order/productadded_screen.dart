import 'package:beauty_queen/View/home/bottom_nav_screen.dart';
import 'package:beauty_queen/const/app_images.dart';
import 'package:beauty_queen/const/extensions.dart';
import 'package:beauty_queen/const/styles.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../const/app_colors.dart';
import '../../const/vars.dart';
import '../../controller/complete_order_controller/basketController.dart';
import '../../controller/orders_controller/orders_controller.dart';
import '../../widgets/drawer/drawer_final_ticket.dart';
import '../../widgets/order/order_details.dart';
import '../orders/orders_screen.dart';

class ProductAddedScreen extends StatelessWidget {
  const ProductAddedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final BasketController basketController = Get.put(BasketController());
    OrdersController controller = Get.put(OrdersController());

    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              20.ph,
              Center(
                child: SvgPicture.asset(
                  AppImages.doneOrderImage,
                  height: 146.18.h,
                  width: 244.48.w,
                ),
              ),
              Text(
                'لقد أتممت طلبك بنجاح!',
                style: TextStyle(
                    fontSize: 38.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.kBlackColor),
              ),
              //////////
              Text.rich(TextSpan(children: [
                TextSpan(
                  text: 'رقم الطلب:',
                  style: TextStyle(
                      fontFamily: kTheArabicSansLight,
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.kTextGrayColor),
                ),
                TextSpan(
                  text: '${basketController.order.value.order?.id ?? '0'}#',
                  style: TextStyle(
                      fontFamily: kTheArabicSansLight,
                      fontSize: 22.1.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.kPrimaryColor),
                )
              ])),
              Text(
                '''شكرا لك,\n طلبك جاهز في انتظار التأكيد سيتم التواصل معكِ لتسليم طلبك''',
                style: TextStyle(
                    fontFamily: kTheArabicSansLight,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.kBlackColor),
              ),

              GestureDetector(
                onTap: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MainView(),
                      ),
                      (route) => false);
                },
                child: Container(
                  height: 64.26.h,
                  width: 398.27.w,
                  decoration: BoxDecoration(
                      color: AppColors.kPrimaryColor,
                      borderRadius: BorderRadius.circular(47.34.r)),
                  child: Center(
                    child: Text(
                      'الصفحة الرئيسية',
                      style: TextStyle(
                          fontFamily: kTheArabicSansLight,
                          fontSize: 20.85.sp,
                          fontWeight: FontWeight.w700,
                          color: AppColors.kWhiteColor),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  controller.getDetailsOfOrder(
                      id: "${basketController.order.value.order?.id ?? 0}");
                  showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Colors.white,
                      elevation: 0,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(16.0),
                          topRight: Radius.circular(16.0),
                        ),
                      ),
                      builder: (BuildContext context) {
                        return Container(
                            height: MediaQuery.of(context).size.height - 200,
                            decoration: const BoxDecoration(
                              // color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(16.0),
                                topRight: Radius.circular(16.0),
                              ),
                            ),
                            padding: const EdgeInsets.only(top: 15),
                            child: const ShowModalSheetDetailOrder());
                      });
                },
                child: Text(
                  'تفاصيل الطلب',
                  style: TextStyle(
                      fontFamily: kTheArabicSansLight,
                      fontSize: 20.85.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.kPrimaryColor),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
