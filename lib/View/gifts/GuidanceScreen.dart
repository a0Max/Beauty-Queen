// ignore_for_file: file_names

import 'package:beauty_queen/const/images.dart';
import 'package:beauty_queen/widgets/based/CustomAppBar.dart';
import 'package:beauty_queen/widgets/drawer/CustomEndDrawer.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geekyants_flutter_gauges/geekyants_flutter_gauges.dart';
import 'package:get/get.dart';

import '../../const/app_colors.dart';
import '../../const/app_images.dart';
import '../../const/colors.dart';
import '../../const/styles.dart';

import '../../const/vars.dart';
import '../../controller/gift_controller/gift_controller.dart';
import '../../models/sales_products_model.dart';
import '../../widgets/product_profile/CustomCardWidget.dart';
import '../../widgets/shimmer/shimmer_item.dart';
import '../../widgets/shimmer/shimmer_slider.dart';
import 'filterby_gifts_screen.dart';

class GuidanceScreen extends StatefulWidget {
  final bool? showBack;

  const GuidanceScreen({super.key, this.showBack});

  @override
  State<GuidanceScreen> createState() => _GuidanceScreenState();
}

class _GuidanceScreenState extends State<GuidanceScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final ScrollController _scrollController = ScrollController();
  bool _isScrolled = false;
  double searchBarWidth = 1.0;
  double searchBarHeight = 0.0;
  double searchBarTranslationX = 0.0;
  double searchBarTranslationY = 0.0;
  double containerheight = 1.0;
  final GiftController controller = Get.put(GiftController());

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    controller.getGiftsDataController(currentPage: 1);
  }

  void _scrollListener() {
    if (_scrollController.offset > 0 && !_isScrolled) {
      setState(() {
        _isScrolled = true;
        searchBarWidth = 0.75;
        searchBarTranslationX = 50.0;
        searchBarTranslationY = -52.0;
        containerheight = 0;
        searchBarHeight = 44.h;
      });
    } else if (_scrollController.offset <= 0 && _isScrolled) {
      setState(() {
        _isScrolled = false;
        searchBarWidth = 1.0;
        containerheight = 44.h;
        searchBarHeight = 44.h;
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
        preferredSize: Size.fromHeight(_isScrolled?100.h:160.h),
        child: CustomAppBar(
          // showBagIcon: true,
          // showFavIcon: true,
          // showPersonIcon: true,
          showarrowIcon: widget.showBack==true?true:false,
          showBagIcon: widget.showBack==true?false:true,
          showFavIcon:  widget.showBack==true?false:true,
          showPersonIcon:  widget.showBack==true?false:true,

          onPressed: () {
            // Handle the button click here, e.g., open the end drawer.
            _scaffoldKey.currentState?.openEndDrawer();
          },
          isScrolled: _isScrolled,
          searchBarHeight: searchBarHeight,
          containerHeight: containerheight,
          // Replace with your variable for scroll state
          searchBarWidth: searchBarWidth, // Replace with your desired width
          searchBarTranslationY: searchBarTranslationY,
          searchBarTranslationX: searchBarTranslationX,
          // Replace with your desired translation value
        ),
      ),
      endDrawer: const MyEndDrawer(),
      body: Obx(()=>SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            controller.isLoading.value == true
                ? ShimmerSlider(
              height: 139.17.h,
            )
                :  ( controller
                .generalSearchData.value.info?.banner != null)?
              SizedBox(
                  height: 139.17.h,
                  width: MediaQuery.of(context).size.width,
                  child: CachedNetworkImage(
                      imageUrl: Connection.urlOfStorage(
                          image: controller
                              .generalSearchData.value.info?.banner ??
                              '')))
                  : const SizedBox(),
            SizedBox(
              height: 20.h,
            ),
            Center(
              child: Text(tr('giftCard'),
                  style: TextStyle(
                    fontFamily: kTheArabicSansLight,
                    color: kBlackColor,
                    fontSize: 23.sp,
                    fontWeight: FontWeight.w400,
                  )),
            ),
            SizedBox(
              height: 10.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  height: 309.31.h,
                  width: 170.w,
                  decoration: BoxDecoration(
                      color: kPrimaryColor,
                      borderRadius: BorderRadius.circular(15.r)),
                  child: Stack(
                    children: [
                      Image.asset(kgiftImagetwo),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          height: 117.69.h,
                          width: 170.w,
                          decoration: BoxDecoration(
                              color: klPinkColor,
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(15.r),
                                  bottomRight: Radius.circular(15.r))),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "بطاقة هدايا بقيمة 250\n              دينار",
                                style: TextStyle(
                                    fontFamily: kTheArabicSansLight,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 15.sp,
                                    color: kPrimaryColor),
                              ),
                              GestureDetector(
                                onTap: () {},
                                child: Container(
                                  height: 36.28.h,
                                  width: 132.47.w,
                                  decoration: BoxDecoration(
                                      color: kPrimaryColor,
                                      borderRadius:
                                          BorderRadius.circular(15.r)),
                                  child: Center(
                                    child: Text(
                                      tr('add_to_bags'),
                                      style: TextStyle(
                                          fontFamily: kTheArabicSansLight,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 15.sp,
                                          color: kWhiteColor),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                //////////////////////second container/////////////////
                Container(
                  height: 309.31.h,
                  width: 170.w,
                  decoration: BoxDecoration(
                      color: kPrimaryColor,
                      borderRadius: BorderRadius.circular(15.r)),
                  child: Stack(
                    children: [
                      Image.asset(kgiftImagetwo),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          height: 117.69.h,
                          width: 170.w,
                          decoration: BoxDecoration(
                              color: klPinkColor,
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(15.r),
                                  bottomRight: Radius.circular(15.r))),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "بطاقة هدايا بقيمة 250\n              دينار",
                                style: TextStyle(
                                    fontFamily: kTheArabicSansLight,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 15.sp,
                                    color: kPrimaryColor),
                              ),
                              GestureDetector(
                                onTap: () {},
                                child: Container(
                                  height: 36.28.h,
                                  width: 132.47.w,
                                  decoration: BoxDecoration(
                                      color: kPrimaryColor,
                                      borderRadius:
                                          BorderRadius.circular(15.r)),
                                  child: Center(
                                    child: Text(
                                      tr('add_to_bags'),
                                      style: TextStyle(
                                          fontFamily: kTheArabicSansLight,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 15.sp,
                                          color: kWhiteColor),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 55.h,
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
                      border:
                      Border.all(color: AppColors.kPrimaryColor, width: 1.5.w),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: DropdownButton<String>(
                            iconEnabledColor: Colors.transparent,
                            isDense: true,
                            isExpanded: true,
                            alignment: Alignment.center,
                            value: controller.valueSort.value == ''
                                ? null
                                : controller.valueSort.value,
                            items: SortTypes.listOfTTypesOfSort.values
                                .map((value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value,
                                    style: TextStyle(
                                      color: AppColors.kBlackColor,
                                      fontSize: 14.sp,
                                      fontFamily: kTheArabicSansLight,
                                      fontWeight: FontWeight.w400,
                                      height: 0,
                                    )),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              SortTypes.listOfTTypesOfSort
                                  .forEach((key, value) {
                                if (value == newValue) {
                                  controller.updateSortType(
                                      newKeySort: key, newValueSort: value);
                                }
                              });
                            },
                            hint: Text(tr('classificationBy'),
                                style: TextStyle(
                                  color: AppColors.kBlackColor,
                                  fontSize: 18.sp,
                                  fontFamily: kTheArabicSansLight,
                                  fontWeight: FontWeight.w400,
                                  height: 0,
                                )),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 3.w),
                          child: SvgPicture.asset(AppImages.sortTypeImage),
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
                            Get.to(const FilterByGiftsContainer());
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
            SizedBox(
              height: 21.h,
            ),
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: EdgeInsets.only(right: 16.w),
                child: Text(
                    '${tr('count_items')}: ${controller.generalSearchData.value.gifts?.total ?? ''}',
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
            controller.isLoading.value == true
                ? Wrap(
              runSpacing: 7,
              children:
              List.generate(2, (index) => const ShimmerItem()),
            )
                :Wrap(
              runSpacing: 7,
              children: List.generate(
                  controller.dataProducts.value.length,
                      (index) => CustomCardWidget(
                    imageUrl: Connection.urlOfProducts(
                        image: controller
                            .dataProducts.value[index].mainImage ??
                            ''),
                    newArrival: controller.dataProducts.value[index] ??
                        SalesProductsModel(),
                  )),
            ),

            if (controller.dataProducts.value.isNotEmpty)...{

              const SizedBox(height: 40,),
              Text('${tr('result')}: ${controller.dataProducts.value
                  .length} ${tr('to')} ${controller.generalSearchData.value
                  .gifts?.total??0}'),
              const SizedBox(height: 10,),
              SizedBox(
                width: MediaQuery
                    .of(context)
                    .size
                    .width / 2,
                height: 30,
                child: LinearGauge(
                  gaugeOrientation: GaugeOrientation.horizontal,
                  start: 0,
                  end: double.parse(
                      "${controller.generalSearchData.value.gifts?.total ??
                          1}"),
                  valueBar: [
                    ValueBar(
                        value: double.parse("${controller.dataProducts
                            .value.length}"),
                        color: AppColors.mainColor,
                        borderRadius: 15,
                        valueBarThickness: 10)
                  ],
                  linearGaugeBoxDecoration:
                  const LinearGaugeBoxDecoration(
                      backgroundColor: AppColors.kShadowColor,
                      thickness: 10,
                      borderRadius: 15),
                  rulers: RulerStyle(
                    rulerPosition: RulerPosition.center,
                    showLabel: false,
                    showSecondaryRulers: false,
                    showPrimaryRulers: false,
                    secondaryRulersHeight: 0,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  controller.getGiftsDataController();
                },
                child: Container(
                  // height: 59.70.h,
                  padding: EdgeInsets.symmetric(vertical: 10.h),
                  width: MediaQuery
                      .of(context)
                      .size
                      .width / 2,
                  decoration: ShapeDecoration(
                    color: AppColors.kPrimaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.84),
                    ),
                  ),
                  child: Center(
                    child: Text(tr('showMore'),
                        style: TextStyle(
                            fontSize: 22.11.sp,
                            fontWeight: FontWeight.w400,
                            color: AppColors.kWhiteColor,
                            fontFamily: kTheArabicSansLight)),
                  ),
                ),
              )
            }
          ],
        ),
      )),
    );
  }
}
