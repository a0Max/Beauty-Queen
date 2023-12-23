import 'package:beauty_queen/const/app_images.dart';
import 'package:beauty_queen/const/extensions.dart';
import 'package:beauty_queen/const/styles.dart';
import 'package:beauty_queen/const/vars.dart';
import 'package:beauty_queen/widgets/based/CustomAppBar.dart';
import 'package:beauty_queen/widgets/drawer/CustomEndDrawer.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geekyants_flutter_gauges/geekyants_flutter_gauges.dart';
import 'package:get/get.dart';

import '../../const/app_colors.dart';
import '../../controller/nav_bar_controller/NavBarController.dart';
import '../../controller/search/search_controller.dart';
import '../../models/sales_products_model.dart';
import '../../widgets/product_profile/CustomCardWidget.dart';
import '../../widgets/shimmer/shimmer_categories.dart';
import '../../widgets/shimmer/shimmer_item.dart';
import '../brands/branddetail_screen.dart';
import 'filterby_search_screen.dart';

class SearchScreen extends StatefulWidget {
  final String subKeyWord;

  const SearchScreen({super.key, required this.subKeyWord});

  @override
  State<SearchScreen> createState() => _SearchScreen();
}

class _SearchScreen extends State<SearchScreen> {
  final ScrollController _scrollController = ScrollController();

  final SearchController0 _controller = Get.put(SearchController0());

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
    _controller.getSearchDetails(currentPage: 1, subKeyWord: widget.subKeyWord);
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
            showarrowIcon: true,
            showBagIcon: false,
            showFavIcon: false,
            showPersonIcon: false,

            countCart: _controllerNav.countCart.value,

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
                Container(
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    child: Text(
                      '${tr('result_of_search')}: ${_controller.keyWord.value}',
                      style: TextStyle(
                        fontFamily: kTheArabicSansLight,
                        color: AppColors.kGrayColor,
                        fontSize: 17.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    )),

                SizedBox(
                  height: 14.h,
                ),
                (_controller.isLoading.value == true)
                    ? const ShimmerCategories()
                    : (_controller.generalSearchData.value.brands?.isNotEmpty ??
                            false)
                        ? Container(
                            height: 140.h,
                            padding: EdgeInsets.symmetric(horizontal: 12.w),
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemCount: _controller
                                      .generalSearchData.value.brands?.length ??
                                  0,
                              itemBuilder: (BuildContext context, int index) {
                                return GestureDetector(
                                    onTap: () {
                                      Get.to(BrandDetailScreen(
                                        brandId: int.parse(_controller
                                                .generalSearchData
                                                .value
                                                .brands?[index]
                                                .id
                                                .toString() ??
                                            '0'),
                                      ));
                                    },
                                    child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(top: 10.h),
                                            decoration: BoxDecoration(
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(0.5),
                                                  spreadRadius: 1,
                                                  blurRadius: 8,
                                                  offset: const Offset(0, 1),
                                                ),
                                              ],
                                            ),
                                            child: CachedNetworkImage(
                                              imageUrl: Connection.urlOfBrands(
                                                  image: _controller
                                                          .generalSearchData
                                                          .value
                                                          .brands?[index]
                                                          .logo ??
                                                      ''),
                                              height: 105.h,
                                              width: 105.w,
                                            ),
                                          ),
                                          Text(
                                            _controller.generalSearchData.value
                                                    .brands?[index].titleAr ??
                                                '',
                                            style: TextStyle(
                                              fontFamily: kTheArabicSansLight,
                                              color: AppColors.kBlackColor,
                                              fontSize: 12.64.sp,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          )
                                        ]));
                              },
                              separatorBuilder:
                                  (BuildContext context, int index) => 25.pw,
                            ),
                          )
                        : SizedBox(),

                ///////////////filter////////////
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  child: Row(
                    children: [
                      Container(
                        height: 39.76.h,
                        width: 180.w,
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: AppColors.kPrimaryColor, width: 1.5.w),
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
                          border: Border.all(
                              color: AppColors.kPrimaryColor, width: 1.5.w),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Get.to(const FilterBySearchContainer());
                              },
                              child: Text(tr('filter_result'),
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
                        '${tr('count_items')}: ${_controller.generalSearchData.value.products?.total ?? ''}',
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
                _controller.isLoading.value == true
                    ? Wrap(
                        runSpacing: 7,
                        children:
                            List.generate(2, (index) => const ShimmerItem()),
                      )
                    : Wrap(
                        runSpacing: 7,
                        children: List.generate(
                            _controller.generalSearchData.value.products?.data
                                    ?.length ??
                                0,
                            (index) => CustomCardWidget(
                                  imageUrl: Connection.urlOfProducts(
                                      image: _controller
                                              .generalSearchData
                                              .value
                                              .products
                                              ?.data?[index]
                                              .mainImage ??
                                          ''),
                                  newArrival: _controller.generalSearchData
                                          .value.products?.data?[index] ??
                                      SalesProductsModel(),
                                  favorite: _controller
                                          .generalSearchData
                                          .value
                                          .products
                                          ?.data?[index]
                                          .isAddedToWishlist ??
                                      false,
                                )),
                      ),
                const SizedBox(
                  height: 40,
                ),

                if (_controller.dataProducts.value.isNotEmpty) ...{
                  Text(
                      '${tr('result')}: ${_controller.dataProducts.value.length} ${tr('to')} ${_controller.generalSearchData.value.products?.total}'),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2,
                    height: 30,
                    child: LinearGauge(
                      gaugeOrientation: GaugeOrientation.horizontal,
                      start: 0,
                      end: double.parse(
                          "${_controller.generalSearchData.value.products?.total ?? 1}"),
                      valueBar: [
                        ValueBar(
                            value: double.parse(
                                "${_controller.dataProducts.value.length}"),
                            color: AppColors.mainColor,
                            borderRadius: 15,
                            valueBarThickness: 10)
                      ],
                      linearGaugeBoxDecoration: const LinearGaugeBoxDecoration(
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
                      _controller.getSearchDetails(
                          subKeyWord: _controller.keyWord.value);
                    },
                    child: Container(
                      // height: 59.70.h,
                      padding: EdgeInsets.symmetric(vertical: 10.h),
                      width: MediaQuery.of(context).size.width / 2,
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
