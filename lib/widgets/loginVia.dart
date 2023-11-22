// ignore_for_file: file_names
import 'package:beauty_queen/const/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../const/strings.dart';
import '../const/images.dart';

class LoginVia extends StatelessWidget {
  const LoginVia({super.key});

  @override
  Widget build(BuildContext context) {
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
                kLoginVia,
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
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 275.88.w,
              height: 58.44.h,
              child: Stack(
                children: [
                  Positioned(
                    left: 0,
                    top: 0,
                    child: GestureDetector(
                      onTap: () {},
                      child: SizedBox(
                        width: 133.76.w,
                        height: 58.44.h,
                        child: Stack(
                          children: [
                            Positioned(
                              left: 0,
                              top: 0,
                              child: Container(
                                width: 133.76.w,
                                height: 58.44.h,
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
                              ),
                            ),
                            Positioned(
                              left: 54.81.w,
                              top: 17.15.h,
                              child: SizedBox(
                                width: 24.14.w,
                                height: 24.14.h,
                                child: Stack(
                                  children: [Image.asset(kGoogleLogoPath)],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 142.12.w,
                    top: 0,
                    child: GestureDetector(
                      onTap: () {},
                      child: SizedBox(
                        width: 133.76.w,
                        height: 58.44.h,
                        child: Stack(
                          children: [
                            Positioned(
                              left: 0,
                              top: 0,
                              child: Container(
                                width: 133.76.w,
                                height: 58.44.h,
                                decoration: ShapeDecoration(
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        width: 1.11.r,
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
                              ),
                            ),
                            Positioned(
                              left: 54.81.w,
                              top: 17.15.h,
                              child: SizedBox(
                                width: 24.14.w,
                                height: 24.14.h,
                                child: Stack(
                                  children: [Image.asset(kFacebookLogoPath)],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
