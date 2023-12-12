import 'package:beauty_queen/widgets/based/CustomAppBar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../const/colors.dart';
import '../const/images.dart';
import '../const/styles.dart';
import '../models/sales_products_model.dart';
import '../widgets/CustomCardWidget.dart';
import '../widgets/CustomEndDrawer.dart';
import 'discount/filterby_screen.dart';

class BeautyPharmaScreen extends StatefulWidget {
  const BeautyPharmaScreen({super.key});

  @override
  State<BeautyPharmaScreen> createState() => _BeautyPharmaScreenState();
}

class _BeautyPharmaScreenState extends State<BeautyPharmaScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
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
        child: Column(
          children: [
            SizedBox(
                height: 139.17.h,
                width: 429.14.w,
                child: Image.asset(kbeautyPhramaImage)),
            SizedBox(
              height: 34.h,
            ),
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: EdgeInsets.only(right: 17.w),
                child: Text.rich(TextSpan(
                    text: "الأقسام / ",
                    style: TextStyle(
                      fontFamily: kTheArabicSansLight,
                      color: const Color(0xff696969),
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w400,
                    ),
                    children: [
                      TextSpan(
                        text: 'صيدلية الجمال',
                        style: TextStyle(
                          fontFamily: kTheArabicSansLight,
                          color: kBlackColor,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      )
                    ])),
              ),
            ),
            SizedBox(
              height: 46.h,
            ),
            //////////custom drop down////////////

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              child: Row(
                children: [
                  Container(
                    height: 39.76.h,
                    width: 180.w,
                    decoration: BoxDecoration(
                      border: Border.all(color: kPrimaryColor, width: 1.5.w),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: DropdownButton<String>(
                            iconEnabledColor: Colors.transparent,
                            isDense: true,
                            isExpanded: true,

                            alignment: Alignment.center,
                            value: null, // Set the initial value to null
                            items: [
                              DropdownMenuItem<String>(
                                value: 'المضاف حديثاً',
                                child: Text('المضاف حديثاً',
                                    style: TextStyle(
                                      color: kBlackColor,
                                      fontSize: 14.sp,
                                      fontFamily: kTheArabicSansLight,
                                      fontWeight: FontWeight.w400,
                                      height: 0,
                                    )),
                              ),
                              DropdownMenuItem<String>(
                                value: 'الأكثر مبيعاً',
                                child: Text('الأكثر مبيعاً',
                                    style: TextStyle(
                                      color: kBlackColor,
                                      fontSize: 14.sp,
                                      fontFamily: kTheArabicSansLight,
                                      fontWeight: FontWeight.w400,
                                      height: 0,
                                    )),
                              ),
                              DropdownMenuItem<String>(
                                value: 'السعر من أقل الي الأعلي',
                                child: Text('السعر من أقل الي الأعلي',
                                    style: TextStyle(
                                      color: kBlackColor,
                                      fontSize: 14.sp,
                                      fontFamily: kTheArabicSansLight,
                                      fontWeight: FontWeight.w400,
                                      height: 0,
                                    )),
                              ),
                              DropdownMenuItem<String>(
                                value: 'السعر من الأعلي أقل الي',
                                child: Text('السعر من الأعلي أقل الي',
                                    style: TextStyle(
                                      color: kBlackColor,
                                      fontSize: 14.sp,
                                      fontFamily: kTheArabicSansLight,
                                      fontWeight: FontWeight.w400,
                                      height: 0,
                                    )),
                              ),
                            ],
                            onChanged: (String? newValue) {
                              // Handle the selected option if needed
                            },
                            hint: Text('التصنيف حسب',
                                style: TextStyle(
                                  color: kBlackColor,
                                  fontSize: 18.sp,
                                  fontFamily: kTheArabicSansLight,
                                  fontWeight: FontWeight.w400,
                                  height: 0,
                                )),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 3.w),
                          child: Image.asset(ksortIconImage),
                        ),
                      ],
                    ),
                  ),
                  //////////////second///////////////
                  Container(
                    height: 39.76.h,
                    width: 180.w,
                    decoration: BoxDecoration(
                      border: Border.all(color: kPrimaryColor, width: 1.5.w),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.to(const FilterByContainer());
                          },
                          child: Text(tr('filter_result'),
                              style: TextStyle(
                                color: kBlackColor,
                                fontSize: 18.sp,
                                fontFamily: kTheArabicSansLight,
                                fontWeight: FontWeight.w400,
                                height: 0,
                              )),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 3.w),
                          child: Image.asset(kfilterIconImage),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // ///////////////filter////////////
            // Padding(
            //   padding: EdgeInsets.symmetric(horizontal: 16.w),
            //   child: Container(
            //     height: 39.76.h,
            //     width: 398.77.w,
            //     decoration: BoxDecoration(
            //       border: Border.all(color: kPrimaryColor, width: 1.w),
            //     ),
            //     child: Row(
            //       children: [
            //         Expanded(
            //           child: Padding(
            //             padding: EdgeInsets.only(right: 10.w),
            //             child: Obx(() {
            //               return DropdownButton<String>(
            //                 elevation: 0,
            //                 iconEnabledColor: Colors.transparent,
            //                 value: filterController.selectedFilter.value.isEmpty
            //                     ? null
            //                     : filterController.selectedFilter.value,
            //                 items: filterController.chipData.map((item) {
            //                   return DropdownMenuItem<String>(
            //                     value: item['label'],
            //                     child: Text(item['label']),
            //                   );
            //                 }).toList(),
            //                 onChanged: (String? newValue) {
            //                   filterController.filterData(newValue!);
            //                 },
            //                 hint: const Text('التصنيف حسب'),
            //               );
            //             }),
            //           ),
            //         ),
            //         Padding(
            //           padding: EdgeInsets.only(left: 10.w),
            //           child: Image.asset(ksortIconImage),
            //         ),
            //         const VerticalDivider(
            //           color: kPrimaryColor,
            //           thickness: 1,
            //         ),
            //         Expanded(
            //           child: Obx(() {
            //             return DropdownButton<String>(
            //               elevation: 0,
            //               iconEnabledColor: Colors.transparent,
            //               value: filterController.selectedFilter.value.isEmpty
            //                   ? null
            //                   : filterController.selectedFilter.value,
            //               items: filterController.chipData.map((item) {
            //                 return DropdownMenuItem<String>(
            //                   value: item['label'],
            //                   child: Text(item['label']),
            //                 );
            //               }).toList(),
            //               onChanged: (String? newValue) {
            //                 filterController.filterData(newValue!);
            //               },
            //               hint: const Text('فلترة النتائج'),
            //             );
            //           }),
            //         ),
            //         Padding(
            //           padding: EdgeInsets.only(left: 10.w),
            //           child: Image.asset(kfilterIconImage),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),

            SizedBox(
              height: 21.h,
            ),
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: EdgeInsets.only(right: 16.w),
                child: Text('عدد المنتجات: 124',
                    style: TextStyle(
                      color: kGrayColor,
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w400,
                    )),
              ),
            ),
            SizedBox(
              height: 22.h,
            ),
             Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomCardWidget(
                    imageUrl: kBaseImage,
                    imgtxt: 'Makeup Forever',
                    price: '150.00',
                    des: 'كريم اساس الترا اتش دي السائل من ميكب',
                    disprice: '190.00',
                    containertxt: 'تحديد الخيارات', newArrival:SalesProductsModel() ),
                CustomCardWidget(
                    imageUrl: kLispticImage,
                    imgtxt: 'Rare Beauty',
                    price: '94.00',
                    des: 'طقم فريش اند ديوي للشفاه والخدود من رير بيوتي',
                    disprice: '94.00',
                    containertxt: 'إضافة إلي السلة', newArrival:SalesProductsModel() ),
              ],
            ),
             Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomCardWidget(
                    imageUrl: kBaseImage,
                    imgtxt: 'Makeup Forever',
                    price: '150.00',
                    des: 'كريم اساس الترا اتش دي السائل من ميكب',
                    disprice: '190.00',
                    containertxt: 'تحديد الخيارات', newArrival:SalesProductsModel() ),
                CustomCardWidget(
                    imageUrl: kLispticImage,
                    imgtxt: 'Rare Beauty',
                    price: '94.00',
                    des: 'طقم فريش اند ديوي للشفاه والخدود من رير بيوتي',
                    disprice: '94.00',
                    containertxt: 'إضافة إلي السلة', newArrival:SalesProductsModel() ),
              ],
            ),
             Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomCardWidget(
                    imageUrl: kBaseImage,
                    imgtxt: 'Makeup Forever',
                    price: '150.00',
                    des: 'كريم اساس الترا اتش دي السائل من ميكب',
                    disprice: '190.00',
                    containertxt: 'تحديد الخيارات', newArrival:SalesProductsModel() ),
                CustomCardWidget(
                    imageUrl: kLispticImage,
                    imgtxt: 'Rare Beauty',
                    price: '94.00',
                    des: 'طقم فريش اند ديوي للشفاه والخدود من رير بيوتي',
                    disprice: '94.00',
                    containertxt: 'إضافة إلي السلة', newArrival:SalesProductsModel() ),
              ],
            ),
             Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomCardWidget(
                    imageUrl: kBaseImage,
                    imgtxt: 'Makeup Forever',
                    price: '150.00',
                    des: 'كريم اساس الترا اتش دي السائل من ميكب',
                    disprice: '190.00',
                    containertxt: 'تحديد الخيارات', newArrival:SalesProductsModel() ),
                CustomCardWidget(
                    imageUrl: kLispticImage,
                    imgtxt: 'Rare Beauty',
                    price: '94.00',
                    des: 'طقم فريش اند ديوي للشفاه والخدود من رير بيوتي',
                    disprice: '94.00',
                    containertxt: 'إضافة إلي السلة', newArrival:SalesProductsModel() ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
