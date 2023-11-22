import 'package:beauty_queen/const/styles.dart';
import 'package:beauty_queen/widgets/CustomAppBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../const/colors.dart';
import '../const/images.dart';

import '../widgets/CustomEndDrawer.dart';

class BeautyPharmacyScreen extends StatefulWidget {
  const BeautyPharmacyScreen({super.key});

  @override
  State<BeautyPharmacyScreen> createState() => _BeautyPharmacyScreenState();
}

class _BeautyPharmacyScreenState extends State<BeautyPharmacyScreen> {
  bool _isScrolled = false;
  double searchBarWidth = 1.0;
  double searchBarTranslationX = 0.0;
  double searchBarTranslationY = 0.0;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_scrollController.offset > 0 && !_isScrolled) {
      setState(() {
        _isScrolled = true;
        searchBarWidth = 0.75;
        searchBarTranslationX = 50.0;
        searchBarTranslationY = -52.0;
      });
    } else if (_scrollController.offset <= 0 && _isScrolled) {
      setState(() {
        _isScrolled = false;
        searchBarWidth = 1.0;
        searchBarTranslationX = 0.0;
        searchBarTranslationY = 0.0;
      });
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
        key: scaffoldKey,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(160.h),
          child: CustomAppBar(
            showBagIcon2: true,
            showarrowIcon: true,
            onPressed: () {
              // Handle the button click here, e.g., open the end drawer.
              scaffoldKey.currentState?.openEndDrawer();
            },
            isScrolled: _isScrolled,
            // Replace with your variable for scroll state
            searchBarWidth: searchBarWidth, // Replace with your desired width
            searchBarTranslationY: searchBarTranslationY,
            searchBarTranslationX: searchBarTranslationX,
            // Replace with your desired translation value
          ),
        ),
        endDrawer: const MyEndDrawer(),
        body: SingleChildScrollView(
          controller: _scrollController,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: Column(
              children: [
                SizedBox(
                  height: 59.h,
                ),
                Center(
                  child: Text(
                      'عروض مميزة و حصرية لدينا و متاحة فقط\n           للطلب اونلاين عبر الموقع',
                      style: TextStyle(
                        fontFamily: kTheArabicSansLight,
                        color: kBlackColor,
                        fontSize: 17.83.sp,
                        fontWeight: FontWeight.w400,
                      )),
                ),
                SizedBox(
                  height: 63.h,
                ),
                Stack(
                  children: [
                    Container(
                      width: 403.81.w,
                      height: 183.23.h,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                            kRectangleTwoImage,
                          ),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    Center(
                      child: Container(
                        margin: EdgeInsets.only(top: 153.h),
                        width: 322.27.w,
                        height: 181.04.h,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: const Color.fromARGB(32, 0, 0, 0),
                              blurRadius: 28.r,
                              offset: const Offset(0, 4),
                              spreadRadius: 0,
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              'هدية مجانية من لانكوم',
                              style: TextStyle(
                                color: const Color(0xFFDE0F7E),
                                fontSize: 18.sp,
                                fontFamily: kTheArabicSansLight,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              'احصلي على هدية مجانية من أرقى ماركات الميك \nاب العالمية يوم الجمعة',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: const Color(0xFF393336),
                                height: 2,
                                fontSize: 14.sp,
                                fontFamily: kTheArabicSansLight,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Container(
                              width: 109.71.w,
                              height: 37.93.h,
                              decoration: ShapeDecoration(
                                color: const Color(0xFFDE0F7E),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.69),
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  'تسوقي الأن',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12.83.sp,
                                    fontFamily: kTheArabicSansLight,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 61.h,
                ),
                ///////////////////second stack//////////////////
                Stack(
                  children: [
                    Container(
                      width: 403.81.w,
                      height: 183.23.h,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(kfacepowderImage),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    Center(
                      child: Container(
                        margin: EdgeInsets.only(top: 153.h),
                        width: 322.27.w,
                        height: 181.04.h,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: const Color.fromARGB(32, 0, 0, 0),
                              blurRadius: 28.r,
                              offset: const Offset(0, 4),
                              spreadRadius: 0,
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Text(
                              'هدية مجانية من لانكوم',
                              style: TextStyle(
                                color: Color(0xFFDE0F7E),
                                fontSize: 18,
                                fontFamily: kTheArabicSansLight,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              'احصلي على هدية مجانية من أرقى ماركات الميك \nاب العالمية يوم الجمعة',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: const Color(0xFF393336),
                                height: 2,
                                fontSize: 14.sp,
                                fontFamily: kTheArabicSansLight,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Container(
                              width: 109.71.w,
                              height: 37.93.h,
                              decoration: ShapeDecoration(
                                color: const Color(0xFFDE0F7E),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.69),
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  'تسوقي الأن',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12.83.sp,
                                    fontFamily: kTheArabicSansLight,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 61.h,
                ),
                ////////////////////////////third stack///////////////////////
                Stack(
                  children: [
                    Container(
                      width: 403.81.w,
                      height: 183.23.h,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(kcreambannerImage),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    Center(
                      child: Container(
                        margin: EdgeInsets.only(top: 153.h),
                        width: 322.27.w,
                        height: 181.04.h,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: const Color.fromARGB(32, 0, 0, 0),
                              blurRadius: 28.r,
                              offset: const Offset(0, 4),
                              spreadRadius: 0,
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Text(
                              'هدية مجانية من لانكوم',
                              style: TextStyle(
                                color: Color(0xFFDE0F7E),
                                fontSize: 18,
                                fontFamily: kTheArabicSansLight,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              'احصلي على هدية مجانية من أرقى ماركات الميك \nاب العالمية يوم الجمعة',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: const Color(0xFF393336),
                                height: 2,
                                fontSize: 14.sp,
                                fontFamily: kTheArabicSansLight,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Container(
                              width: 109.71.w,
                              height: 37.93.h,
                              decoration: ShapeDecoration(
                                color: const Color(0xFFDE0F7E),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.69),
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  'تسوقي الأن',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12.83.sp,
                                    fontFamily: kTheArabicSansLight,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 61.h,
                ),
                /////////////////fourthStack//////////////////////
                Stack(
                  children: [
                    Container(
                      width: 403.81.w,
                      height: 183.23.h,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(kgreencreambannerImage),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    Center(
                      child: Container(
                        margin: EdgeInsets.only(top: 153.h),
                        width: 322.27.sp,
                        height: 181.04.h,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: const Color.fromARGB(32, 0, 0, 0),
                              blurRadius: 28.r,
                              offset: const Offset(0, 4),
                              spreadRadius: 0,
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Text(
                              'هدية مجانية من لانكوم',
                              style: TextStyle(
                                color: Color(0xFFDE0F7E),
                                fontSize: 18,
                                fontFamily: kTheArabicSansLight,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              'احصلي على هدية مجانية من أرقى ماركات الميك\nاب العالمية يوم الجمعة',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: const Color(0xFF393336),
                                height: 2,
                                fontSize: 14.sp,
                                fontFamily: kTheArabicSansLight,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Container(
                              width: 109.71.w,
                              height: 37.93.h,
                              decoration: ShapeDecoration(
                                color: const Color(0xFFDE0F7E),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.69),
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  'تسوقي الأن',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12.83.sp,
                                    fontFamily: kTheArabicSansLight,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 50.h,
                ),
              ],
            ),
          ),
        ));
  }
}
