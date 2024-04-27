// ignore_for_file: unrelated_type_equality_checks, library_private_types_in_public_api

import 'package:beauty_queen/const/extensions.dart';
import 'package:beauty_queen/const/styles.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../const/app_colors.dart';
import '../../controller/complete_order_controller/basketController.dart';
import 'productadded_screen.dart';
import 'delivery_screen.dart';
import 'payment_screen.dart';
import 'summary_screen.dart';

class TabView extends StatefulWidget {
  const TabView({super.key});

  @override
  _TabViewState createState() => _TabViewState();
}

class _TabViewState extends State<TabView> with SingleTickerProviderStateMixin {
  final BasketController basketController = Get.put(BasketController());
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);

    _tabController.animation?.addListener(() {
      final tabIndex = ((_tabController.animation?.value ?? 0) + 0.5).floor();
      if (tabIndex != basketController.selectedIndex.value) {
        basketController.changeTab(tabIndex);
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  // int stepsCount = 3;
  final BasketController controller = Get.put(BasketController());
  List listOfTabBody = [
    const DeliveryScreen(),
    const SummaryScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.kTextGrayColor.withOpacity(.1),
            elevation: 0,
            automaticallyImplyLeading: false,
            actions: [
              IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: const Icon(Icons.arrow_forward_ios)),
            ],
            centerTitle: true,
            title: Text(
              "سلّــتي",
              style: TextStyle(
                color: AppColors.kBlackColor,
                fontSize:
                    28.sp, // Replace with 28.sp if you're using scaled fonts
                fontFamily: kTheArabicSansLight,
              ),
            ),
          ),
          body: listOfTabBody[controller.selectedIndex.value],
        ));
  }
}
