import 'dart:async';

import 'package:beauty_queen/View/auth_view/signUp_page.dart';
import 'package:beauty_queen/View/home/HomePage.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../const/app_colors.dart';
import '../../const/app_images.dart';
import '../../const/styles.dart';
import '../../controller/welcome/welcomescreencontroller.dart';
import '../auth_view/login_page.dart';
import '../home/bottom_nav_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final PageController _pageController = PageController();
  Timer? _timer;
  int _currentPage = 0;
  final int _totalPages = 4;
  final int _durationPerPage = 3; // Duration in seconds
  final List<double> _progressList = [0.0, 0.0, 0.0, 0.0];
  @override
  void initState() {
    super.initState();
    // _startAutoNavigation();
  }

  void _startAutoNavigation() {
    _timer = Timer.periodic(const Duration(milliseconds: 100), (Timer timer) {
      setState(() {
        print("_currentPage:$_currentPage");

        _progressList[_currentPage] += 0.1 / _durationPerPage;
        if (_progressList[_currentPage] >= 1.0) {
          _progressList[_currentPage] = 1.0;
          if (_currentPage < _totalPages - 1) {
            _currentPage++;
            _pageController.animateToPage(
              _currentPage,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeIn,
            );
          } else {
            _performAction();
          }
        }
        print("_currentPage:$_currentPage");
      });
    });
  }

  void _performAction() async {
    await Future.delayed(const Duration(milliseconds: 300));
    Get.off(const LogInPage());
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final WelcomeController controller = Get.put(WelcomeController());
    return Scaffold(
      backgroundColor: AppColors.kBlackColor,
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            onPageChanged: (int index) {
              // _currentPageNotifier.value = index;
            },
            children: [
              Image.asset(
                AppImages.kpageviewfourImage,
                fit: BoxFit.cover,
              ),
              Image.asset(
                AppImages.kpageviewTwoImage,
                fit: BoxFit.cover,
              ),
              Image.asset(
                AppImages.kpageviewThreeImage,
                fit: BoxFit.cover,
              ),
              Image.asset(
                AppImages.kpageviewoneImage,
                fit: BoxFit.cover,
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(bottom: 20.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // SizedBox(height: 15.h),
                  if (_currentPage == 3) ...{
                    SizedBox(
                      width: 358.w,
                      height: 54.h,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              AppColors.kBlackColor),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                        onPressed: () {
                          // Check if the timer has been canceled
                          // if (controller.cancelTimerFlag.value) {
                          // Timer canceled, navigate to the login screen
                          // Get.off(const LogInPage());
                          // } else {
                          // Timer not canceled, cancel the timer and navigate
                          // controller.cancelTimer();
                          Get.off(const LogInPage());
                          // }
                        },
                        child: Text(tr('kLogin'),
                            style: TextStyle(
                                fontSize: 20.sp,
                                fontFamily: kTheArabicSansLight,
                                color: AppColors.kWhiteColor,
                                fontWeight: FontWeight.w700)),
                      ),
                    ),
                    SizedBox(height: 19.h),
                    SizedBox(
                      width: 358.w,
                      height: 54.h,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.black54),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              side:
                                  BorderSide(width: 1.w, color: Colors.black54),
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                          ),
                        ),
                        onPressed: () {
                          // Check if the timer has been canceled
                          // if (controller.cancelTimerFlag.value) {
                          //   // Timer canceled, navigate to the sign-up screen
                          //   Get.off(const SignUpPage());
                          // } else {
                          //   // Timer not canceled, cancel the timer and navigate
                          //   controller.cancelTimer();
                          Get.off(const SignUpPage());
                          // }
                        },
                        child: Text(
                          tr('kCreateAccount'),
                          style: kPrimaryTextStyle.copyWith(
                              color: AppColors.kWhiteColor,
                              fontSize: 19.sp,
                              fontWeight: FontWeight.w600,
                              fontFamily: kTheArabicSansLight),
                        ),
                      ),
                    ),
                    SizedBox(height: 19.h),
                    SizedBox(
                      width: 358.w,
                      height: 54.h,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.black54),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              side:
                                  BorderSide(width: 1.w, color: Colors.black54),
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                          ),
                        ),
                        onPressed: () {
                          // Check if the timer has been canceled
                          // if (controller.cancelTimerFlag.value) {
                          //   // Timer canceled, navigate to the sign-up screen
                          //   Get.off(const SignUpPage());
                          // } else {
                          //   // Timer not canceled, cancel the timer and navigate
                          //   controller.cancelTimer();
                          Get.off(const MainView());
                          // }
                        },
                        child: Text(
                          'الاستمرار كــ زائر',
                          style: kPrimaryTextStyle.copyWith(
                              color: AppColors.kWhiteColor,
                              fontSize: 19.sp,
                              fontWeight: FontWeight.w600,
                              fontFamily: kTheArabicSansLight),
                        ),
                      ),
                    ),
                  } else if (_currentPage == 0) ...{
                    SizedBox(
                      width: 358.w,
                      height: 54.h,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              AppColors.kBlackColor),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                        onPressed: () {
                          print("_currentPage:$_currentPage");
                          setState(() {
                            //   updatePage();
                            _progressList[_currentPage] = 1.0;

                            _currentPage++;
                            _pageController.animateToPage(
                              _currentPage,
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeIn,
                            );
                          });

                          // print("_currentPage:$_currentPage");
                          // _pageController.jumpToPage(_currentPage);
                        },
                        child: Text('ابدئي',
                            style: TextStyle(
                                fontSize: 20.sp,
                                fontFamily: kTheArabicSansLight,
                                color: AppColors.kWhiteColor,
                                fontWeight: FontWeight.w700)),
                      ),
                    ),
                    SizedBox(height: 19.h),
                  } else ...{
                    SizedBox(
                      width: 358.w,
                      height: 54.h,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              AppColors.kBlackColor),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                        onPressed: () {
                          print("_currentPage:$_currentPage");
                          setState(() {
                            //   updatePage();
                            _progressList[_currentPage] = 1.0;

                            _currentPage++;
                            _pageController.animateToPage(
                              _currentPage,
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeIn,
                            );
                          });

                          // print("_currentPage:$_currentPage");
                          // _pageController.jumpToPage(_currentPage);
                        },
                        child: Text('التالي',
                            style: TextStyle(
                                fontSize: 20.sp,
                                fontFamily: kTheArabicSansLight,
                                color: AppColors.kWhiteColor,
                                fontWeight: FontWeight.w700)),
                      ),
                    ),
                    SizedBox(height: 19.h),
                  }
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
