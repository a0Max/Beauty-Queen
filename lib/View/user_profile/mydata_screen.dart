import 'package:beauty_queen/const/colors.dart';
import 'package:beauty_queen/const/extensions.dart';
import 'package:beauty_queen/widgets/custom_button.dart';
import 'package:easy_localization/easy_localization.dart';
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
    nameController =
        TextEditingController(text: controller.userData.value.name);
    phoneController =
        TextEditingController(text: controller.userData.value.phone);
    nickNameController =
        TextEditingController(text: controller.userData.value.lastName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: kWhiteColor,
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: kWhiteColor,
        actions: [
          IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(
                Icons.arrow_forward_ios,
                size: 30.r,
                color: kBlackColor,
              )),
        ],
        title: Text(
          tr('ourData'),
          style: TextStyle(
              fontFamily: kTheArabicSansLight,
              color: kBlackColor,
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
                          readOnly: controller.allowToEdit.value==false?true:null,
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
                          readOnly: controller.allowToEdit.value==false?true:null,
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
                  Text("${controller.userData.value.accountType}"),
                  if (controller.userData.value.accountType ==
                      AccountTypes.queena) ...{
                    TextFieldAuthWidget(
                      hindText: tr('birthDay'),
                      titleText: tr('birthDay'),
                      readOnly: true,
                      onTap: () {
                        showDatePickerDialog();
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
                        onChanged: (CityAreaModel? newValue) {
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
                    if (controller.areaData.value.isNotEmpty &&
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
                          onChanged: (CityAreaModel? newValue) {
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
                  },
                  SizedBox(
                    height: 50.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomButton(
                          text: tr('save'),
                          backgroundColor: kPrimaryColor,
                          width: 160.w,
                          height: 40.26.h,
                          borderRadius: 47.34.r,
                          onPressed: () {},
                          textStyle: TextStyle(
                              fontFamily: kTheArabicSansLight,
                              fontSize: 20.85.sp,
                              color: kWhiteColor,
                              fontWeight: FontWeight.w700)),
                      CustomButton(
                          border:
                              Border.all(color: kPrimaryColor, width: 1.56.w),
                          text: tr('edit2'),
                          backgroundColor: kWhiteColor,
                          width: 160.w,
                          height: 40.26.h,
                          borderRadius: 47.34.r,
                          onPressed: () {
                            controller.applyToEdit();
                          },
                          textStyle: TextStyle(
                              fontFamily: kTheArabicSansLight,
                              fontSize: 20.85.sp,
                              color: kPrimaryColor,
                              fontWeight: FontWeight.w700))
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
