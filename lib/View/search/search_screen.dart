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
import '../../controller/auth_controller/auth_controler.dart';
import '../../controller/nav_bar_controller/NavBarController.dart';
import '../../controller/search/search_controller.dart';
import '../../models/sales_products_model.dart';
import '../../widgets/based/filter_widget.dart';
import '../../widgets/based/see_more.dart';
import '../../widgets/based/sort_drop_down.dart';
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

  final AuthController userController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: PreferredSize(
          preferredSize:
              userController.userData.value.accountType == AccountTypes.queena
                  ? Size.fromHeight(_isScrolled ? 80.h : 145.h)
                  : Size.fromHeight(_isScrolled ? 100.h : 160.h),
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
                        : const SizedBox(),

                ///////////////filter////////////
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  child: Row(
                    children: [
                      SortDropDown(
                          value: _controller.valueSort.value == ''
                              ? null
                              : _controller.valueSort.value,
                          onChanged: (String? newValue) {
                            SortTypes.listOfTTypesOfSort.forEach((key, value) {
                              if (value == newValue) {
                                _controller.updateSortType(
                                    newKeySort: key, newValueSort: value);
                              }
                            });
                          }),
                      //////////////second///////////////
                      FilterWidget(
                        onTap: () {
                          Get.to(const FilterBySearchContainer());
                        },
                      )
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
                            _controller.dataProducts.value.length ?? 0,
                            (index) => CustomCardWidget(
                                  imageUrl: Connection.urlOfProducts(
                                      image: _controller.dataProducts
                                              .value[index].mainImage ??
                                          ''),
                                  isDiscount: _controller
                                      .dataProducts.value[index].isOffer,
                                  newArrival:
                                      _controller.dataProducts.value[index] ??
                                          SalesProductsModel(),
                                  favorite: _controller.dataProducts
                                          .value[index].wishlist?.isNotEmpty ??
                                      false,
                                )),
                      ),
                // const SizedBox(
                //   height: 40,
                // ),

                if (_controller.dataProducts.value.isNotEmpty) ...{
                  SeeMoreWidget(
                    currentDataProductsLength:
                        "${_controller.dataProducts.value.length}",
                    totalDataProductsLength:
                        "${_controller.generalSearchData.value.products?.total ?? 1}",
                    onTap: () {
                      _controller.getSearchDetails(
                          subKeyWord: _controller.keyWord.value);
                    },
                  )
                }
              ],
            ),
          )),
    );
  }
}
