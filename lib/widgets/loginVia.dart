// ignore_for_file: file_names
import 'package:beauty_queen/const/styles.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../const/app_images.dart';
import '../controller/auth_controller/auth_controler.dart';

class LoginVia extends StatelessWidget {
  const LoginVia({super.key});

  @override
  Widget build(BuildContext context) {
    AuthController controller = Get.put(AuthController());

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Divider(
                color: const Color(0xFFD8D8D8),
                thickness: 2.w,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Text(
                tr('way_to_login'),
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontFamily: kTheArabicSansLight,
                  color: Colors.black,
                  fontSize: 18.sp,
                ),
              ),
            ),
            Expanded(
              child: Divider(
                color: const Color(0xFFD8D8D8),
                thickness: 2.w,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 40,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          // height: 58.44.h,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                highlightColor:Colors.transparent,
                splashColor: Colors.transparent,
                onTap: () {
                },
                child: Container(
                  width: (MediaQuery.of(context).size.width-100)/2,
                  padding: const EdgeInsets.symmetric(vertical: 17),
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                          width: 1.11.w,
                          color: const Color(0xFFE4E4E4)),
                      borderRadius: BorderRadius.circular(8.84.r),
                    ),
                    shadows: const [
                      BoxShadow(
                        color: Color(0x42C6C6C6),
                        blurRadius: 24.32,
                        offset: Offset(0, 4.42),
                        spreadRadius: 0,
                      )
                    ],
                  ),
                  child: SvgPicture.asset(AppImages.imageFacebook, height: 25,),
                ),
              ),

              const SizedBox(width: 20,),
              InkWell(
                highlightColor:Colors.transparent,
                splashColor: Colors.transparent,
                onTap: () {
                  controller.googleLogin();
                },
                child: Container(
                  width: (MediaQuery.of(context).size.width-100)/2,
                  padding: const EdgeInsets.symmetric(vertical: 17),
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                          width: 1.11.w,
                          color: const Color(0xFFE4E4E4)),
                      borderRadius: BorderRadius.circular(8.84.r),
                    ),
                    shadows: const [
                      BoxShadow(
                        color: Color(0x42C6C6C6),
                        blurRadius: 24.32,
                        offset: Offset(0, 4.42),
                        spreadRadius: 0,
                      )
                    ],
                  ),
                  child: SvgPicture.asset(AppImages.imageGoogle, height: 25,),
                ),
              ),

            ],
          ),
        ),
      ],
    );
  }
}
