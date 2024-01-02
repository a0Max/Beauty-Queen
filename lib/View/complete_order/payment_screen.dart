import 'package:beauty_queen/widgets/based/loading.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../const/app_colors.dart';
import '../../const/app_images.dart';
import '../../const/styles.dart';
import '../../const/vars.dart';
import '../../controller/auth_controller/auth_controler.dart';
import '../../controller/complete_order_controller/basketController.dart';
import '../../controller/wallet_controller/wallet_controller.dart';
import '../../widgets/product_profile/CustomAlertBox.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _PaymentScreen();
  }
}

class _PaymentScreen extends State<PaymentScreen> {
  WalletController controller2 = Get.put(WalletController());
  AuthController controller = Get.put(AuthController());

  @override
  void initState() {
    super.initState();
    controller2.getAllWallet();
  }

  @override
  Widget build(BuildContext context) {
    final BasketController basketController = Get.put(BasketController());

    return Scaffold(
      body: Obx(() => Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    color: AppColors.kTextGrayColor.withOpacity(.1),
                    height: MediaQuery.of(context).size.height,
                    padding: EdgeInsets.symmetric(horizontal: 17.w),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset(AppImages.paymentImage),
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
                        GestureDetector(
                          onTap: () {
                            basketController.selectPaymentMethod('cash');
                          },
                          child: Container(
                              height: 100.h,
                              width: MediaQuery.of(context).size.width,
                              // width: 397.w,
                              decoration: BoxDecoration(
                                  color:
                                      basketController.selectedPaymentMethod ==
                                              'cash'
                                          ? AppColors.kPrimaryColor
                                          : Colors.white,
                                  boxShadow: [BoxShadow(blurRadius: 0.5.r)],
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
                                            borderRadius:
                                                BorderRadius.circular(3.r)),
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
                                        child: Radio(
                                          fillColor: MaterialStateProperty
                                              .resolveWith<Color>((states) {
                                            if (states.contains(
                                                MaterialState.selected)) {
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
                                          onChanged: (value) => basketController
                                              .selectPaymentMethod(
                                                  value.toString()),
                                        ),
                                        // ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 10.w),
                                    child: Align(
                                      alignment: Alignment.bottomLeft,
                                      child: SvgPicture.asset(
                                          AppImages.kqueencrownImage),
                                    ),
                                  ),
                                ],
                              )),
                        ),
                        // ),
                        SizedBox(
                          height: 26.h,
                        ),

                        if (controller.userData.value.accountType ==
                            AccountTypes.queena) ...{
                          controller2.loadingWallet.value == true
                              ? const CupertinoActivityIndicator()
                              : GestureDetector(
                                  onTap: () {
                                    if (num.parse(
                                                "${basketController.totalOrderDetails.value.totalPrice ?? '0'}") +
                                            num.parse(basketController
                                                    .totalOrderDelivery
                                                    .value
                                                    .shippingCost ??
                                                '0') >
                                        num.parse(controller2
                                            .walletAmountState.value)) {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return CustomAlertDialog(
                                              buttonTwo: false,
                                              dilougText: tr('no_enaph_money'),
                                              buttonOneText: tr('okay'),
                                            );
                                          });
                                    } else {
                                      basketController
                                          .selectPaymentMethod('user_balance');
                                    }
                                  },
                                  child: Container(
                                      height: 100.h,
                                      width: MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(
                                          color: basketController
                                                      .selectedPaymentMethod ==
                                                  'user_balance'
                                              ? AppColors.kPrimaryColor
                                              : Colors.white,
                                          boxShadow: [
                                            BoxShadow(blurRadius: 0.5.r)
                                          ],
                                          borderRadius:
                                              BorderRadius.circular(9.r)),
                                      child: Stack(
                                        children: [
                                          ListTile(
                                            leading: SvgPicture.asset(
                                                AppImages.walletImage),
                                            title: Text(
                                              "محفظتي",
                                              style: TextStyle(
                                                  fontFamily:
                                                      kTheArabicSansLight,
                                                  color: basketController
                                                              .selectedPaymentMethod ==
                                                          'user_balance'
                                                      ? AppColors.kWhiteColor
                                                      : AppColors.kBlackColor,
                                                  fontSize: 21.sp,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            subtitle:
                                                Text.rich(TextSpan(children: [
                                              TextSpan(
                                                text:
                                                    "${controller2.walletAmountState.value} ${tr('Del')}",
                                                style: TextStyle(
                                                    fontFamily:
                                                        kTheArabicSansLight,
                                                    color: basketController
                                                                .selectedPaymentMethod ==
                                                            'user_balance'
                                                        ? AppColors.kWhiteColor
                                                        : AppColors
                                                            .kPrimaryColor,
                                                    fontSize: 23.sp,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                              if (num.parse(
                                                          "${basketController.totalOrderDetails.value.totalPrice ?? '0'}") +
                                                      num.parse(basketController
                                                              .totalOrderDelivery
                                                              .value
                                                              .shippingCost ??
                                                          '0') >
                                                  num.parse(controller2
                                                      .walletAmountState
                                                      .value)) ...{
                                                TextSpan(
                                                  text: 'لا يوجد رصيد كافي',
                                                  style: TextStyle(
                                                      fontFamily:
                                                          kTheArabicSansLight,
                                                      color: basketController
                                                                  .selectedPaymentMethod ==
                                                              'محفظتي'
                                                          ? AppColors
                                                              .kWhiteColor
                                                          : AppColors
                                                              .kBlackColor,
                                                      fontSize: 16.sp,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                )
                                              }
                                            ])),
                                            trailing: Transform.scale(
                                              scale: 1.5,
                                              child: Radio(
                                                  fillColor:
                                                      MaterialStateProperty
                                                          .resolveWith<Color>(
                                                              (states) {
                                                    print(basketController
                                                        .containerColor);
                                                    if (states.contains(
                                                        MaterialState
                                                            .selected)) {
                                                      basketController
                                                              .containerColor =
                                                          AppColors
                                                              .kPrimaryColor;
                                                      return Colors
                                                          .white; // Selected color for the radio button
                                                    }
                                                    basketController
                                                            .containerColor =
                                                        AppColors.kWhiteColor;
                                                    return AppColors
                                                        .kPrimaryColor;
                                                  }),
                                                  activeColor:
                                                      AppColors.kWhiteColor,
                                                  value: 'user_balance',
                                                  groupValue: basketController
                                                      .selectedPaymentMethod
                                                      .value,
                                                  onChanged: (value) {
                                                    if (num.parse(
                                                                "${basketController.totalOrderDetails.value.totalPrice ?? '0'}") +
                                                            num.parse(basketController
                                                                    .totalOrderDelivery
                                                                    .value
                                                                    .shippingCost ??
                                                                '0') >
                                                        num.parse(controller2
                                                            .walletAmountState
                                                            .value)) {
                                                      showDialog(
                                                          context: context,
                                                          builder: (BuildContext
                                                              context) {
                                                            return CustomAlertDialog(
                                                              buttonTwo: false,
                                                              dilougText: tr(
                                                                  'no_enaph_money'),
                                                              buttonOneText:
                                                                  tr('okay'),
                                                            );
                                                          });
                                                    } else {
                                                      basketController
                                                          .selectPaymentMethod(
                                                              value.toString());
                                                    }
                                                  }),
                                              // ),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsets.only(left: 10.w),
                                            child: Align(
                                              alignment: Alignment.bottomLeft,
                                              child: SvgPicture.asset(
                                                  AppImages.kqueencrownImage),
                                            ),
                                          ),
                                        ],
                                      )),
                                ),
                        }
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 20),
                width: MediaQuery.of(context).size.width,
                decoration:
                    BoxDecoration(color: AppColors.kWhiteColor, boxShadow: [
                  BoxShadow(
                    blurRadius: 10.r,
                    offset: const Offset(0, 4),
                    spreadRadius: 0,
                  ),
                ]),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    // SizedBox(width: 30.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          tr('total'),
                          style: TextStyle(
                              fontFamily: kTheArabicSansLight,
                              fontSize: 15.83.sp,
                              fontWeight: FontWeight.w500,
                              color: AppColors.klPinkColor),
                        ),
                        Text(
                          '${num.parse("${basketController.totalOrderDetails.value.totalPrice ?? '0'}") + num.parse(basketController.totalOrderDelivery.value.shippingCost ?? '0')} ${tr('Del')}',
                          style: TextStyle(
                              fontFamily: kTheArabicSansLight,
                              fontSize: 24.sp,
                              fontWeight: FontWeight.w400,
                              color: AppColors.kPrimaryColor),
                        )
                      ],
                    ),
                    GestureDetector(
                      onTap: () async {
                        LoadingScreen.show(context);
                        await basketController.sendToCreateOrder(
                            email: controller.userData.value.email ?? '',
                            name: controller.userData.value.name ?? '');
                        Navigator.of(context).pop();
                        basketController.changeTab(2);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        width: MediaQuery.of(context).size.width / 2,
                        decoration: BoxDecoration(
                          color: AppColors.kPrimaryColor,
                          borderRadius: BorderRadius.circular(46.r),
                        ),
                        child: Center(
                          child: Text(
                            tr('continus'),
                            style: TextStyle(
                                fontFamily: kTheArabicSansLight,
                                fontSize: 24.sp,
                                fontWeight: FontWeight.w500,
                                color: AppColors.kWhiteColor),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
