import 'package:beauty_queen/const/app_images.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../const/app_colors.dart';
import '../../const/styles.dart';
import '../../controller/wallet_controller/wallet_controller.dart';
import '../based/error_pop_up.dart';
import '../based/loading.dart';

Future showModalSheet(BuildContext context) {
  TextEditingController codeController = TextEditingController();
  WalletController controller = Get.put(WalletController());

  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.white,
    builder: (context) => SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 15),
                    // height: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(),
                        Text(
                          "المحفظة",
                          style: TextStyle(
                              fontFamily: kTheArabicSansLight,
                              color: AppColors.kBlackColor,
                              fontSize: 23.74.sp,
                              fontWeight: FontWeight.w600),
                        ),
                        IconButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            icon: Icon(
                              Icons.close,
                              size: 30.r,
                              color: AppColors.kPrimaryColor,
                            )),
                      ],
                    ),
                  ),
                  Text(
                    "تعبئة رصيد المحفظة ",
                    style: TextStyle(
                        fontFamily: kTheArabicSansLight,
                        color: AppColors.kPrimaryColor,
                        fontSize: 23.74.sp,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    controller: codeController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(13.r),
                          borderSide: BorderSide(
                              width: 1.w, color: AppColors.kPinkColor),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(13.r),
                          borderSide: BorderSide(
                              width: 1.w, color: AppColors.kPinkColor),
                        ),
                        filled: true,
                        prefixIcon: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          child: SvgPicture.asset(
                            AppImages.subtractImage,
                            // width: 35.w,
                          ),
                        ),
                        prefixIconConstraints: BoxConstraints(minWidth: 30.w),
                        hintText: 'أدخل رقم البطاقة',
                        hintStyle: const TextStyle(
                            fontFamily: kTheArabicSansLight,
                            color: AppColors.kPrimaryColor,
                            fontSize: 21,
                            fontWeight: FontWeight.w600)),
                  ),
                  SizedBox(
                    height: 100.h,
                  ),
                  InkWell(
                    onTap: () async {
                      try {
                        LoadingScreen.show(context);

                        await controller.checkGiftCard(
                            code: codeController.text);

                        Navigator.of(context).pop();
                        ErrorPopUp(
                            message: tr('promoCodeAccepted2'),
                            title: tr('promoCodeAccepted'),
                            isError: false);
                        Navigator.of(context).pop();
                      } on DioException catch (e) {
                        Navigator.of(context).pop();

                        ErrorPopUp(
                            message: (e.response?.data as Map).values.first,
                            title: 'خطا');
                      } catch (e) {
                        Navigator.of(context).pop();

                        if (e == 'Check Network connection') {
                          ErrorPopUp(
                              message: tr('network_connection'), title: 'خطا');
                        } else {
                          ErrorPopUp(
                              message: tr('check_code_card'), title: 'خطا');
                        }
                      }
                    },
                    borderRadius: BorderRadius.circular(47.r),
                    child: Container(
                      height: 68.h,
                      width: MediaQuery.of(context).size.width,
                      // margin: const EdgeInsets.symmetric(horizontal: 15),
                      decoration: BoxDecoration(
                          color: AppColors.kPrimaryColor,
                          borderRadius: BorderRadius.circular(47.r)),
                      child: Center(
                        child: Text(
                          "تعبئة الرصيد ",
                          style: TextStyle(
                              fontFamily: kTheArabicSansLight,
                              color: AppColors.kWhiteColor,
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
