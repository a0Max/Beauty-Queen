import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../const/app_colors.dart';
import '../../const/styles.dart';
import '../../widgets/order/order_details.dart';

class DetailsOfOrder extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          backgroundColor: AppColors.kWhiteColor,
          title: Text(
            "سجل الطلبات",
            style: TextStyle(
                fontFamily: kTheArabicSansBold,
                color: AppColors.kBlackColor,
                fontSize: 23.74.sp,
                fontWeight: FontWeight.w400),
          ),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: const Icon(
                  Icons.arrow_forward_ios,
                  color: AppColors.kBlackColor,
                  size: 30,
                )),
          ]),
      key: _scaffoldKey,
      body: ShowModalSheetDetailOrder(),
    );
  }
}
