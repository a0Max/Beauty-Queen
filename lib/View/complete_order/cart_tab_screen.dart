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

///////////////////second screen tab/////////////////////
class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final BasketController basketController = Get.put(BasketController());

    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 17.w),
            child: Column(
              children: [
                Row(
                  children: [
                    Image.asset(kpaymentImage),
                    SizedBox(
                      width: 20.w,
                    ),
                    Text(
                      'إختر طريقة الدفع',
                      style: TextStyle(
                          fontFamily: kTheArabicSansLight,
                          fontSize: 22.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.kBlackColor),
                    ),
                  ],
                ),
                SizedBox(
                  height: 43.h,
                ),
                Obx(
                  () => GestureDetector(
                    onTap: () {
                      basketController.selectPaymentMethod('cash');
                    },
                    child: Container(
                        height: 109.h,
                        width: 397.w,
                        decoration: BoxDecoration(
                            color:
                                basketController.selectedPaymentMethod == 'cash'
                                    ? AppColors.kPrimaryColor
                                    : Colors.white,
                            borderRadius: BorderRadius.circular(9.r)),
                        child: Stack(
                          children: [
                            ListTile(
                              leading: Padding(
                                padding: EdgeInsets.only(bottom: 30.h),
                                child: Container(
                                  height: 23.h,
                                  width: 41.w,
                                  decoration: BoxDecoration(
                                      color: AppColors.kWhiteColor,
                                      borderRadius: BorderRadius.circular(3.r)),
                                  child: Center(
                                    child: Text(
                                      "Cash",
                                      style: TextStyle(
                                          fontFamily: kTheArabicSansLight,
                                          color: AppColors.kPrimaryColor,
                                          fontSize: 11.sp,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                ),
                              ),
                              title: Text(
                                "نقداً عند الاستلام",
                                style: TextStyle(
                                    fontFamily: kTheArabicSansLight,
                                    color: basketController
                                                .selectedPaymentMethod ==
                                            'cash'
                                        ? AppColors.kWhiteColor
                                        : AppColors.kBlackColor,
                                    fontSize: 21.sp,
                                    fontWeight: FontWeight.w600),
                              ),
                              subtitle: Text(
                                "سيتم تسليم قيمة البضاعة إلى مندوب \nالتوصيل عند الاستلام",
                                style: TextStyle(
                                    fontFamily: kTheArabicSansLight,
                                    color: basketController
                                                .selectedPaymentMethod ==
                                            'cash'
                                        ? AppColors.kWhiteColor
                                        : AppColors.kBlackColor,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w400),
                              ),
                              trailing: Padding(
                                padding: EdgeInsets.only(bottom: 35.h),
                                child: Transform.scale(
                                  scale: 1.5,
                                  child: Obx(
                                    () => Radio(
                                      fillColor: MaterialStateProperty
                                          .resolveWith<Color>((states) {
                                        if (states
                                            .contains(MaterialState.selected)) {
                                          basketController.containerColor =
                                              AppColors.kPrimaryColor;
                                          return Colors
                                              .white; // Selected color for the radio button
                                        }
                                        basketController.containerColor =
                                            Colors.white;
                                        return AppColors
                                            .kPrimaryColor; // Unselected color for the radio button
                                      }),
                                      activeColor: AppColors.kWhiteColor,
                                      value: 'cash',
                                      groupValue: basketController
                                          .selectedPaymentMethod.value,
                                      onChanged: (value) =>
                                          basketController.selectPaymentMethod(
                                              value.toString()),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 10.w),
                              child: Align(
                                alignment: Alignment.bottomLeft,
                                child: Image.asset(
                                  kqueencrownImage,
                                ),
                              ),
                            ),
                          ],
                        )),
                  ),
                ),
                SizedBox(
                  height: 26.h,
                ),
                //////////////////////////////////////
                Obx(
                  () => GestureDetector(
                    onTap: () {
                      basketController.selectPaymentMethod('محفظتي');
                    },
                    child: Container(
                        height: 109.h,
                        width: 397.w,
                        decoration: BoxDecoration(
                            color: basketController.selectedPaymentMethod ==
                                    'محفظتي'
                                ? AppColors.kPrimaryColor
                                : Colors.white,
                            boxShadow: [BoxShadow(blurRadius: 0.5.r)],
                            borderRadius: BorderRadius.circular(9.r)),
                        child: Stack(
                          children: [
                            ListTile(
                              leading: Image.asset(kenvolpImage),
                              title: Text(
                                "محفظتي",
                                style: TextStyle(
                                    fontFamily: kTheArabicSansLight,
                                    color: basketController
                                                .selectedPaymentMethod ==
                                            'محفظتي'
                                        ? AppColors.kWhiteColor
                                        : AppColors.kBlackColor,
                                    fontSize: 21.sp,
                                    fontWeight: FontWeight.w600),
                              ),
                              subtitle: Text.rich(TextSpan(children: [
                                TextSpan(
                                  text: '00,00 LYD  ',
                                  style: TextStyle(
                                      fontFamily: kTheArabicSansLight,
                                      color: basketController
                                                  .selectedPaymentMethod ==
                                              'محفظتي'
                                          ? AppColors.kWhiteColor
                                          : AppColors.kPrimaryColor,
                                      fontSize: 23.sp,
                                      fontWeight: FontWeight.w600),
                                ),
                                TextSpan(
                                  text: 'لا يوجد رصيد كافي',
                                  style: TextStyle(
                                      fontFamily: kTheArabicSansLight,
                                      color: basketController
                                                  .selectedPaymentMethod ==
                                              'محفظتي'
                                          ? AppColors.kWhiteColor
                                          : AppColors.kBlackColor,
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w500),
                                )
                              ])),
                              trailing: Transform.scale(
                                scale: 1.5,
                                child: Obx(
                                  () => Radio(
                                    fillColor: MaterialStateProperty
                                        .resolveWith<Color>((states) {
                                      if (states
                                          .contains(MaterialState.selected)) {
                                        basketController.containerColor =
                                            AppColors.kPrimaryColor;
                                        return Colors
                                            .white; // Selected color for the radio button
                                      }
                                      basketController.containerColor =
                                          AppColors.kWhiteColor;
                                      return AppColors.kPrimaryColor;
                                    }),
                                    activeColor: AppColors.kWhiteColor,
                                    value: 'محفظتي',
                                    groupValue: basketController
                                        .selectedPaymentMethod.value,
                                    onChanged: (value) => basketController
                                        .selectPaymentMethod(value.toString()),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 10.w),
                              child: Align(
                                alignment: Alignment.bottomLeft,
                                child: Image.asset(
                                  kqueencrownImage,
                                ),
                              ),
                            ),
                          ],
                        )),
                  ),
                ),
              ],
            ),
          ),
          ///////////////////////////////////
          const Spacer(),
          Container(
            height: 157.07.h,
            width: 431.77.w,
            decoration: BoxDecoration(color: AppColors.kWhiteColor, boxShadow: [
              BoxShadow(
                color: const Color.fromARGB(32, 0, 0, 0),
                blurRadius: 28.r,
                offset: const Offset(0, 4),
                spreadRadius: 0,
              ),
            ]),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              child: Row(
                children: [
                  Text.rich(TextSpan(children: [
                    TextSpan(
                      text: 'المجموع\n',
                      style: TextStyle(
                          fontFamily: kTheArabicSansLight,
                          fontSize: 18.83.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.klPinkColor),
                    ),
                    TextSpan(
                      text: '900 دل',
                      style: TextStyle(
                          fontFamily: kTheArabicSansLight,
                          fontSize: 34.01.sp,
                          fontWeight: FontWeight.w700,
                          color: AppColors.kBlackColor),
                    )
                  ])),
                  SizedBox(width: 35.w),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      height: 62.7.h,
                      width: 220.w,
                      decoration: BoxDecoration(
                        color: AppColors.kPrimaryColor,
                        borderRadius: BorderRadius.circular(46.r),
                      ),
                      child: Center(
                        child: Text(
                          'الإستمرار',
                          style: TextStyle(
                              fontFamily: kTheArabicSansLight,
                              fontSize: 23.sp,
                              fontWeight: FontWeight.w500,
                              color: AppColors.kWhiteColor),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

///////////////////third screen tab/////////////////////
class SummaryScreen extends StatelessWidget {
  const SummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                children: [
                  SizedBox(
                    height: 40.h,
                  ),
                  Row(
                    children: [
                      Image.asset(kdollarImage),
                      SizedBox(
                        width: 20.w,
                      ),
                      Text(
                        'الفاتورة',
                        style: TextStyle(
                            fontFamily: kTheArabicSansLight,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.kBlackColor),
                      ),
                      const Spacer(),
                      Text(
                        'عدد العناصر (1)',
                        style: TextStyle(
                            fontFamily: kTheArabicSansLight,
                            fontSize: 24.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.kBlackColor),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Stack(
              children: [
                Image.asset(kcardImage),
                Padding(
                  padding: EdgeInsets.fromLTRB(32.w, 24.h, 32.w, 0.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment
                        .spaceBetween, // To place text on the left and right
                    children: [
                      Text.rich(TextSpan(children: [
                        TextSpan(
                          text: 'تاريخ و وقت الطلب:\n',
                          style: TextStyle(
                            fontFamily: kTheArabicSansLight,
                            fontSize: 17.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColors.kBlackColor,
                          ),
                        ),
                        TextSpan(
                          text: '08/08/2023 04:00',
                          style: TextStyle(
                            fontFamily: kTheArabicSansLight,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.kPrimaryColor,
                          ),
                        )
                      ])),
                      Text.rich(TextSpan(children: [
                        TextSpan(
                          text: 'رقم الطلب:\n',
                          style: TextStyle(
                            fontFamily: kTheArabicSansLight,
                            fontSize: 17.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColors.kBlackColor,
                          ),
                        ),
                        TextSpan(
                          text: '749#',
                          style: TextStyle(
                            fontFamily: kTheArabicSansLight,
                            fontSize: 22.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.kPrimaryColor,
                          ),
                        )
                      ])),
                    ],
                  ),
                ),
                Positioned(
                  top: 120.h,
                  right: 32.w,
                  child: Row(
                    children: [
                      Text(
                        'منتجات (2)',
                        style: TextStyle(
                          fontFamily: kTheArabicSansLight,
                          fontSize: 22.53.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.kBlackColor,
                        ),
                      ),
                    ],
                  ),
                ),

                //////////////////column//////////////
                Padding(
                    padding:
                        EdgeInsets.only(top: 190.h, left: 25.w, right: 20.w),
                    child: Column(children: [
                      SizedBox(
                        height: 107.62.h,
                        width: 346.94.w,
                        child: Stack(
                          children: [
                            Image.asset(
                              krevitImage,
                              height: 97.h,
                              width: 97.w,
                            ),
                            Positioned(
                              right: 110.w,
                              child: Text(
                                "L’oreal",
                                style: TextStyle(
                                    fontFamily: kTheArabicSansLight,
                                    fontSize: 17.44.sp,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.kBlackColor),
                              ),
                            ),
                            Positioned(
                              right: 290.w,
                              child: Text(
                                '149LD',
                                style: TextStyle(
                                    fontFamily: kTheArabicSansLight,
                                    fontSize: 16.57.sp,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.kPrimaryColor),
                              ),
                            ),
                            Positioned(
                              top: 22.h,
                              right: 110.w,
                              child: Text(
                                'كريم لوريال رفيتا ليفت لمحيط \nالعين',
                                style: TextStyle(
                                    fontFamily: kTheArabicSansLight,
                                    fontSize: 15.7.sp,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.kGrayColor),
                              ),
                            ),
                            Positioned(
                              top: 80.h,
                              right: 110.w,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "اللون:",
                                    style: TextStyle(
                                        fontFamily: kTheArabicSansLight,
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.kTextGrayColor),
                                  ),
                                  Text(
                                    ' أزرق غامق',
                                    style: TextStyle(
                                        fontFamily: kTheArabicSansLight,
                                        fontSize: 14.83.sp,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.kBlackColor),
                                  ),
                                  SizedBox(
                                    width: 60.w,
                                  ),
                                  Text(
                                    '1x قطعة',
                                    style: TextStyle(
                                        fontFamily: kTheArabicSansLight,
                                        fontSize: 14.83.sp,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.kBlackColor),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ])),
                //////////////second one////////////////

                Padding(
                    padding:
                        EdgeInsets.only(top: 320.h, left: 25.w, right: 20.w),
                    child: Column(children: [
                      Divider(
                        indent: 20.w,
                        endIndent: 20.w,
                        thickness: 2.w,
                        color: const Color(0xffE9E9E9),
                      ),
                      SizedBox(
                        height: 25.h,
                      ),
                      SizedBox(
                        height: 107.62.h,
                        width: 346.94.w,
                        child: Stack(
                          children: [
                            Image.asset(
                              krevitImage,
                              height: 97.h,
                              width: 97.w,
                            ),
                            Positioned(
                              right: 110.w,
                              child: Text(
                                "L’oreal",
                                style: TextStyle(
                                    fontFamily: kTheArabicSansLight,
                                    fontSize: 17.44.sp,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.kBlackColor),
                              ),
                            ),
                            Positioned(
                              right: 290.w,
                              child: Text(
                                '149LD',
                                style: TextStyle(
                                    fontFamily: kTheArabicSansLight,
                                    fontSize: 16.57.sp,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.kPrimaryColor),
                              ),
                            ),
                            Positioned(
                              top: 22.h,
                              right: 110.w,
                              child: Text(
                                'كريم لوريال رفيتا ليفت لمحيط \nالعين',
                                style: TextStyle(
                                    fontFamily: kTheArabicSansLight,
                                    fontSize: 15.7.sp,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.kGrayColor),
                              ),
                            ),
                            Positioned(
                              top: 80.h,
                              right: 110.w,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "اللون:",
                                    style: TextStyle(
                                        fontFamily: kTheArabicSansLight,
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.kTextGrayColor),
                                  ),
                                  Text(
                                    ' أزرق غامق',
                                    style: TextStyle(
                                        fontFamily: kTheArabicSansLight,
                                        fontSize: 14.83.sp,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.kBlackColor),
                                  ),
                                  SizedBox(
                                    width: 60.w,
                                  ),
                                  Text(
                                    '1x قطعة',
                                    style: TextStyle(
                                        fontFamily: kTheArabicSansLight,
                                        fontSize: 14.83.sp,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.kBlackColor),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ])),
                /////////////end second one/////////////
              ],
            ),

            ////////////////container/////////////////////////

            SizedBox(
              height: 47.h,
            ),
            ////////////////////////////////////////////////
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'خصم البروموكود',
                          style: TextStyle(
                              fontFamily: kTheArabicSansLight,
                              fontSize: 18.1.sp,
                              fontWeight: FontWeight.w400,
                              color: AppColors.kTextGrayColor),
                        ),
                        Text(
                          '00.00',
                          style: TextStyle(
                              fontFamily: kTheArabicSansLight,
                              fontSize: 18.1.sp,
                              fontWeight: FontWeight.w500,
                              color: AppColors.kBlackColor),
                        ),
                      ]),
                  ///////////second row////////
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'خصم البروموكود',
                          style: TextStyle(
                              fontFamily: kTheArabicSansLight,
                              fontSize: 18.1.sp,
                              fontWeight: FontWeight.w400,
                              color: AppColors.kTextGrayColor),
                        ),
                        Text(
                          '00.00',
                          style: TextStyle(
                              fontFamily: kTheArabicSansLight,
                              fontSize: 18.1.sp,
                              fontWeight: FontWeight.w500,
                              color: AppColors.kBlackColor),
                        ),
                      ]),
                  /////////third row//////////////
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'خصم البروموكود',
                          style: TextStyle(
                              fontFamily: kTheArabicSansLight,
                              fontSize: 18.1.sp,
                              fontWeight: FontWeight.w400,
                              color: AppColors.kTextGrayColor),
                        ),
                        Text(
                          '00.00',
                          style: TextStyle(
                              fontFamily: kTheArabicSansLight,
                              fontSize: 18.1.sp,
                              fontWeight: FontWeight.w500,
                              color: AppColors.kBlackColor),
                        ),
                      ]),
                  Divider(
                    color: AppColors.kTextGrayColor,
                    thickness: 1.w,
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'الإجمــالي',
                          style: TextStyle(
                              fontFamily: kTheArabicSansLight,
                              fontSize: 19.sp,
                              fontWeight: FontWeight.w600,
                              color: AppColors.kBlackColor),
                        ),
                        Text(
                          '900 LYD',
                          style: TextStyle(
                              fontFamily: kTheArabicSansLight,
                              fontSize: 22.44.sp,
                              fontWeight: FontWeight.w600,
                              color: AppColors.kPrimaryColor),
                        ),
                      ]),
                ],
              ),
            ),
            SizedBox(
              height: 160.h,
            ),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: 25.h),
        child: FloatingActionButton.extended(
          onPressed: () {},
          label: Container(
            height: 157.07.h,
            width: 431.77.w,
            decoration: BoxDecoration(color: AppColors.kWhiteColor, boxShadow: [
              BoxShadow(
                color: const Color.fromARGB(32, 0, 0, 0),
                blurRadius: 28.r,
                offset: const Offset(0, 4),
                spreadRadius: 0,
              ),
            ]),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  width: 27.w,
                ),
                Text.rich(TextSpan(children: [
                  TextSpan(
                    text: tr('total'),
                    style: TextStyle(
                        fontFamily: kTheArabicSansLight,
                        fontSize: 18.83.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColors.klPinkColor),
                  ),
                  TextSpan(
                    text: '900 دل',
                    style: TextStyle(
                        fontFamily: kTheArabicSansLight,
                        fontSize: 34.01.sp,
                        fontWeight: FontWeight.w700,
                        color: AppColors.kBlackColor),
                  )
                ])),
                // SizedBox(width: 35.w),
                GestureDetector(
                  onTap: () {
                    Get.to(const ProductAddedScreen());
                  },
                  child: Container(
                    height: 62.7.h,
                    width: 220.w,
                    decoration: BoxDecoration(
                      color: AppColors.kPrimaryColor,
                      borderRadius: BorderRadius.circular(46.r),
                    ),
                    child: Center(
                      child: Text(
                        'الإستمرار',
                        style: TextStyle(
                            fontFamily: kTheArabicSansLight,
                            fontSize: 23.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColors.kWhiteColor),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
