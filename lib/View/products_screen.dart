import 'dart:developer';

import 'package:beauty_queen/View/tab_screen_one.dart';
import 'package:beauty_queen/const/colors.dart';
import 'package:beauty_queen/const/images.dart';
import 'package:beauty_queen/const/styles.dart';
import 'package:beauty_queen/controller/tab_controller.dart';
import 'package:beauty_queen/widgets/CustomAlertBox.dart';
import 'package:beauty_queen/widgets/custom_container.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../controller/crouselConrtoller.dart';
import '../widgets/custom_color_container.dart';
import 'tab_screen_two.dart';

class CarouselSliderPage extends StatefulWidget {
  const CarouselSliderPage({super.key});

  @override
  State<CarouselSliderPage> createState() => _CarouselSliderPageState();
}

class _CarouselSliderPageState extends State<CarouselSliderPage> {
  final CarouselsController controller = Get.put(CarouselsController());

  final MyTabs tabcontroller = Get.put(MyTabs());

  final ScrollController scrollController = ScrollController();
  List<Color> colorList = [
    const Color(0xffD1877C),
    const Color(0xffCA5F4D),
    const Color(0xff7A261B),
    const Color(0xffD62247),
    const Color(0xffCA5F4D),
  ];

  String? selectedDropdownItem;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: SingleChildScrollView(
          controller: scrollController,
          child: Column(
            children: [
              SizedBox(
                height: 20.h,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: Icon(
                      Icons.arrow_forward_ios_sharp,
                      size: 25.r,
                    )),
              ),
              SizedBox(
                height: 33.h,
              ),
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: EdgeInsets.only(right: 17.w),
                  child: Text.rich(TextSpan(
                      text: 'الأقسام / المكياج / الشفاه / ',
                      style: TextStyle(
                        fontFamily: kTheArabicSansLight,
                        color: kGrayColor,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                      ),
                      children: [
                        TextSpan(
                          text: 'احمر شفاه',
                          style: TextStyle(
                            fontFamily: kTheArabicSansLight,
                            color: kBlackColor,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ])),
                ),
              ),
              SizedBox(
                height: 43.h,
              ),
              CarouselSlider(
                options: CarouselOptions(
                  height: 258.48.h,
                  enableInfiniteScroll: false,
                  onPageChanged: (index, reason) {
                    controller.update();
                    controller.changeTabIndex(index);
                  },
                ),
                items: controller.images.map((image) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Column(
                        children: [
                          Stack(
                            children: [
                              Image.asset(image.imagePath,
                                  width: 258.48.w,
                                  height: 258.48.h,
                                  fit: BoxFit.cover),
                              Positioned(
                                top: 10,
                                left: 10,
                                child: IconButton(
                                  icon: Icon(
                                    size: 30,
                                    image.isFavorite
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    color: image.isFavorite
                                        ? Colors.red
                                        : kTextDGColor,
                                  ),
                                  onPressed: () {
                                    controller.toggleFavorite(
                                        controller.images.indexOf(image));
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                  );
                }).toList(),
              ),
              SizedBox(
                height: 10.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  controller.images.length,
                  (index) => Obx(
                    () => Container(
                      margin: EdgeInsets.symmetric(horizontal: 5.w),
                      width: 10.w,
                      height: 10.h,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: index == controller.selectedTabIndex.value
                            ? kPrimaryColor // Active color
                            : Colors.grey, // Inactive color
                      ),
                    ),
                  ),
                ),
              ),
              /////////////////////////next part/////////////
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "L’oreal Paris",
                    style: TextStyle(
                        fontFamily: kTheArabicSansLight,
                        fontSize: 17.sp,
                        fontWeight: FontWeight.w700,
                        color: kPrimaryColor),
                  ),
                  Text(
                    "30.00 دل ",
                    style: TextStyle(
                        fontFamily: kTheArabicSansLight,
                        decoration: TextDecoration.lineThrough,
                        fontSize: 19.sp,
                        fontWeight: FontWeight.w400,
                        color: kBlackColor),
                  ),
                  Text(
                    "30.00 دل ",
                    style: TextStyle(
                        fontFamily: kTheArabicSansLight,
                        fontSize: 19.sp,
                        fontWeight: FontWeight.w400,
                        color: kPrimaryColor),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.topRight,
                child: Text(
                  "لوشن جل كونفيدنس المرطب للوجه من ات \nكوزميتكس",
                  style: TextStyle(
                      fontFamily: kTheArabicSansLight,
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w700,
                      color: kBlackColor),
                ),
              ),
              SizedBox(
                height: 27.h,
              ),
              ///////////container//////////
              Row(
                children: [
                  ColorContainer(
                    height: 51.h,
                    width: 52.w,
                    color: const Color(0xffD1877C),
                  ),
                  SizedBox(
                    width: 12.h,
                  ),
                  ColorContainer(
                    height: 51.h,
                    width: 52.w,
                    color: const Color(0xffCA5F4D),
                  ),
                  SizedBox(
                    width: 12.h,
                  ),
                  ColorContainer(
                    height: 51.h,
                    width: 52.w,
                    color: const Color(0xff7A261B),
                  ),
                  SizedBox(
                    width: 12.h,
                  ),
                  ColorContainer(
                    height: 51.h,
                    width: 52.w,
                    color: const Color(0xffE29094),
                  ),
                  SizedBox(
                    width: 12.h,
                  ),
                  ColorContainer(
                    height: 51.h,
                    width: 52.w,
                    color: const Color(0xffA64951),
                  ),
                  SizedBox(
                    width: 12.h,
                  ),
                  ColorContainer(
                    height: 51.h,
                    width: 52.w,
                    color: const Color(0xffD62247),
                  ),
                ],
              ),
              SizedBox(
                height: 20.h,
              ),
              Row(
                children: [
                  ColorContainer(
                    height: 51.h,
                    width: 52.w,
                    color: const Color(0xffE29094),
                  ),
                  SizedBox(
                    width: 12.h,
                  ),
                  ColorContainer(
                    height: 51.h,
                    width: 52.w,
                    color: const Color(0xffA64951),
                  ),
                  SizedBox(
                    width: 12.h,
                  ),
                  ColorContainer(
                    height: 51.h,
                    width: 52.w,
                    color: const Color(0xffD62247),
                  ),
                ],
              ),
              SizedBox(
                height: 34.h,
              ),
              Container(
                height: 41.88.h,
                width: 398.56.w,
                decoration: BoxDecoration(
                  border: Border.all(width: 1.5.w, color: kTextDGColor),
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        right: 10.w,
                      ),
                      child:
                          //  selectedDropdownItem != null
                          //     ? Text(
                          //         selectedDropdownItem!,
                          //         style: TextStyle(
                          //           color: kBlackColor,
                          //           fontFamily: kTheArabicSansLight,
                          //           fontSize: 14.sp,
                          //           fontWeight: FontWeight.w400,
                          //         ),
                          //       )
                          //     :
                          Text(
                        'الخيارات',
                        style: TextStyle(
                          color: kBlackColor,
                          fontFamily: kTheArabicSansLight,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    const Spacer(),
                    DropdownButton<String>(
                      elevation: 0,
                      items: [
                        'Rose Activist - 188',
                        'Blush Audace - 103',
                        'coral interevent - 241',
                        'Nude independence - 640',
                        'Nude Admirable  - 602',
                      ].asMap().entries.map((entry) {
                        int index = entry.key;
                        String value = entry.value;

                        return DropdownMenuItem<String>(
                          value: value,
                          child: Row(
                            children: [
                              Container(
                                width: 20.w,
                                height: 20.h,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: colorList[
                                      index], // Use the color from the list
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.r),
                              ),
                              Text(value),
                            ],
                          ),
                        );
                      }).toList(),
                      onChanged: (selectedItem) {
                        setState(() {
                          selectedDropdownItem = selectedItem;
                        });
                      },
                      value: selectedDropdownItem,
                    ),
                  ],
                ),
              ),

              SizedBox(
                height: 26.h,
              ),
              Row(
                children: [
                  Column(
                    children: [
                      Container(
                        height: 47.h,
                        width: 47.w,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border:
                                Border.all(color: kTextGrayColor, width: 1.w)),
                        child: Image.asset(knewImage),
                      ),
                      SizedBox(height: 6.h),
                      Image.asset(karabicone),
                    ],
                  ),
                  SizedBox(width: 26.w),
                  Column(
                    children: [
                      Container(
                        height: 47.h,
                        width: 47.w,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border:
                                Border.all(color: kTextGrayColor, width: 1.w)),
                        child: Image.asset(ktickImage),
                      ),
                      SizedBox(height: 6.h),
                      Image.asset(karabictwo),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 33.h,
              ),
              /////////////custom container/////////////////
              CustomContainer(
                height: 41.53.h,
                width: 403.96.w,
                imagePath: ktruckImage,
                backgroundColor: klPinkColor,
                text: 'خدمة التوصيل المجاني',
                textStyle: TextStyle(
                    fontFamily: kTheArabicSansLight,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                    color: kPrimaryColor),
              ),
              ///////////second container/////////////
              Container(
                height: 49.53.h,
                width: 403.96.w,
                color: kcontainerGrayColor,
                child: Padding(
                  padding: EdgeInsets.only(right: 86.w),
                  child: Text(
                    'داخل طرابلس عند التسوق بقيمة 500 د.ل او أكثر\nخارج طرابلس عند التسوق بقيمة 650 د.ل او أكثر ',
                    style: TextStyle(
                        fontFamily: kTheArabicSansLight,
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w400,
                        color: kBlackColor),
                  ),
                ),
              ),

              SizedBox(
                height: 14.h,
              ),
              CustomContainer(
                height: 41.53.h,
                width: 403.96.w,
                imagePath: kvantimeImage,
                backgroundColor: klPinkColor,
                text: 'التوصيل الفوري في نفس اليوم',
                textStyle: TextStyle(
                    fontFamily: kTheArabicSansLight,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                    color: kPrimaryColor),
              ),
              ///////////second container/////////////
              Container(
                height: 49.53.h,
                width: 403.96.w,
                color: kcontainerGrayColor,
                child: Padding(
                  padding: EdgeInsets.only(right: 86.w),
                  child: Text(
                    'عند الطلب قبل الساعة 12:00 ظهراً داخل طرابلس\nفيما عدا أيام العطل الأسبوعية و الرسمية',
                    style: TextStyle(
                        fontFamily: kTheArabicSansLight,
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w400,
                        color: kBlackColor),
                  ),
                ),
              ),

              SizedBox(
                height: 14.h,
              ),
              CustomContainer(
                height: 41.53.h,
                width: 403.96.w,
                imagePath: kgiftsImage,
                backgroundColor: klPinkColor,
                text: 'هدايا و عينات مجانية مع طلبك',
                textStyle: TextStyle(
                    fontFamily: kTheArabicSansLight,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                    color: kPrimaryColor),
              ),
              ///////////second container/////////////
              Container(
                height: 49.53.h,
                width: 403.96.w,
                color: kcontainerGrayColor,
                child: Padding(
                  padding: EdgeInsets.only(right: 86.w),
                  child: Text(
                    'احصلي على هدايا مميزة و عينات مجانية عند\nالتسوق بقيمة 300 د.ل او اكثر',
                    style: TextStyle(
                        fontFamily: kTheArabicSansLight,
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w400,
                        color: kBlackColor),
                  ),
                ),
              ),

              /////////////////////////////
              // Add your TabBar here
              SizedBox(
                height: 50.h,
              ),
              TabBar(
                tabs: [
                  Tab(
                    icon: Row(
                      children: [
                        Image.asset(kisolationImage),
                        SizedBox(
                          width: 10.w,
                        ),
                        Text(
                          'تفاصيل المنتج',
                          style: TextStyle(
                              fontFamily: kTheArabicSansLight,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w400,
                              color: kBlackColor),
                        ),
                      ],
                    ),
                  ),
                  Tab(
                    icon: Row(
                      children: [
                        Image.asset(kstarsImage),
                        SizedBox(
                          width: 10.w,
                        ),
                        Text(
                          'التقييمـــــــات',
                          style: TextStyle(
                              fontFamily: kTheArabicSansLight,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w400,
                              color: kBlackColor),
                        ),
                      ],
                    ),
                  )
                ],
                controller: tabcontroller.tabsController,
                indicatorColor: kPrimaryColor,
              ),

              Obx(() => tabcontroller.index.value == 0
                  ? const TabScreenOne()
                  : const TabScreenTwo()),

              SizedBox(
                height: 80.h,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: 25.h),
        child: FloatingActionButton.extended(
          disabledElevation: 0,
          label: Container(
            height: 138.49.h,
            width: 430.w,
            decoration: BoxDecoration(color: kWhiteColor, boxShadow: [
              BoxShadow(
                color: const Color.fromARGB(32, 0, 0, 0),
                blurRadius: 28.r,
                offset: const Offset(0, 4),
                spreadRadius: 0,
              ),
            ]),
            child: Row(
              children: [
                SizedBox(width: 45.w),
                GestureDetector(
                  onTap: () {
                    controller.decrement();
                  },
                  child: Container(
                      height: 47.61.h,
                      width: 49.08.w,
                      color: kPrimaryColor,
                      child: Center(
                        child: Text(
                          '-',
                          style: TextStyle(
                              color: kWhiteColor,
                              fontSize: 30.sp,
                              fontWeight: FontWeight.w500),
                        ),
                      )),
                ),
                Container(
                    height: 47.61.h,
                    width: 49.08.w,
                    color: kWhiteColor,
                    child: Center(
                      child: Obx(() => Text(
                            '${controller.count}',
                            style: TextStyle(
                              color: kBlackColor,
                              fontSize: 19.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          )),
                    )),
                GestureDetector(
                  onTap: () {
                    controller.increment();
                  },
                  child: Container(
                      height: 47.61.h,
                      width: 49.08.w,
                      color: kPrimaryColor,
                      child: Center(
                        child: Icon(
                          Icons.add,
                          color: kWhiteColor,
                          size: 30.r,
                        ),
                      )),
                ),
                SizedBox(width: 17.w),
                GestureDetector(
                  onTap: () {
                    log("print dailoug");
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return CustomAlertDialog(
                            height: 180.64.h,
                            width: 371.85.w,
                            dilougText:
                                'لقد قمت بإضافة هذا المنتج\n   إلى سلة الشراء بنجاح!',
                            buttonOneText: 'متابعــــــة\nالتســــوق',
                            buttonTwoText: 'إستكمال\nالطلب الان',
                          );
                        });
                  },
                  child: Container(
                      height: 47.61.h,
                      width: 200.65.w,
                      color: kPrimaryColor,
                      child: Center(
                        child: Text(
                          'إضافة الي السلة',
                          style: TextStyle(
                              fontFamily: kTheArabicSansLight,
                              color: kWhiteColor,
                              fontSize: 15.89.sp,
                              fontWeight: FontWeight.w500),
                        ),
                      )),
                ),
              ],
            ),
          ),
          onPressed: () {},
        ),
      ),
    );
  }
}
