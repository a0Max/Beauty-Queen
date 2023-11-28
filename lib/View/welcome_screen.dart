import 'dart:async';

import 'package:beauty_queen/View/auth_view/signUp_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../const/strings.dart';
import '../const/colors.dart';
import '../const/images.dart';
import '../const/styles.dart';
import '../controller/welcomescreencontroller.dart';
import 'auth_view/login_page.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final PageController _pageController = PageController();
  final ValueNotifier<int> _currentPageNotifier = ValueNotifier<int>(0);
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    // Starting the auto page view navigation
    _startAutoNavigation();
  }

  void _startAutoNavigation() {
    _timer = Timer.periodic(const Duration(seconds: 5), (Timer timer) {
      if (_currentPageNotifier.value == 0) {
        _pageController.animateToPage(
          1,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      } else {
        timer.cancel();

        // Replace with your login page navigation logic
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final WelcomeController controller = Get.put(WelcomeController());
    return Scaffold(
      backgroundColor: kBlackColor,
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            onPageChanged: (int index) {
              _currentPageNotifier.value = index;
              if (index != 0) {
                _timer
                    ?.cancel(); // Stop the timer when the user manually navigates to the second page
              }
            },
            children: [
              Stack(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Image.asset(
                      kpageviewThreeImage,
                    ),
                  ),
                  Align(
                      alignment: Alignment.topRight,
                      child: Image.asset(kpageviewTwoImage)),
                  Align(
                      alignment: Alignment.center,
                      child: Image.asset(kpageviewoneImage)),
                  Container(
                    height: 351.h,
                    width: 390.w,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(kpageblacktwoImage),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: SizedBox(
                      width: 390.w,
                      height: 351.h,
                      child: Image.asset(
                        kpageblackoneImage,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                      right: 176.w,
                      top: 50.h,
                      child: Image.asset(
                        kpageviewlogoImage,
                        height: 53.61.h,
                        width: 55.w,
                      )),
                  Positioned(
                    right: 54.w,
                    top: 128.h,
                    child: Column(
                      children: [
                        Text(
                          'كل الماركات العاليمة',
                          style: TextStyle(
                            fontFamily: kTheArabicSansLight,
                            fontSize: 31.73.sp,
                            color: kWhiteColor,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text('بين يديك\n',
                            style: TextStyle(
                                color: kPrimaryColor,
                                fontFamily: kTheArabicSansBold,
                                fontWeight: FontWeight.w700,
                                fontSize: 40.73.sp)),
                      ],
                    ),
                  ),
                ],
              ),

              //////////second stack///////////////////
              Stack(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(kFaceImage),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    height: 351.h,
                    width: 390.w,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(kpageblacktwoImage),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: SizedBox(
                      width: 390.w,
                      height: 351.h,
                      child: Image.asset(
                        kpageblackoneImage,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                      right: 176.w,
                      top: 50.h,
                      child: Image.asset(
                        kpageviewlogoImage,
                        height: 53.61.h,
                        width: 55.w,
                      )),
                  Positioned(
                    right: 71.w,
                    top: 128.h,
                    child: Column(
                      children: [
                        Text(
                          'كل ماتحتاجينه',
                          style: TextStyle(
                            fontFamily: kTheArabicSansLight,
                            fontSize: 33.73.sp,
                            color: kWhiteColor,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text('في مكان واحد\n',
                            style: TextStyle(
                                color: kPrimaryColor,
                                fontFamily: kTheArabicSansLight,
                                fontWeight: FontWeight.w700,
                                fontSize: 36.73.sp)),
                      ],
                    ),
                  ),
                  Positioned(
                      top: 453.h,
                      left: -26.w,
                      child: Image.asset(
                        kpageeyeoneImage,
                        height: 181.h,
                        width: 186.w,
                      )),
                  Positioned(
                      top: 249.35.h,
                      right: 25.w,
                      child: Image.asset(
                        kpageeyetwoImage,
                        height: 231.65.h,
                        width: 303.94.w,
                      )),
                ],
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(bottom: 70.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ValueListenableBuilder(
                    valueListenable: _currentPageNotifier,
                    builder: (context, int currentPage, _) {
                      return SizedBox(
                        width: 147.w,
                        height: 5.h,
                        child: Obx(
                          () => Visibility(
                            visible: controller.showProgress.value,
                            child: Stack(
                              children: [
                                Container(
                                  width: 72.w,
                                  height: 5.h,
                                  decoration: ShapeDecoration(
                                    color: const Color(
                                        0xffB3B3B3), // I assumed a light pink background. Adjust as needed.
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(17.r),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  right: 0,
                                  top: 0,
                                  child: Container(
                                    width: 72.w *
                                        controller.firstProgressValue.value,
                                    height: 5.h,
                                    decoration: ShapeDecoration(
                                      color:
                                          (currentPage == 0 || currentPage == 1)
                                              ? Colors.white
                                              : const Color(0xFFB3B3B3),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(14.r),
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 0,
                                  right: 75.w,
                                  child: Container(
                                    width: 72.w,
                                    height: 5.h,
                                    decoration: ShapeDecoration(
                                      color: const Color(
                                          0xffB3B3B3), // I assumed a light pink background. Adjust as needed.
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(17.r),
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  right: 75.w,
                                  top: 0,
                                  child: Container(
                                    width: 72.w *
                                        controller.secondProgressValue.value,
                                    height: 5.h,
                                    decoration: ShapeDecoration(
                                      color: (currentPage == 1)
                                          ? Colors.white
                                          : const Color(0xFFB3B3B3),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(14),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 15.h),
                  SizedBox(
                    width: 358.w,
                    height: 54.h,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(kPrimaryColor),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                      onPressed: () {
                        // Check if the timer has been canceled
                        if (controller.cancelTimerFlag.value) {
                          // Timer canceled, navigate to the login screen
                          Get.off(LogInPage());
                        } else {
                          // Timer not canceled, cancel the timer and navigate
                          controller.cancelTimer();
                          Get.off(LogInPage());
                        }
                      },
                      child: Text(kLogin,
                          style: TextStyle(
                              fontSize: 20.sp,
                              fontFamily: kTheArabicSansLight,
                              color: kWhiteColor,
                              fontWeight: FontWeight.w700)),
                    ),
                  ),
                  SizedBox(height: 19.h),
                  SizedBox(
                    width: 358.w,
                    height: 54.h,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Colors.transparent),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            side: BorderSide(width: 1.w, color: kWhiteColor),
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                        ),
                      ),
                      onPressed: () {
                        // Check if the timer has been canceled
                        if (controller.cancelTimerFlag.value) {
                          // Timer canceled, navigate to the sign-up screen
                          Get.off(SignUpPage());
                        } else {
                          // Timer not canceled, cancel the timer and navigate
                          controller.cancelTimer();
                          Get.off(SignUpPage());
                        }
                      },
                      child: Text(
                        kCreateAccount,
                        style: kPrimaryTextStyle.copyWith(
                            color: kWhiteColor,
                            fontSize: 19.sp,
                            fontWeight: FontWeight.w600,
                            fontFamily: kTheArabicSansLight),
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
