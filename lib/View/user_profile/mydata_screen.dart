import 'package:beauty_queen/const/extensions.dart';
import 'package:beauty_queen/models/brand_model.dart';
import 'package:beauty_queen/widgets/based/custom_button.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../const/app_colors.dart';
import '../../const/styles.dart';
import '../../const/validator.dart';
import '../../const/vars.dart';
import '../../controller/auth_controller/auth_controler.dart';
import '../../models/city_area_model.dart';
import '../../widgets/auth_widgets/text_field_auth_widget.dart';
import '../../widgets/based/error_pop_up.dart';

class MyDataScreen extends StatefulWidget {
  const MyDataScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MyDataScreen();
  }
}

class _MyDataScreen extends State<MyDataScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController nickNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController whatsAppController = TextEditingController();
  TextEditingController phoneController2 = TextEditingController();
  TextEditingController emailController = TextEditingController();
  // TextEditingController birthDayController = TextEditingController();
  AuthController controller = Get.put(AuthController());

  showDatePickerDialog() async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1950),
        lastDate: DateTime(DateTime.now().year + 1));

    if (pickedDate != null) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
      controller.updateDateTime(newDateTime: formattedDate);
    } else {}
  }

  @override
  void initState() {
    super.initState();
    controller.clearBrand();

    nameController =
        TextEditingController(text: controller.userData.value.name);
    phoneController =
        TextEditingController(text: controller.userData.value.phone);
    nickNameController =
        TextEditingController(text: controller.userData.value.lastName);

    whatsAppController =
        TextEditingController(text: controller.userData.value.whatsappPhone);
    if (controller.userData.value.accountType == AccountTypes.queena) {
      compliteDataOfQueenaAccount();
    }
  }

  compliteDataOfQueenaAccount() async {
    await controller.getBrandsDataController();
    if (controller.userData.value.cityId != null) {
      final cityList = controller.citiesData.value.where(
          (element) => "${element.id}" == controller.userData.value.cityId);

      if (cityList.isNotEmpty) {
        CityAreaModel tempCity = cityList.first;
        await controller.updateSelectedCity(newCity: tempCity);
      }
      if (controller.userData.value.areaId != null) {
        final areaList = controller.areaData.value.where(
            (element) => "${element.id}" == controller.userData.value.areaId);

        if (areaList.isNotEmpty) {
          CityAreaModel tempArea = areaList.first;
          controller.updateSelectedArea(newArea: tempArea);
        }
      }
    }
    if (controller.userData.value.birthDate != null) {
      DateTime dateTime =
          DateTime.parse(controller.userData.value.birthDate ?? '');
      String formattedDate = DateFormat('yyyy-MM-dd').format(dateTime);
      controller.updateDateTime(newDateTime: formattedDate);
    }

    if (controller.userData.value.brand1 != null) {
      final brandList = controller.brandsData.value.where(
          (element) => "${element.id}" == controller.userData.value.brand1);
      if (brandList.isNotEmpty) {
        BrandModel tempBrand = brandList.first;
        controller.updateSelectedBrand1(newBrand: tempBrand);
      }
    }

    if (controller.userData.value.brand2 != null) {
      final brandList = controller.brandsData.value.where(
          (element) => "${element.id}" == controller.userData.value.brand2);
      if (brandList.isNotEmpty) {
        BrandModel tempBrand = brandList.first;
        controller.updateSelectedBrand2(newBrand: tempBrand);
      }
    }

    if (controller.userData.value.brand3 != null) {
      final brandList = controller.brandsData.value.where(
          (element) => "${element.id}" == controller.userData.value.brand3);
      if (brandList.isNotEmpty) {
        BrandModel tempBrand = brandList.first;
        controller.updateSelectedBrand3(newBrand: tempBrand);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
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
          tr('ourData'),
          style: TextStyle(
              fontFamily: kTheArabicSansLight,
              color: AppColors.kBlackColor,
              fontSize: 27.sp,
              fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: Obx(() => Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 30.h,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextFieldAuthWidget(
                          hindText: tr('kFirstNameHint'),
                          titleText: tr('kFirstNameHint'),
                          controler: nameController,
                          readOnly: controller.allowToEdit.value == false
                              ? true
                              : null,
                          hintStyle: TextStyle(
                            color: const Color(0xFF2C3E50),
                            fontSize: 17.69.sp,
                            fontFamily: kTheArabicSansLight,
                            fontWeight: FontWeight.w600,
                          ),
                          keyboardType: TextInputType.name,
                          validatorTextField: (val) {
                            return Validator().validatorName(val);
                          },
                        ),
                      ),
                      13.pw,
                      Expanded(
                        child: TextFieldAuthWidget(
                          hindText: tr('nackName'),
                          titleText: tr('nackName'),
                          readOnly: controller.allowToEdit.value == false
                              ? true
                              : null,
                          controler: nickNameController,
                          hintStyle: TextStyle(
                            color: const Color(0xFF2C3E50),
                            fontSize: 17.69.sp,
                            fontFamily: kTheArabicSansLight,
                            fontWeight: FontWeight.w600,
                          ),
                          keyboardType: TextInputType.name,
                          validatorTextField: (val) {
                            return Validator().validatorName(val);
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  if (controller.userData.value.accountType ==
                      AccountTypes.queena) ...{
                    TextFieldAuthWidget(
                      hindText: tr('whatsApp'),
                      titleText: tr('whatsApp'),
                      readOnly:
                          controller.allowToEdit.value == false ? true : null,
                      controler: whatsAppController,
                      hintStyle: TextStyle(
                        color: const Color(0xFF2C3E50),
                        fontSize: 17.69.sp,
                        fontFamily: kTheArabicSansLight,
                        fontWeight: FontWeight.w600,
                      ),
                      keyboardType: TextInputType.name,
                      validatorTextField: (val) {
                        return Validator().validatorName(val);
                      },
                    ),
                    TextFieldAuthWidget(
                      hindText: tr('subPhone'),
                      titleText: tr('subPhone'),
                      readOnly:
                          controller.allowToEdit.value == false ? true : null,
                      controler: phoneController2,
                      hintStyle: TextStyle(
                        color: const Color(0xFF2C3E50),
                        fontSize: 17.69.sp,
                        fontFamily: kTheArabicSansLight,
                        fontWeight: FontWeight.w600,
                      ),
                      keyboardType: TextInputType.name,
                      validatorTextField: (val) {
                        return Validator().validatorName(val);
                      },
                    ),
                    TextFieldAuthWidget(
                      hindText: tr('email'),
                      titleText: tr('email'),
                      readOnly:
                          controller.allowToEdit.value == false ? true : null,
                      controler: emailController,
                      hintStyle: TextStyle(
                        color: const Color(0xFF2C3E50),
                        fontSize: 17.69.sp,
                        fontFamily: kTheArabicSansLight,
                        fontWeight: FontWeight.w600,
                      ),
                      keyboardType: TextInputType.name,
                      validatorTextField: (val) {
                        return Validator().validatorName(val);
                      },
                    ),
                    TextFieldAuthWidget(
                      hindText: tr('birthDay'),
                      titleText: tr('birthDay'),
                      readOnly: true,
                      onTap: () {
                        if (controller.allowToEdit.value == true) {
                          showDatePickerDialog();
                        }
                      },
                      controler: TextEditingController(
                          text: controller.dateTime.value),
                      hintStyle: TextStyle(
                        color: const Color(0xFF2C3E50),
                        fontSize: 17.69.sp,
                        fontFamily: kTheArabicSansLight,
                        fontWeight: FontWeight.w600,
                      ),
                      keyboardType: TextInputType.phone,
                      validatorTextField: (val) {
                        return Validator().validatorName(val);
                      },
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                  },
                  ///////////second/////////////
                  TextFieldAuthWidget(
                    hindText: tr('kPhoneNumber'),
                    titleText: tr('kPhoneNumber'),
                    controler: phoneController,
                    readOnly: true,
                    hintStyle: TextStyle(
                      color: const Color(0xFF2C3E50),
                      fontSize: 17.69.sp,
                      fontFamily: kTheArabicSansLight,
                      fontWeight: FontWeight.w600,
                    ),
                    keyboardType: TextInputType.phone,
                    validatorTextField: (val) {
                      return Validator().validatorPhoneNumber(val);
                    },
                  ),
                  ///////////////third////////////

                  if (controller.userData.value.accountType ==
                      AccountTypes.queena) ...{
                    SizedBox(
                      height: 20.h,
                    ),
                    Text(
                      tr('city'),
                      style: TextStyle(
                        color: AppColors.kSecondaryColor,
                        fontSize: 18.79.sp,
                        fontFamily: kTheArabicSansLight,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Container(
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
                        // onTap:  controller.allowToEdit.value==true?null:log('open')
                        // ,
                        isExpanded: true,
                        value: controller.selectedCityData.value.id == null
                            ? null
                            : controller.selectedCityData.value,
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
                        onChanged: controller.allowToEdit.value != true
                            ? null
                            : (CityAreaModel? newValue) {
                                controller.updateSelectedCity(
                                    newCity: newValue ?? CityAreaModel());
                              },
                        hint: Text(
                          tr('city'),
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
                    SizedBox(
                      height: 20.h,
                    ),
                    if (controller.loadingArea.value == true) ...{
                      const Center(
                        child: CupertinoActivityIndicator(),
                      )
                    } else if (controller.loadingArea.value != true &&
                        controller.areaData.value.isNotEmpty &&
                        controller.selectedCityData.value.hasArea != "0") ...{
                      Text(
                        tr('area'),
                        style: TextStyle(
                          color: AppColors.kSecondaryColor,
                          fontSize: 18.79.sp,
                          fontFamily: kTheArabicSansLight,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Container(
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
                          isExpanded: true,
                          value: controller.selectedAreaData.value.id == null
                              ? null
                              : controller.selectedAreaData.value,
                          items: controller.areaData.value.map((value) {
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
                          onChanged: controller.allowToEdit.value != true
                              ? null
                              : (CityAreaModel? newValue) {
                                  controller.updateSelectedArea(
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
                    SizedBox(
                      height: 10.h,
                    ),
                    if (controller.loadingBrands.value == true &&
                        controller.brandsData.value.isEmpty) ...{
                      const Center(
                        child: CupertinoActivityIndicator(),
                      )
                    } else if (controller.loadingBrands.value != true &&
                        controller.brandsData.value.isNotEmpty) ...{
                      Text(
                        tr('yourBest3'),
                        style: TextStyle(
                          color: AppColors.mainColor,
                          fontSize: 18.79.sp,
                          fontFamily: kTheArabicSansLight,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            tr('brand1'),
                            style: TextStyle(
                              color: AppColors.kSecondaryColor,
                              fontSize: 18.79.sp,
                              fontFamily: kTheArabicSansLight,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(height: 10.h),
                          Container(
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
                            child: DropdownButton<BrandModel>(
                              underline: const SizedBox(),
                              iconEnabledColor: Colors.transparent,
                              isDense: true,
                              isExpanded: true,
                              value:
                                  controller.selectedBrandData1.value.id == null
                                      ? null
                                      : controller.selectedBrandData1.value,
                              items: controller.brandsData.value.map((value) {
                                return DropdownMenuItem<BrandModel>(
                                  value: value,
                                  child: Text(value.titleAr ?? '',
                                      style: TextStyle(
                                        color: AppColors.kBlackColor,
                                        fontSize: 14.sp,
                                        fontFamily: kTheArabicSansLight,
                                        fontWeight: FontWeight.w400,
                                        height: 0,
                                      )),
                                );
                              }).toList(),
                              onChanged: controller.allowToEdit.value != true
                                  ? null
                                  : (BrandModel? newValue) {
                                      controller.updateSelectedBrand1(
                                          newBrand: newValue ?? BrandModel());
                                    },
                              hint: Text(
                                tr('brand1'),
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
                          // SizedBox(
                          //   height: 20.h,
                          // ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            tr('brand2'),
                            style: TextStyle(
                              color: AppColors.kSecondaryColor,
                              fontSize: 18.79.sp,
                              fontFamily: kTheArabicSansLight,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(height: 10.h),
                          Container(
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
                            child: DropdownButton<BrandModel>(
                              underline: const SizedBox(),
                              iconEnabledColor: Colors.transparent,
                              isDense: true,
                              isExpanded: true,
                              value:
                                  controller.selectedBrandData2.value.id == null
                                      ? null
                                      : controller.selectedBrandData2.value,
                              items: controller.brandsData.value.map((value) {
                                return DropdownMenuItem<BrandModel>(
                                  value: value,
                                  child: Text(value.titleAr ?? '',
                                      style: TextStyle(
                                        color: AppColors.kBlackColor,
                                        fontSize: 14.sp,
                                        fontFamily: kTheArabicSansLight,
                                        fontWeight: FontWeight.w400,
                                        height: 0,
                                      )),
                                );
                              }).toList(),
                              onChanged: controller.allowToEdit.value != true
                                  ? null
                                  : (BrandModel? newValue) {
                                      controller.updateSelectedBrand2(
                                          newBrand: newValue ?? BrandModel());
                                    },
                              hint: Text(
                                tr('brand2'),
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
                          // SizedBox(
                          //   height: 20.h,
                          // ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            tr('brand3'),
                            style: TextStyle(
                              color: AppColors.kSecondaryColor,
                              fontSize: 18.79.sp,
                              fontFamily: kTheArabicSansLight,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(height: 10.h),
                          Container(
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
                            child: DropdownButton<BrandModel>(
                              underline: const SizedBox(),
                              iconEnabledColor: Colors.transparent,
                              isDense: true,
                              isExpanded: true,
                              value:
                                  controller.selectedBrandData3.value.id == null
                                      ? null
                                      : controller.selectedBrandData3.value,
                              items: controller.brandsData.value.map((value) {
                                return DropdownMenuItem<BrandModel>(
                                  value: value,
                                  child: Text(value.titleAr ?? '',
                                      style: TextStyle(
                                        color: AppColors.kBlackColor,
                                        fontSize: 14.sp,
                                        fontFamily: kTheArabicSansLight,
                                        fontWeight: FontWeight.w400,
                                        height: 0,
                                      )),
                                );
                              }).toList(),
                              onChanged: controller.allowToEdit.value != true
                                  ? null
                                  : (BrandModel? newValue) {
                                      controller.updateSelectedBrand3(
                                          newBrand: newValue ?? BrandModel());
                                    },
                              hint: Text(
                                tr('brand3'),
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
                          // SizedBox(
                          //   height: 20.h,
                          // ),
                        ],
                      )
                    }
                  },
                  SizedBox(
                    height: 50.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (controller.allowToEdit.value == true) ...{
                        Expanded(
                            child: CustomButton(
                                text: tr('save'),
                                backgroundColor: AppColors.kPrimaryColor,
                                // width: 160.w,
                                height: 40.26.h,
                                borderRadius: 47.34.r,
                                onPressed: () async {
                                  try {
                                    await controller.applyToSaveEdit(
                                        nameController: nameController.text,
                                        nickNameController:
                                            nickNameController.text,
                                        phoneController: phoneController.text,
                                        whatsAppController:
                                            whatsAppController.text,
                                        phoneController2: phoneController2.text,
                                        emailController: emailController.text);
                                    ErrorPopUp(
                                        message: tr('updated'),
                                        title: tr('message'),
                                        isError: false);
                                    Navigator.of(context).pop();
                                  } on DioException catch (e, s) {
                                    print('error:$e');
                                    ErrorPopUp(
                                        message: (e.response?.data as Map)
                                            .values
                                            .first,
                                        title: 'خطا');
                                  } catch (e) {
                                    print('error:$e');
                                    if (e == 'Check Network connection') {
                                      ErrorPopUp(
                                          message: tr('network_connection'),
                                          title: tr('Error'));
                                    } else {
                                      ErrorPopUp(
                                          message: tr('something_wrong'),
                                          title: tr('Error'));
                                    }
                                  }
                                  print('Done');
                                },
                                textStyle: TextStyle(
                                    fontFamily: kTheArabicSansLight,
                                    fontSize: 20.85.sp,
                                    color: AppColors.kWhiteColor,
                                    fontWeight: FontWeight.w700))),
                        15.pw,
                      },
                      Expanded(
                        child: CustomButton(
                            border: Border.all(
                                color: AppColors.kPrimaryColor, width: 1.56.w),
                            text: tr('edit2'),
                            backgroundColor: AppColors.kWhiteColor,
                            // width: 160.w,
                            height: 40.26.h,
                            borderRadius: 47.34.r,
                            onPressed: () {
                              controller.applyToEdit();
                            },
                            textStyle: TextStyle(
                                fontFamily: kTheArabicSansLight,
                                fontSize: 20.85.sp,
                                color: AppColors.kPrimaryColor,
                                fontWeight: FontWeight.w700)),
                      )
                    ],
                  ),

                  SizedBox(
                    height: 60.h,
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
