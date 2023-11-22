// ignore_for_file: file_names, library_private_types_in_public_api, avoid_unnecessary_containers
import 'package:beauty_queen/const/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../const/colors.dart';
import '../const/images.dart';
import '../const/size.dart';
import '../widgets/CustomAppBar.dart';
import '../widgets/CustomCardWidget.dart';
import '../widgets/CustomCircleStack.dart';
import '../widgets/CustomEndDrawer.dart';
import '../widgets/CustomProductCard.dart';
import '../widgets/ScrollableContainerList.dart';
import '../widgets/custom_horizontal_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final ScrollController _scrollController = ScrollController();
  bool _isScrolled = false;
  double searchBarWidth = 1.0;
  double searchBarHeight = 1.0;
  double searchBarTranslationX = 0.0;
  double searchBarTranslationY = 0.0;

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

  // bool _isScrolled = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(160.h),
        child: CustomAppBar(
          showBagIcon: true,
          showFavIcon: true,
          showPersonIcon: true,
          onPressed: () {
            // Handle the button click here, e.g., open the end drawer.
            _scaffoldKey.currentState?.openEndDrawer();
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
        child: Column(
          children: [
            Container(
              width: kScreenWidth,
              height: 271.99.h,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(kRectangleThreeImage),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            SizedBox(
              height: 160.h,
              child: const CustomImageList(
                imagePaths: [
                  kCircleOne,
                  kCircleTwo,
                  kCircleThree,
                  kCirclefour,
                  kCirclefive,
                ], // Provide your image paths
                texts: [
                  'الأظافر',
                  'الرموش',
                  'العدسات الاصقة',
                  'صيدلية الجمال',
                  'الأجهزة \nالكهربائية'
                ], // Provide your text
              ),
            ),
            SizedBox(
              height: 350.h,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 9.w),
                    child: SizedBox(
                      width: 262.45.w,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Container(
                            width: 262.45.w,
                            height: 262.45.h,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(kN7Image),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          Container(
                            width: 262.45.w,
                            height: 77.59.h,
                            decoration:
                                const BoxDecoration(color: Color(0xFFDE0F7E)),
                            child: Padding(
                              padding: EdgeInsets.all(9.r),
                              child: Text(
                                'اخفاء كلي للعيوب، تحديد، نحت وتوحيد لون بتغطية كاملة يحققها كونسيلر سوبر فكس من ريفلوشن.',
                                textAlign: TextAlign.right,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 3,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 13.1.sp,
                                  fontFamily: kTheArabicSansLight,
                                  fontWeight: FontWeight.w700,
                                  // height: 1.5,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              height: 40.h, // Your existing ListView.builder height
              // ListView.builder code here
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'وصل حديثا',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: const Color(0xFFDE0F7E),
                      fontSize: 21.sp,
                      fontFamily: kTheArabicSansLight,
                      fontWeight: FontWeight.w700,
                      height: 0,
                    ),
                  ),
                  Text(
                    'عرض الكل',
                    style: TextStyle(
                      color: const Color(0xFFDE0F7E),
                      fontSize: 18.sp,
                      fontFamily: kTheArabicSansLight,
                      fontWeight: FontWeight.w400,
                      decoration: TextDecoration.underline,
                      decorationColor: kPrimaryColor,
                      height: 0,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30.h,
            ),
            Container(
              child: Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 30.h),
                    child: Container(
                      color: const Color(0xFFEAEAEA),
                      width: kScreenWidth,
                      height: 300.38.h,
                    ),
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CustomCardWidget(
                          imageUrl: kBaseImage,
                          imgtxt: 'Makeup Forever',
                          price: '150.00',
                          des: 'كريم اساس الترا اتش دي السائل من ميكب',
                          disprice: '190.00',
                          containertxt: 'تحديد الخيارات'),
                      CustomCardWidget(
                          imageUrl: kLispticImage,
                          imgtxt: 'Rare Beauty',
                          price: '94.00',
                          des: 'طقم فريش اند ديوي للشفاه والخدود من رير بيوتي',
                          disprice: '94.00',
                          containertxt: 'إضافة إلي السلة'),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 15.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: 16.w,
                  vertical: 16.h), // Adjust the padding as needed
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'العروض والهاديا',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: const Color(0xFFDE0F7E),
                      fontSize: 21.sp,
                      fontFamily: kTheArabicSansLight,
                      fontWeight: FontWeight.w700,
                      height: 0,
                    ),
                  ),
                  Text(
                    'عرض الكل',
                    style: TextStyle(
                      color: const Color(0xFFDE0F7E),
                      fontSize: 18.sp,
                      fontFamily: kTheArabicSansLight,
                      fontWeight: FontWeight.w400,
                      decoration: TextDecoration.underline,
                      decorationColor: kPrimaryColor,
                      height: 0,
                    ),
                  ),
                ],
              ),
            ),
            Stack(
              children: [
                Container(
                  width: kScreenWidth,
                  height: 202.23.h,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(kRectangleTwoImage),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    margin: EdgeInsets.only(top: 153.h),
                    width: 343.13.w,
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
                      children: [
                        SizedBox(
                          height: 22.h,
                        ),
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
                        SizedBox(
                          height: 18.h,
                        ),
                        Container(
                          width: 109.71.w,
                          height: 37.93.h,
                          decoration: ShapeDecoration(
                            color: const Color(0xFFDE0F7E),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.69.r),
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
            const CustomCircleStack(),
            SizedBox(
              height: 50.h,
            ),
            Container(
              width: 430.28.w,
              height: 179.28.h,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(kBannerOneImage),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              width: 433.51.w,
              height: 180.63.h,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(kBannerTwoImage),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              height: 40.h,
            ),
            Container(
              width: 430.24.w,
              height: 467.76.h,
              decoration: const BoxDecoration(color: Color(0xFFF4C6DD)),
              child: Column(
                children: [
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'التخفيضات',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            color: const Color(0xFFDE0F7E),
                            fontSize: 21.sp,
                            fontFamily: kTheArabicSansLight,
                            fontWeight: FontWeight.w700,
                            height: 0,
                          ),
                        ),
                        Text(
                          'كل التخفيضات',
                          style: TextStyle(
                            color: const Color(0xFFDE0F7E),
                            fontSize: 18.sp,
                            fontFamily: kTheArabicSansLight,
                            fontWeight: FontWeight.w400,
                            decorationColor: kPrimaryColor,
                            decoration: TextDecoration.underline,
                            height: 0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CustomCardWidget(
                          imageUrl: kBaseImage,
                          imgtxt: 'Makeup Forever',
                          price: '150.00',
                          des: 'كريم اساس الترا اتش دي السائل من ميكب',
                          disprice: '190.00',
                          containertxt: 'تحديد الخيارات'),
                      CustomCardWidget(
                          imageUrl: kLispticImage,
                          imgtxt: 'Rare Beauty',
                          price: '94.00',
                          des: 'طقم فريش اند ديوي للشفاه والخدود من رير بيوتي',
                          disprice: '94.00',
                          containertxt: 'إضافة إلي السلة'),
                    ],
                  ),
                ],
              ),
            ),
            const CustomCircleStack(),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'الماركات المميزة',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: const Color(0xFFDE0F7E),
                      fontSize: 21.sp,
                      fontFamily: kTheArabicSansLight,
                      fontWeight: FontWeight.w700,
                      height: 0,
                    ),
                  ),
                  Text(
                    'جميع الماركات',
                    style: TextStyle(
                      color: const Color(0xFFDE0F7E),
                      fontSize: 18.sp,
                      fontFamily: kTheArabicSansLight,
                      fontWeight: FontWeight.w400,
                      decorationColor: kPrimaryColor,
                      decoration: TextDecoration.underline,
                      height: 0,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 15.h,
            ),
            const ScrollableContainerList(),
            SizedBox(
              height: 51.h,
            ),
            SizedBox(
              height: 650.h,
              child: Stack(
                children: [
                  Container(
                    width: 705.83.w,
                    height: 281.30.h,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(kMakeOverImage),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 230.h,
                    left: 15.w,
                    child: const Row(
                      children: [
                        CustomCardWidget(
                            imageUrl: kBaseImage,
                            imgtxt: 'Makeup Forever',
                            price: '150.00',
                            des: 'كريم اساس الترا اتش دي السائل من ميكب',
                            disprice: '190.00',
                            containertxt: 'تحديد الخيارات'),
                        CustomCardWidget(
                            imageUrl: kLispticImage,
                            imgtxt: 'Rare Beauty',
                            price: '94.00',
                            des:
                                'طقم فريش اند ديوي للشفاه والخدود من رير بيوتي',
                            disprice: '94.00',
                            containertxt: 'إضافة إلي السلة'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                    width: Get.width,
                    height: 448.h,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 4,
                      itemBuilder: (context, index) {
                        return Container(
                          width: 257.0.w,
                          height: 448.0.h,
                          margin: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Container(
                                width: 257.0.w,
                                height: 258.56.h,
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(
                                      kRectangleImage,
                                    ),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              // Pink Container
                              Container(
                                width: 257.0.w,
                                height: 189.38.h,
                                color: const Color(0xFFDE0F7E),
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 18.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 30.h,
                                      ),
                                      Text(
                                        'سحر الازهار والحلوى الابدي',
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 19.18.sp,
                                          fontFamily: kTheArabicSansLight,
                                          fontWeight: FontWeight.w700,
                                          height: 0.05,
                                          letterSpacing: -0.19,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 29.h,
                                      ),
                                      SizedBox(
                                        width: 226.11.w,
                                        child: Text(
                                          'انجرفي بعيدًا مع سحر هذا العطر الذي يفوح بمزيج راقي من تفاح بينك ليدي والياسمين المكرمل والعنبر وخشب الصندل.',
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 13.18.sp,
                                            fontFamily: kTheArabicSansLight,
                                            fontWeight: FontWeight.w400,
                                            height: 1.5,
                                            letterSpacing: 0.13,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 30.h,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 20.w),
                                        child: Text(
                                          'تسوقي الأن',
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14.63.sp,
                                            fontFamily: kTheArabicSansLight,
                                            fontWeight: FontWeight.w400,
                                            decoration:
                                                TextDecoration.underline,
                                            height: 0.08,
                                            letterSpacing: -0.15,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ))
              ],
            ),
            SizedBox(
              height: 20.h,
            ),
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: EdgeInsets.only(right: 16.w),
                child: Text(
                  'إكتشفي أيضاً',
                  style: TextStyle(
                    color: const Color(0xFFDE0F7E),
                    fontSize: 21.sp,
                    fontFamily: kTheArabicSansLight,
                    fontWeight: FontWeight.w700,
                    height: 0,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 30.h,
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CustomProductCard(
                      imageUrl: kSpecialTwoImage,
                      description:
                          'تخلصي من جفاف وخشونة الوجه والجسم بخلاصة عسل المانوكا الغني الفيتامينات والمرطبات الطبيعية الدسمة',
                      buttonText: 'تسوقي الأن',
                      onPressed: () {
                        // Add your button click logic here
                      },
                    ),
                    CustomProductCard(
                      imageUrl: kSpecialOneImage,
                      description:
                          'تخلصي من جفاف وخشونة الوجه والجسم بخلاصة عسل المانوكا الغني الفيتامينات والمرطبات الطبيعية الدسمة',
                      buttonText: 'تسوقي الأن',
                      onPressed: () {
                        // Add your button click logic here
                      },
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CustomProductCard(
                      imageUrl: kSpecialTwoImage,
                      description:
                          'تخلصي من جفاف وخشونة الوجه والجسم بخلاصة عسل المانوكا الغني الفيتامينات والمرطبات الطبيعية الدسمة',
                      buttonText: 'تسوقي الأن',
                      onPressed: () {
                        // Add your button click logic here
                      },
                    ),
                    CustomProductCard(
                      imageUrl: kSpecialOneImage,
                      description:
                          'تخلصي من جفاف وخشونة الوجه والجسم بخلاصة عسل المانوكا الغني الفيتامينات والمرطبات الطبيعية الدسمة',
                      buttonText: 'تسوقي الأن',
                      onPressed: () {
                        // Add your button click logic here
                      },
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CustomProductCard(
                      imageUrl: kSpecialTwoImage,
                      description:
                          'تخلصي من جفاف وخشونة الوجه والجسم بخلاصة عسل المانوكا الغني الفيتامينات والمرطبات الطبيعية الدسمة',
                      buttonText: 'تسوقي الأن',
                      onPressed: () {
                        // Add your button click logic here
                      },
                    ),
                    CustomProductCard(
                      imageUrl: kSpecialOneImage,
                      description:
                          'تخلصي من جفاف وخشونة الوجه والجسم بخلاصة عسل المانوكا الغني الفيتامينات والمرطبات الطبيعية الدسمة',
                      buttonText: 'تسوقي الأن',
                      onPressed: () {
                        // Add your button click logic here
                      },
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 30.h,
            ),
            Container(
              height: 318.64.h,
              width: 484.14.w,
              color: kPinkColor,
              child: Stack(
                children: [
                  Image(
                    image: const AssetImage(kMagzineImage),
                    height: 300.h,
                    width: 420.w,
                  ),
                  Positioned(
                    top: 180.h,
                    right: 60.w,
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text:
                                'مجلة بيوتي كوين الإلكترونية - العدد الثاني\n',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 13.18.sp,
                              fontFamily: kTheArabicSansLight,
                              fontWeight: FontWeight.w700,
                              height: 1.5,
                              letterSpacing: 0.13,
                            ),
                          ),
                          TextSpan(
                            text:
                                'واكبي آخر صيحات الموسم مع مجلتنا مجلة الجمال\nو الموضة     ',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 13.18.sp,
                              fontFamily: kTheArabicSansLight,
                              fontWeight: FontWeight.w400,
                              height: 1.5,
                              letterSpacing: 0.13,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: EdgeInsets.only(
                        bottom: 25.h,
                      ),
                      child: Container(
                        height: 29.83.h,
                        width: 85.59.w,
                        decoration: BoxDecoration(
                            border:
                                Border.all(width: 1.5.w, color: kWhiteColor),
                            borderRadius: BorderRadius.circular(8.r)),
                        child: Center(
                          child: Text('إطــلعي الأن',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12.03.sp,
                                fontFamily: kTheArabicSansLight,
                                fontWeight: FontWeight.w600,
                                height: 1.5,
                                letterSpacing: 0.13,
                              )),
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
    );
  }
}
