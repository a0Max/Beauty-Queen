import 'package:beauty_queen/const/extensions.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../const/app_colors.dart';
import '../../const/app_images.dart';
import 'package:flutter/material.dart';

import '../../controller/auth_controller/auth_controler.dart';
import '../based/button_widget.dart';
import '../based/loading.dart';
import '../based/error_pop_up.dart';
import 'text_field_widget.dart';

class CommentWidget extends StatelessWidget {
  CommentWidget({super.key});

  TextEditingController phoneController = TextEditingController();

  TextEditingController messageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final AuthController _controller = Get.put(AuthController());

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Transform.flip(
                flipX: true,
                child: SvgPicture.asset(
                  AppImages.imageLove,
                  // height: 30,
                  // width: 30,
                )),
            10.pw,
            Text(
              tr('information'),
              style: const TextStyle(
                fontFamily: 'TheSans',
                fontSize: 18.74,
                color: AppColors.mainColor,
                fontWeight: FontWeight.w700,
              ),
            )
          ],
        ),
        10.ph,
        TextFieldWidget(
          maxLinesInt: 5,
          borderRadius: 2,
          maxLength: 50,
          borderColor: AppColors.kPinkColor,
          controler: messageController,
        ),
        const Text(
          '*يرجي إدخال 50 كلمة كحد أقصيً',
          style: TextStyle(
            fontFamily: 'TheSans',
            fontSize: 14.74,
            color: AppColors.kTextDGColor,
            fontWeight: FontWeight.w200,
          ),
        ),
        10.ph,
        const Text(
          'رقم الهاتف',
          style: TextStyle(
            fontFamily: 'TheSans',
            fontSize: 15.74,
            // color: AppColors.kTextDGColor,
            fontWeight: FontWeight.w600,
          ),
        ),
        10.ph,
        Row(
          children: [
            Expanded(
                flex: 2,
                child: Container(
                  height: 50,
                  child: TextField(
                    controller: phoneController,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(2.0),
                          borderSide: BorderSide(color: AppColors.mainColor),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(2.0),
                          borderSide: BorderSide(color: AppColors.greyColor),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(2.0),
                          borderSide:
                              const BorderSide(color: AppColors.redColor),
                        ),
                        filled: true,
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(2.0),
                          borderSide:
                              const BorderSide(color: AppColors.redColor),
                        ),
                        fillColor: Colors.white,
                        hintStyle:
                            const TextStyle(color: Colors.grey, fontSize: 14)),
                  ),
                )),
            const Expanded(flex: 1, child: SizedBox()),
          ],
        ),
        SizedBox(
          width: 140,
          height: 75,
          child: ButtonWidget(
            textColor: Colors.white,
            boarderColor: AppColors.mainColor,
            text: 'إرسال',
            marginHeight: 15,
            paddingVertical: 0,
            textStyle: const TextStyle(
              fontFamily: 'TheSans',
              fontSize: 16.74,
              color: Colors.white,
              // color: AppColors.kTextDGColor,
              fontWeight: FontWeight.w400,
            ),
            marginWidth: 0,
            action: () async {
              try {
                LoadingScreen.show(context);

                await _controller.sendMessageToManagies(
                    phone: phoneController.text,
                    message: messageController.text);
                Navigator.of(context).pop();

                ErrorPopUp(
                    message: tr('updated2'),
                    title: tr('message'),
                    isError: false);
                Navigator.of(context).pop();
              } on DioException catch (e, s) {
                Navigator.of(context).pop();
                ErrorPopUp(
                    message: (e.response?.data as Map).values.first,
                    title: 'خطا');
              } catch (e) {
                Navigator.of(context).pop();
                if (e == 'Check Network connection') {
                  ErrorPopUp(
                      message: tr('network_connection'), title: tr('Error'));
                } else {
                  ErrorPopUp(
                      message: tr('something_wrong'), title: tr('Error'));
                }
              }
            },
            backgroundColor: AppColors.mainColor,
          ),
        ),
      ],
    );
  }
}
