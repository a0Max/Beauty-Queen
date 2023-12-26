// ignore_for_file: unrelated_type_equality_checks, library_private_types_in_public_api

import 'package:beauty_queen/const/images.dart';
import 'package:beauty_queen/const/styles.dart';
import 'package:beauty_queen/widgets/CustomFormField.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../const/app_colors.dart';
import '../../controller/basketController.dart';
import '../productadded_screen.dart';
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
  List listOfTabText = ['التسليم', 'الدفع', 'الملخص'];
  List listOfTabBody = [
    const DeliveryScreen(),
    const PaymentScreen(),
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
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(60),
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        for (int i = 1; i <= listOfTabText.length; i++) ...[
                          Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        color:
                                            ((controller.selectedIndex.value) +
                                                        1) <
                                                    i
                                                ? Colors.transparent
                                                : AppColors.mainColor)
                                    //     : null
                                    ),
                                child: Container(
                                  height: 31,
                                  width: 31,
                                  margin: const EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                      color: ((controller.selectedIndex.value) +
                                                  1) <
                                              i
                                          ? AppColors.kLightGreyBlueColor
                                          : AppColors.mainColor,
                                      shape: BoxShape.circle,
                                      border: ((controller
                                                      .selectedIndex.value) +
                                                  1) <
                                              i
                                          ? Border.all(
                                              color: const Color(0xFFC1C1C1))
                                          : null),
                                  child: Center(
                                    child: (controller.selectedIndex.value) >= i
                                        ? const Icon(
                                            Icons.check,
                                            color: Colors.white,
                                          )
                                        : Text(
                                            '$i',
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline2
                                                ?.copyWith(
                                                    fontSize: 16,
                                                    color: Colors.white),
                                          ),
                                  ),
                                ),
                              ),
                              Center(
                                child: Text(
                                  listOfTabText[i - 1],
                                  style: TextStyle(
                                    fontSize: 14
                                        .sp, // Replace with 14.sp if you're using scaled fonts
                                    fontFamily: kTheArabicSansLight,
                                    color: (controller.selectedIndex.value) >=
                                            (i - 1)
                                        ? Colors.black
                                        : AppColors.kLightGreyBlueColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          if (i != listOfTabText.length) ...[
                            Container(
                              width: ((MediaQuery.of(context).size.width -
                                      (36 + 8 + 8 + 16 + 16)) /
                                  listOfTabText.length),
                              margin: const EdgeInsets.symmetric(vertical: 20),
                              child: Row(
                                children: [
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Container(
                                      alignment: Alignment.topCenter,
                                      height: 1,
                                      width: 50,
                                      color:
                                          i != (controller.selectedIndex.value)
                                              ? AppColors.kLightGreyBlueColor
                                              : AppColors.mainColor,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                ],
                              ),
                            )
                          ]
                        ],
                      ],
                    ),
                  ),
                  Divider(
                    color: AppColors.kTextGrayColor.withOpacity(.3),
                  )
                ],
              ),
            ),
          ),
          body: listOfTabBody[controller.selectedIndex.value],
        ));
  }
}
