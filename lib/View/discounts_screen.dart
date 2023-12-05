import 'package:beauty_queen/const/styles.dart';
import 'package:beauty_queen/widgets/CustomAppBar.dart';
import 'package:beauty_queen/widgets/CustomEndDrawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../const/colors.dart';
import '../const/images.dart';
import '../models/sales_products_model.dart';
import '../widgets/CustomCardWidget.dart';
import 'filterby_screen.dart';

class DiscountScreen extends StatefulWidget {
  const DiscountScreen({super.key});

  @override
  State<DiscountScreen> createState() => _DiscountScreenState();
}

class _DiscountScreenState extends State<DiscountScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _isScrolled = false;
  double searchBarWidth = 1.0;
  double searchBarHeight = 0.0;
  double searchBarTranslationX = 0.0;
  double searchBarTranslationY = 0.0;
  double containerheight = 1.0;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
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
        searchBarTranslationY = -42.0;
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
      key: _scaffoldKey,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(160.h),
          child: CustomAppBar(
            showBagIcon2: true,
            showMenuIcon: true,
            showarrowIcon: true,

            onPressed: () {
              // Handle the button click here, e.g., open the end drawer.
              _scaffoldKey.currentState?.openEndDrawer();
            },
            isScrolled: _isScrolled,

            // Replace with your variable for scroll state
            searchBarWidth: searchBarWidth, // Replace with your desired width
            searchBarTranslationY: searchBarTranslationY,
            searchBarTranslationX: searchBarTranslationX,
          )),
      endDrawer: const MyEndDrawer(),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            SizedBox(
                height: 139.17.h,
                width: 429.14.w,
                child: Image.asset(kbannerimageImage)),
            SizedBox(
              height: 14.h,
            ),
            Center(
              child: Text('التخفيضات',
                  style: TextStyle(
                    fontFamily: kTheArabicSansLight,
                    color: kBlackColor,
                    fontSize: 25.sp,
                    fontWeight: FontWeight.w400,
                  )),
            ),
            SizedBox(
              height: 14.h,
            ),
            ///////////////filter////////////
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
                          child: Text('فلترة النتائج',
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

            SizedBox(
              height: 21.h,
            ),
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: EdgeInsets.only(right: 16.w),
                child: Text('عدد المنتجات: 124',
                    style: TextStyle(
                      fontFamily: kTheArabicSansLight,
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
