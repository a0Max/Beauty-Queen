import 'dart:developer';

import 'package:beauty_queen/const/app_images.dart';
import 'package:beauty_queen/const/extensions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../const/app_colors.dart';
import '../../const/styles.dart';
import '../../const/validator.dart';
import '../../controller/auth_controller/auth_controler.dart';
import '../../controller/complete_order_controller/basketController.dart';
import '../../models/city_area_model.dart';
import 'package:quiver/strings.dart';
import '../../widgets/auth_widgets/text_field_auth_widget.dart';
import '../../widgets/based/error_pop_up.dart';
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

  @override
  void initState() {
    super.initState();
    basketController.getTotalOrderDetails();
    getDataOrder();
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  getDataOrder() async {
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
      backgroundColor: AppColors.kTextGrayColor.withOpacity(.1),
      body: Obx(() => Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                    child: Form(
                  key: _formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 19.w),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 20.h,
                            ),
                            Row(
                              children: [
                                Image.asset(
                                  AppImages.carImage,
                                  width: 30,
                                  height: 30,
                                ),
                                SizedBox(
                                  width: 16.w,
                                ),
                                Text(
                                  'طريقة الإستلام',
                                  style: TextStyle(
                                      fontFamily: kTheArabicSansLight,
                                      fontSize: 22.sp,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.kBlackColor),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 33.h,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.symmetric(
                                vertical: BorderSide(
                                    color: AppColors.kTextGrayColor
                                        .withOpacity(.3)))),
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.symmetric(vertical: 15),
                        child: Column(
                          children: [
                            ListTile(
                              leading: Transform.scale(
                                scale: 1.5,
                                child: Radio(
                                  fillColor:
                                      MaterialStateProperty.resolveWith<Color>(
                                          (states) {
                                    return AppColors
                                        .kPrimaryColor; // Unselected color for the radio button
                                  }),
                                  activeColor: AppColors.kWhiteColor,
                                  value: '1',
                                  groupValue: basketController
                                      .selectedPaymentMethod2.value,
                                  onChanged: (value) => basketController
                                      .selectPaymentMethod2(value.toString()),
                                ),
                              ),
                              title: Text(
                                'الاستلام بخدمة التوصيل',
                                style: TextStyle(
                                    fontFamily: kTheArabicSansLight,
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.kPrimaryColor),
                              ),
                            ),
                            Divider(
                              color: AppColors.kTextGrayColor.withOpacity(.3),
                              thickness: 1.w,
                              indent: 10.w,
                              endIndent: 10.w,
                            ),
                            30.ph,
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 15.w),
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
                                onTap: () => log('open'),
                                isExpanded: true,
                                value: basketController
                                            .selectedCityData.value.id ==
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
                            20.ph,
                            if (basketController.loadingArea.value == true) ...{
                              const Center(
                                child: CupertinoActivityIndicator(),
                              )
                            } else if (basketController.loadingArea.value !=
                                    true &&
                                (basketController
                                        .areaData.value.areas?.isNotEmpty ??
                                    false) &&
                                basketController
                                        .selectedCityData.value.hasArea !=
                                    "0") ...{
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 15.w),
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
                            },
                            20.ph,
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 15.w),
                              child: TextFieldAuthWidget(
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
                            ),
                            20.ph,
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 15.w),
                              child: TextFieldAuthWidget(
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
                            ),
                            20.ph,
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 15.w),
                              child: TextFieldAuthWidget(
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
                            ),
                            20.ph,
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 15.w),
                              child: Row(
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
                            ),
                          ],
                        ),
                      ),
                      Container(
                        color: AppColors.kTextGrayColor.withOpacity(.1),
                        child: Column(
                          children: [
                            15.ph,
                            Padding(
                              padding:
                                  EdgeInsets.symmetric(horizontal: 20.55.w),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'تكلفه التوصيل:',
                                    style: TextStyle(
                                        fontFamily: kTheArabicSansLight,
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.kBlackColor),
                                  ),
                                  Text(
                                    basketController.totalOrderDelivery.value
                                            .shippingCost ??
                                        '',
                                    style: TextStyle(
                                        fontFamily: kTheArabicSansLight,
                                        fontSize: 19.sp,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.kBlackColor),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsets.symmetric(horizontal: 20.55.w),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'الوقت المتوقع للوصول:',
                                    style: TextStyle(
                                        fontFamily: kTheArabicSansLight,
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.kBlackColor),
                                  ),
                                  Text(
                                    basketController.totalOrderDelivery.value
                                            .shippingTime ??
                                        '',
                                    style: TextStyle(
                                        fontFamily: kTheArabicSansLight,
                                        fontSize: 19.sp,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.kBlackColor),
                                  ),
                                ],
                              ),
                            ),
                            15.ph,
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: CustomPaint(
                                painter: DottedLinePainter(),
                              ),
                            ),
                            15.ph,
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16.w),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '${tr('total')}:',
                                    style: TextStyle(
                                        fontFamily: kTheArabicSansLight,
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.kBlackColor),
                                  ),
                                  Text(
                                    '${num.parse("${basketController.totalOrderDetails.value.totalPrice ?? '0'}") + num.parse(basketController.totalOrderDelivery.value.shippingCost ?? '0')} ${tr('Del')}',
                                    style: TextStyle(
                                        fontFamily: kTheArabicSansLight,
                                        fontSize: 21.sp,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.kPrimaryColor),
                                  ),
                                ],
                              ),
                            ),
                            15.ph
                          ],
                        ),
                      ),
                      Container(
                        color: AppColors.kTextGrayColor.withOpacity(.4),
                        height: 10.h,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          color: AppColors.kTextGrayColor.withOpacity(.1),
                        ),
                        child: Column(
                          children: [
                            15.ph,
                            Row(children: <Widget>[
                              Expanded(
                                  child: Divider(
                                endIndent: 10.w,
                                color: AppColors.kTextGrayColor.withOpacity(.3),
                                thickness: 1.w,
                                indent: 10.w,
                              )),
                              Text(
                                'أو',
                                style: TextStyle(
                                    fontFamily: kTheArabicSansLight,
                                    fontSize: 28.sp,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.kBlackColor),
                              ),
                              Expanded(
                                  child: Divider(
                                endIndent: 10.w,
                                color: AppColors.kTextGrayColor.withOpacity(.3),
                                thickness: 1.w,
                                indent: 10.w,
                              )),
                            ]),
                            15.ph,
                            Row(
                              children: [
                                Expanded(
                                  child: ListTile(
                                    leading: Transform.scale(
                                      scale: 1.5,
                                      child: Radio(
                                        fillColor: MaterialStateProperty
                                            .resolveWith<Color>((states) {
                                          return AppColors
                                              .kPrimaryColor; // Unselected color for the radio button
                                        }),
                                        activeColor: AppColors.kWhiteColor,
                                        value: '2',
                                        groupValue: basketController
                                            .selectedPaymentMethod2.value,
                                        onChanged: (value) {
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return CustomAlertDialog(
                                                  buttonTwo: false,
                                                  dilougText:
                                                      tr('not_availble_now2'),
                                                  buttonOneText: tr('okay'),
                                                );
                                              });
                                          // basketController
                                          //     .selectPaymentMethod2(
                                          //     value.toString());
                                        },
                                      ),
                                    ),
                                    title: Text(
                                      'الحجز والإستلام من المتجر',
                                      style: TextStyle(
                                          fontFamily: kTheArabicSansLight,
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.kTextGrayColor),
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        bottom: 10.h, left: 10.w),
                                    child: Container(
                                      clipBehavior: Clip.none,
                                      height: 35.52.h,
                                      width: 80.19.w,
                                      decoration: BoxDecoration(
                                          color: AppColors.kPrimaryColor,
                                          borderRadius:
                                              BorderRadius.circular(22.24.r)),
                                      child: Center(
                                        child: Text(
                                          'قريباً..',
                                          style: TextStyle(
                                              fontFamily: kTheArabicSansLight,
                                              fontSize: 17.sp,
                                              fontWeight: FontWeight.w600,
                                              color: AppColors.kWhiteColor),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 160.h,
                      ),
                    ],
                  ),
                )),
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
                              fontWeight: FontWeight.bold,
                              color: AppColors.kPrimaryColor),
                        )
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        if (basketController.selectedPaymentMethod2.value ==
                            '1') {
                          if (!_formKey.currentState!.validate()) {
                            return;
                          }
                          _formKey.currentState!.save();
                          if (basketController.selectedCityData.value.id
                                  .toString() ==
                              'null') {
                            ErrorPopUp(
                                message: tr('city_required'), title: 'خطا');
                            return;
                          }
                          if (basketController.selectedAreaData.value.id
                                      .toString() ==
                                  'null' &&
                              basketController.selectedCityData.value.hasArea ==
                                  '1') {
                            ErrorPopUp(
                                message: tr('area_required'), title: 'خطا');
                            return;
                          }
                        }
                        basketController.addAddressTextAndNote(
                            address: addressController.text,
                            phone: phoneController.text,
                            note: extraNoteController.text);
                        basketController.changeTab(1);
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
