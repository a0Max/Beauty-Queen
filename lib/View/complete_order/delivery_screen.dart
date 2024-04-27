import 'dart:developer';

import 'package:beauty_queen/const/app_images.dart';
import 'package:beauty_queen/const/extensions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../const/app_colors.dart';
import '../../const/styles.dart';
import '../../const/validator.dart';
import '../../const/vars.dart';
import '../../controller/auth_controller/auth_controler.dart';
import '../../controller/complete_order_controller/basketController.dart';
import '../../controller/wallet_controller/wallet_controller.dart';
import '../../models/city_area_model.dart';
import 'package:quiver/strings.dart';
import '../../models/way_to_pay.dart';
import '../../widgets/auth_widgets/text_field_auth_widget.dart';
import '../../widgets/based/error_pop_up.dart';
import '../../widgets/based/loading.dart';
import '../../widgets/complete_order/dotted_line_painter.dart';
import '../../widgets/product_profile/CustomAlertBox.dart';

class DeliveryScreen extends StatefulWidget {
  const DeliveryScreen({super.key});

  @override
  State<DeliveryScreen> createState() => _DeliveryScreenState();
}

class _DeliveryScreenState extends State<DeliveryScreen> {
  AuthController controller = Get.put(AuthController());
  final BasketController basketController = Get.put(BasketController());
  TextEditingController addressController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController extraNoteController = TextEditingController(
      text: kDebugMode ? 'هذا الاوردر هو عبارة عن test' : '');
  WalletController controller2 = Get.put(WalletController());

  WayToPay? resultOfWayToPay;
  List<WayToPay> listOfWayToPay = [];
  @override
  void initState() {
    super.initState();
    basketController.getTotalOrderDetails();
    getDataOrder();
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  getDataOrder() async {
    await controller2.getAllWallet();
    listOfWayToPay
        .add(WayToPay(wayToPay: "نقداً عند الاستلام", keyOfWayToPay: 'cash'));
    if (controller.userData.value.accountType == AccountTypes.queena) {
      log('controller2.walletAmountState.value:${controller2.walletAmountState.value}');
      listOfWayToPay.add(WayToPay(
          wayToPay: "${controller2.walletAmountState.value}محفظتي ",
          price: controller2.walletAmountState.value,
          keyOfWayToPay: 'user_balance'));
    }
    basketController.selectPaymentMethod('cash');
    setState(() {
      resultOfWayToPay = listOfWayToPay.first;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? saveOrderState = prefs.getBool('saveDataOrder');
    if (saveOrderState == true) {
      addressController =
          TextEditingController(text: prefs.getString('address'));
      phoneController = TextEditingController(text: prefs.getString('phone'));
      extraNoteController =
          TextEditingController(text: prefs.getString('note'));
      String? countryId = prefs.getString('cityId');
      String? areaId = prefs.getString('areaId');
      if (countryId != null) {
        final cityList = controller.citiesData.value
            .where((element) => "${element.id}" == countryId);
        if (cityList.isNotEmpty) {
          CityAreaModel tempCity = cityList.first;
          await basketController.updateSelectedCity(newCity: tempCity);
        }
      }
      if (areaId != null) {
        final areaList = basketController.areaData.value.areas
            ?.where((element) => "${element.id}" == areaId);

        if (areaList?.isNotEmpty ?? false) {
          CityAreaModel tempArea = areaList?.first ?? CityAreaModel();
          basketController.updateSelectedArea(newArea: tempArea);
        }
      }
      basketController.updateChecked(newCheck: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: AppColors.kTextGrayColor.withOpacity(.1),
      body: Obx(
        () => SingleChildScrollView(
            child: Column(
          children: [
            Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20.h,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 19.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'تحديد طريقة استلام الطلب',
                          style: kTheSansTextStyle.copyWith(
                              fontWeight: FontWeight.w700,
                              fontFamily: kTheArabicSansBold,
                              fontSize: 15.sp),
                        ),
                        5.ph,
                        GestureDetector(
                          onTap: () {
                            basketController.selectPaymentMethod2('1');
                          },
                          child: Row(
                            children: [
                              Icon(
                                Icons.radio_button_checked,
                                color: AppColors.kPrimaryColor,
                              ),
                              Text(
                                'الاستلام بخدمة التوصيل',
                                style: TextStyle(
                                    fontFamily: kTheArabicSansLight,
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.kPrimaryColor),
                              ),
                            ],
                          ),
                        ),
                        5.ph,
                        GestureDetector(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return CustomAlertDialog(
                                    buttonTwo: false,
                                    dilougText: tr('not_availble_now2'),
                                    buttonOneText: tr('okay'),
                                  );
                                });
                          },
                          child: Row(
                            children: [
                              Icon(
                                Icons.radio_button_off,
                                color: AppColors.greyColor.withOpacity(.4),
                              ),
                              Text(
                                'الحجز و الاستلام من المتجر',
                                style: TextStyle(
                                    fontFamily: kTheArabicSansLight,
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.kPrimaryColor),
                              ),
                            ],
                          ),
                        ),
                        30.ph,
                        Container(
                          // margin: EdgeInsets.symmetric(horizontal: 15.w),
                          padding: EdgeInsets.symmetric(horizontal: 15.w),
                          height: 49.76.h,
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(11.06.r),
                            border: Border.all(
                                width: 1.11.w, color: const Color(0xFFD9DEE2)),
                          ),
                          child: DropdownButton<CityAreaModel>(
                            underline: const SizedBox(),
                            iconEnabledColor: Colors.transparent,
                            isDense: true,
                            onTap: () => log('open'),
                            isExpanded: true,
                            value: basketController.selectedCityData.value.id ==
                                    null
                                ? null
                                : basketController.selectedCityData.value,
                            items: controller.citiesData.value.map((value) {
                              return DropdownMenuItem<CityAreaModel>(
                                value: value,
                                child: Text(value.name,
                                    style: TextStyle(
                                      color: AppColors.kBlackColor,
                                      fontSize: 14.sp,
                                      fontFamily: kTheArabicSansLight,
                                      fontWeight: FontWeight.w400,
                                      height: 0,
                                    )),
                              );
                            }).toList(),
                            onChanged: (CityAreaModel? newValue) {
                              basketController.updateSelectedCity(
                                  newCity: newValue ?? CityAreaModel());
                            },
                            hint: Text(
                              tr('city'),
                              style: TextStyle(
                                color: const Color(0xFF2C3E50),
                                fontSize: 17.69.sp,
                                fontFamily: kTheArabicSansLight,
                                fontWeight: FontWeight.w600,
                              ),
                              textAlign: TextAlign.start,
                            ),
                            icon: const Icon(
                              Icons.arrow_drop_down,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        if (basketController.loadingArea.value == true) ...{
                          const Center(
                            child: CupertinoActivityIndicator(),
                          )
                        } else if (basketController.loadingArea.value != true &&
                            (basketController
                                    .areaData.value.areas?.isNotEmpty ??
                                false) &&
                            basketController.selectedCityData.value.hasArea !=
                                "0") ...{
                          Column(
                            children: [
                              15.ph,
                              Container(
                                // margin: EdgeInsets.symmetric(horizontal: 15.w),
                                padding: EdgeInsets.symmetric(horizontal: 15.w),
                                height: 49.76.h,
                                alignment: Alignment.center,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(11.06.r),
                                  border: Border.all(
                                      width: 1.11.w,
                                      color: const Color(0xFFD9DEE2)),
                                ),
                                child: DropdownButton<CityAreaModel>(
                                  underline: const SizedBox(),
                                  iconEnabledColor: Colors.transparent,
                                  isDense: true,
                                  isExpanded: true,
                                  value: basketController
                                              .selectedAreaData.value.id ==
                                          null
                                      ? null
                                      : basketController.selectedAreaData.value,
                                  items: basketController.areaData.value.areas
                                      ?.map((value) {
                                    return DropdownMenuItem<CityAreaModel>(
                                      value: value,
                                      child: Text(value.name ?? '',
                                          style: TextStyle(
                                            color: const Color(0xFF2C3E50),
                                            fontSize: 17.69.sp,
                                            fontFamily: kTheArabicSansLight,
                                            fontWeight: FontWeight.w600,
                                          )),
                                    );
                                  }).toList(),
                                  onChanged: (CityAreaModel? newValue) {
                                    basketController.updateSelectedArea(
                                        newArea: newValue ?? CityAreaModel());
                                  },
                                  hint: Text(
                                    tr('area'),
                                    style: TextStyle(
                                      color: AppColors.kBlackColor,
                                      fontSize: 18.sp,
                                      fontFamily: kTheArabicSansLight,
                                      fontWeight: FontWeight.w400,
                                      height: 0,
                                    ),
                                    textAlign: TextAlign.start,
                                  ),
                                  icon: const Icon(
                                    Icons.arrow_drop_down,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          )
                        },
                        15.ph,
                        TextFieldAuthWidget(
                          hindText: tr('address'),
                          controler: addressController,
                          hintStyle: TextStyle(
                            color: const Color(0xFF2C3E50),
                            fontSize: 17.69.sp,
                            fontFamily: kTheArabicSansLight,
                            fontWeight: FontWeight.w600,
                          ),
                          keyboardType: TextInputType.name,
                          validatorTextField: (val) {
                            return Validator().validatorRequired(val);
                          },
                        ),
                        15.ph,
                        TextFieldAuthWidget(
                          hindText: tr('kEnterYourPhoneNumber'),
                          // titleText: tr('kPhoneNumber'),
                          controler: phoneController,
                          keyboardType: TextInputType.phone,
                          hintStyle: TextStyle(
                            color: const Color(0xFF2C3E50),
                            fontSize: 17.69.sp,
                            fontFamily: kTheArabicSansLight,
                            fontWeight: FontWeight.w600,
                          ),
                          validatorTextField: (val) {
                            return Validator().validatorPhoneNumber(val);
                          },
                        ),
                        15.ph,
                        TextFieldAuthWidget(
                          hindText: tr('extra_note'),
                          controler: extraNoteController,
                          hintStyle: TextStyle(
                            color: const Color(0xFF2C3E50),
                            fontSize: 17.69.sp,
                            fontFamily: kTheArabicSansLight,
                            fontWeight: FontWeight.w600,
                          ),
                          keyboardType: TextInputType.name,
                        ),
                        15.ph,
                        Container(
                          // margin: EdgeInsets.symmetric(horizontal: 15.w),
                          padding: EdgeInsets.symmetric(horizontal: 15.w),
                          height: 49.76.h,
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(11.06.r),
                            border: Border.all(
                                width: 1.11.w, color: const Color(0xFFD9DEE2)),
                          ),
                          child: DropdownButton<WayToPay>(
                            underline: const SizedBox(),
                            iconEnabledColor: Colors.transparent,
                            isDense: true,
                            // onTap: () => log('open'),
                            isExpanded: true,
                            value: resultOfWayToPay,
                            //             ==
                            //         null
                            //     ? null
                            //     : basketController.selectedCityData.value,
                            items: listOfWayToPay.map((value) {
                              return DropdownMenuItem<WayToPay>(
                                value: value,
                                child: Text(value.wayToPay,
                                    style: TextStyle(
                                      color: AppColors.kBlackColor,
                                      fontSize: 14.sp,
                                      fontFamily: kTheArabicSansLight,
                                      fontWeight: FontWeight.w400,
                                      height: 0,
                                    )),
                              );
                            }).toList(),
                            onChanged: (WayToPay? newValue) {
                              setState(() {
                                resultOfWayToPay = newValue;
                              });
                              if (newValue?.keyOfWayToPay == 'cash') {
                                basketController.selectPaymentMethod('cash');
                              } else if (newValue?.keyOfWayToPay ==
                                  'user_balance') {
                                if (num.parse(
                                            "${basketController.totalOrderDetails.value.totalPrice ?? '0'}") +
                                        num.parse(basketController
                                                .totalOrderDelivery
                                                .value
                                                .shippingCost ??
                                            '0') >
                                    num.parse(
                                        controller2.walletAmountState.value)) {
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
                              }

                              // basketController.updateSelectedCity(
                              //     newCity: newValue ?? CityAreaModel());
                            },
                            hint: Text(
                              'طريقة الدقع',
                              style: TextStyle(
                                color: const Color(0xFF2C3E50),
                                fontSize: 17.69.sp,
                                fontFamily: kTheArabicSansLight,
                                fontWeight: FontWeight.w600,
                              ),
                              textAlign: TextAlign.start,
                            ),
                            icon: const Icon(
                              Icons.arrow_drop_down,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        15.ph,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'تكلفه التوصيل:',
                              style: TextStyle(
                                  fontFamily: kTheArabicSansBold,
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.mainColor),
                            ),
                            Text(
                              basketController
                                      .totalOrderDelivery.value.shippingCost ??
                                  '',
                              style: TextStyle(
                                  fontFamily: kTheArabicSansLight,
                                  fontSize: 19.sp,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.kBlackColor),
                            ),
                          ],
                        ),
                        10.ph,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'الوقت المتوقع للوصول:',
                              style: TextStyle(
                                  fontFamily: kTheArabicSansBold,
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.mainColor),
                            ),
                            Text(
                              basketController
                                      .totalOrderDelivery.value.shippingTime ??
                                  '',
                              style: TextStyle(
                                  fontFamily: kTheArabicSansLight,
                                  fontSize: 19.sp,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.kBlackColor),
                            ),
                          ],
                        ),
                        10.ph,
                        Row(
                          children: [
                            SizedBox(
                              height: 28.h,
                              width: 28.w,
                              child: Checkbox(
                                side: BorderSide(
                                    color: AppColors.kTextGrayColor,
                                    width: 1.5.w),
                                checkColor: AppColors.kWhiteColor,
                                activeColor: AppColors.kPrimaryColor,
                                value: basketController.isChecked.value,
                                onChanged: (bool? value) {
                                  basketController.updateChecked(
                                      newCheck: value);
                                },
                              ),
                            ),
                            SizedBox(
                                width: 8
                                    .w), // Add some spacing between the checkbox and text
                            SizedBox(
                              width: MediaQuery.of(context).size.width -
                                  (8.w +
                                      28.w +
                                      15.w +
                                      15.w +
                                      19.w +
                                      19.w +
                                      2.w),
                              child: Text(
                                'حفظ البيانات للإستخدام في المرة القادمة',
                                style: TextStyle(
                                    fontFamily: kTheArabicSansLight,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.kBlackColor),
                                overflow: TextOverflow.visible,
                              ),
                            ),
                          ],
                        ),
                        10.ph,
                        Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'إجمالي الطلب:',
                              style: TextStyle(
                                  fontFamily: kTheArabicSansBold,
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.mainColor),
                            ),
                            20.pw,
                            Text(
                              '${num.parse("${basketController.totalOrderDetails.value.totalPrice ?? '0'}") + num.parse(basketController.totalOrderDelivery.value.shippingCost ?? '0')} ${tr('Del')}',
                              style: TextStyle(
                                  fontFamily: kTheArabicSansLight,
                                  fontSize: 21.sp,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.kPrimaryColor),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 20.h,
                ),
                GestureDetector(
                  onTap: () async {
                    if (basketController.selectedPaymentMethod2.value == '1') {
                      if (!_formKey.currentState!.validate()) {
                        return;
                      }
                      _formKey.currentState!.save();
                      if (basketController.selectedCityData.value.id
                              .toString() ==
                          'null') {
                        ErrorPopUp(message: tr('city_required'), title: 'خطا');
                        return;
                      }
                      if (basketController.selectedAreaData.value.id
                                  .toString() ==
                              'null' &&
                          basketController.selectedCityData.value.hasArea ==
                              '1') {
                        ErrorPopUp(message: tr('area_required'), title: 'خطا');
                        return;
                      }
                    }
                    basketController.addAddressTextAndNote(
                        address: addressController.text,
                        phone: phoneController.text,
                        note: extraNoteController.text);
                    LoadingScreen.show(context);
                    await basketController.sendToCreateOrder(
                        email: controller.userData.value.email ?? '',
                        name: controller.userData.value.name ?? '');
                    Navigator.of(context).pop();
                    basketController.changeTab(1);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    width: MediaQuery.of(context).size.width - 40,
                    decoration: BoxDecoration(
                      color: AppColors.kPrimaryColor,
                      // borderRadius: BorderRadius.circular(46.r),
                    ),
                    child: Center(
                      child: Text(
                        tr('continus'),
                        style: TextStyle(
                            fontFamily: kTheArabicSansLight,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColors.kWhiteColor),
                      ),
                    ),
                  ),
                ),
                10.ph,
                GestureDetector(
                  onTap: () async {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    width: MediaQuery.of(context).size.width - 40,
                    decoration: BoxDecoration(
                      color: AppColors.kPrimaryColor,
                      // borderRadius: BorderRadius.circular(46.r),
                    ),
                    child: Center(
                      child: Text(
                        'الرجوع',
                        style: TextStyle(
                            fontFamily: kTheArabicSansLight,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColors.kWhiteColor),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        )),
      ),
    );
  }
}
