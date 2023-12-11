import 'package:beauty_queen/const/app_images.dart';
import 'package:beauty_queen/const/styles.dart';
import 'package:beauty_queen/const/vars.dart';
import 'package:beauty_queen/widgets/CustomAppBar.dart';
import 'package:beauty_queen/widgets/CustomEndDrawer.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geekyants_flutter_gauges/geekyants_flutter_gauges.dart';
import 'package:get/get.dart';

import '../../const/app_colors.dart';
// import '../../const/colors.dart';
import '../../controller/discounts_controller/sales_controller.dart';
import '../../controller/nav_bar_controller/NavBarController.dart';
import '../../models/sales_products_model.dart';
import '../../widgets/CustomCardWidget.dart';
import 'filterby_screen.dart';

class DiscountScreen extends StatefulWidget {
  final bool? showBack;

  const DiscountScreen({super.key, this.showBack});

  @override
  State<DiscountScreen> createState() => _DiscountScreenState();
}

class _DiscountScreenState extends State<DiscountScreen> {
  final ScrollController _scrollController = ScrollController();

  final SalesController _controller = Get.put(SalesController());

  bool _isScrolled = false;
  double searchBarWidth = 1.0;
  double searchBarHeight = 0.0;
  double searchBarTranslationX = 0.0;
  double searchBarTranslationY = 0.0;
  double containerheight = 1.0;
  final NavController _controllerNav = Get.put(NavController());

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    _controller.getSalesDataController(currentPage: 1);
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
          preferredSize: Size.fromHeight(_isScrolled ? 100.h : 160.h),
          child: CustomAppBar(
            // showBagIcon: true,
            // showFavIcon: true,
            // showPersonIcon: true,
            showarrowIcon: widget.showBack==true?true:false,
            showBagIcon: widget.showBack==true?false:true,
            showFavIcon:  widget.showBack==true?false:true,
            showPersonIcon:  widget.showBack==true?false:true,

            countCart: _controllerNav.countCart.value,
            onPressed: () {
              _scaffoldKey.currentState?.openEndDrawer();
            },
            isScrolled: _isScrolled,

            // Replace with your variable for scroll state
            searchBarWidth: searchBarWidth, // Replace with your desired width
            searchBarTranslationY: searchBarTranslationY,
            searchBarTranslationX: searchBarTranslationX,
          )),
      endDrawer: const MyEndDrawer(),
      body: Obx(() => SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                if ( _controller
                    .generalSearchData.value.info?.banner != null)
                  SizedBox(
                      height: 139.17.h,
                      width: MediaQuery.of(context).size.width,
                      child: CachedNetworkImage(
                          imageUrl: Connection.urlOfStorage(
                              image: _controller
                                      .generalSearchData.value.info?.banner ??
                                  ''))),
                SizedBox(
                  height: 14.h,
                ),
                Center(
                  child: Text('التخفيضات',
                      style: TextStyle(
                        fontFamily: kTheArabicSansLight,
                        color: AppColors.kBlackColor,
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
                                value: _controller.valueSort.value == ''
                                    ? null
                                    : _controller.valueSort.value,
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
                                      _controller.updateSortType(
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
                          border:
                              Border.all(color: AppColors.kPrimaryColor, width: 1.5.w),
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
                                    color: AppColors.kBlackColor,
                                    fontSize: 18.sp,
                                    fontFamily: kTheArabicSansLight,
                                    fontWeight: FontWeight.w400,
                                    height: 0,
                                  )),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 3.w),
                              // child: Image.asset(kfilterIconImage),
                              child:
                                  SvgPicture.asset(AppImages.filterTypeImage),
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
                        'عدد المنتجات: ${_controller.generalSearchData.value.salesCount ?? ''}',
                        style: TextStyle(
                          fontFamily: kTheArabicSansLight,
                          color: AppColors.kGrayColor,
                          fontSize: 17.sp,
                          fontWeight: FontWeight.w400,
                        )),
                  ),
                ),
                SizedBox(
                  height: 22.h,
                ),
                Wrap(
                  runSpacing: 7,
                  children: List.generate(
                      _controller.dataProducts.value.length,
                      (index) => CustomCardWidget(
                            imageUrl: Connection.urlOfProducts(
                                image: _controller
                                        .dataProducts.value[index].mainImage ??
                                    ''),
                            newArrival: _controller.dataProducts.value[index] ??
                                SalesProductsModel(),
                          )),
                ),
                const SizedBox(height: 40,),

                 if (_controller.dataProducts.value.isNotEmpty)...{
                   Text('النتائج: ${_controller.dataProducts.value
                       .length} من ${_controller.generalSearchData.value
                       .salesCount}'),
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
                           "${_controller.generalSearchData.value.salesCount ??
                               1}"),
                       valueBar: [
                         ValueBar(
                             value: double.parse("${_controller.dataProducts
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
                       _controller.getSalesDataController();
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
