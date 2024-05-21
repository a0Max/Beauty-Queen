import 'package:beauty_queen/const/extensions.dart';
import 'package:beauty_queen/widgets/drawer/CustomEndDrawer.dart';
import 'package:beauty_queen/widgets/shimmer/shimmer_category_filter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:geekyants_flutter_gauges/geekyants_flutter_gauges.dart';
import 'package:get/get.dart';
import '../../const/app_colors.dart';
import '../../const/app_images.dart';
import '../../const/styles.dart';
import '../../const/vars.dart';
import '../../controller/AlKasam_controller/alkasam_controller.dart';
import '../../controller/auth_controller/auth_controler.dart';
import '../../models/sales_products_model.dart';
import '../../widgets/based/CustomAppBar.dart';
import '../../widgets/based/filter_widget.dart';
import '../../widgets/based/see_more.dart';
import '../../widgets/based/sort_drop_down.dart';
import '../../widgets/home/CustomNavBar2.dart';
import '../../widgets/product_profile/CustomCardWidget.dart';
import '../../widgets/categories/custom_fliter_ container.dart';
import '../../widgets/shimmer/shimmer_item.dart';
import '../../widgets/shimmer/shimmer_slider.dart';
import '../brands/branddetail_screen.dart';
import '../product_profile/products_screen.dart';
import 'filter_screen2.dart';
import 'filterby_category_screen.dart';

class FliterScreen extends StatefulWidget {
  final int categoryId;
  const FliterScreen({super.key, required this.categoryId});

  @override
  State<FliterScreen> createState() => _FliterScreenState();
}

class _FliterScreenState extends State<FliterScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final AlkasamController _controller = Get.put(AlkasamController());

  final ScrollController _scrollController = ScrollController();
  bool _isScrolled = false;
  double searchBarWidth = 1.0;
  double searchBarHeight = 0.0;
  double searchBarTranslationX = 0.0;
  double searchBarTranslationY = 0.0;
  double containerheight = 1.0;
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    // _controller.getCategoriesDataController(currentPage: 1);
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

  final AuthController userController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        bottomNavigationBar: const ReusableBottomNavigationBar2(),
        appBar: PreferredSize(
          preferredSize:
              userController.userData.value.accountType == AccountTypes.queena
                  ? Size.fromHeight(80.h)
                  : Size.fromHeight(100.h),
          child: CustomAppBar(
            showFavIcon: false,
            showBagIcon: true,
            showarrowIcon: true,
            onPressed: () {
              _scaffoldKey.currentState?.openEndDrawer();
            },

            isScrolled: _isScrolled,
            searchBarWidth: searchBarWidth, // Replace with your desired width
            searchBarTranslationY: searchBarTranslationY,
            searchBarTranslationX: searchBarTranslationX,
          ),
        ),
        endDrawer: const MyEndDrawer(),
        body: Obx(() => SingleChildScrollView(
              controller: _scrollController,
              child:
                  Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                SizedBox(
                  height: 0.h,
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: EdgeInsets.only(right: 17.h),
                    child: Obx(() => Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                "${tr('categories')} / ",
                                style: TextStyle(
                                  fontFamily: kTheArabicSansLight,
                                  color: AppColors.kGrayColor,
                                  fontSize: 17.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            Text(
                              _controller.categoryData.value
                                  .where((element) =>
                                      element.id == widget.categoryId)
                                  .toList()
                                  .first
                                  .title,
                              style: TextStyle(
                                fontFamily: kTheArabicSansLight,
                                color: AppColors.kBlackColor,
                                fontSize: 17.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            )
                          ],
                        )),
                  ),
                ),
                if (_controller.generalSearchData.value.info?.description !=
                    null) ...{
                  15.ph,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: HtmlWidget(
                      _controller.generalSearchData.value.info?.description ??
                          '',
                      textStyle: TextStyle(fontFamily: kTheArabicSansLight),
                    ),
                  )
                },
                _controller.isLoading.value == true
                    ? ShimmerSlider(
                        height: 139.17.h,
                      )
                    : (_controller.generalSearchData.value.info?.banner != null)
                        ? GestureDetector(
                            onTap: () {
                              if (_controller.generalSearchData.value.info
                                      ?.bannerIsLink ==
                                  '1') {
                                if (_controller.generalSearchData.value.info
                                        ?.bannerLinkType ==
                                    LinkTypes.brand) {
                                  Get.to(BrandDetailScreen(
                                    brandId: int.parse(_controller
                                            .generalSearchData
                                            .value
                                            .info
                                            ?.bannerLinkId ??
                                        '0'),
                                  ));
                                } else if (_controller.generalSearchData.value
                                        .info?.bannerLinkType ==
                                    LinkTypes.product) {
                                  Get.to(ItemProfilePage(
                                      itemId: int.parse(_controller
                                              .generalSearchData
                                              .value
                                              .info
                                              ?.bannerLinkId ??
                                          '0')));
                                } else if (_controller.generalSearchData.value
                                        .info?.bannerLinkType ==
                                    LinkTypes.category) {
                                  AlkasamController controller =
                                      Get.put(AlkasamController());
                                  controller.updateCurrentCategoryId(
                                      newId: int.parse(_controller
                                              .generalSearchData
                                              .value
                                              .info
                                              ?.bannerLinkId ??
                                          '0'),
                                      getChild: null);
                                  Get.to(FliterScreen2(
                                    categoryId: int.parse(_controller
                                            .generalSearchData
                                            .value
                                            .info
                                            ?.bannerLinkId ??
                                        '0'),
                                  ));
                                } else if (_controller.generalSearchData.value
                                        .info?.bannerLinkType ==
                                    LinkTypes.brands) {
                                  Get.to(BrandDetailScreen(
                                    brandId: int.parse(_controller
                                            .generalSearchData
                                            .value
                                            .info
                                            ?.bannerLinkId ??
                                        '0'),
                                  ));
                                }
                              }
                            },
                            child: SizedBox(
                                height: 139.17.h,
                                width: MediaQuery.of(context).size.width,
                                child: CachedNetworkImage(
                                    height: 139.17.h,
                                    width: MediaQuery.of(context).size.width,
                                    imageUrl: Connection.urlOfStorage(
                                        image: _controller.generalSearchData
                                                .value.info?.banner ??
                                            ''))),
                          )
                        : const SizedBox(),
                SizedBox(
                  height: 24.h,
                ),
                _controller.isLoading.value == true
                    ? SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: List.generate(
                            4,
                            (index) => const ShimmerCategoryFilter(),
                          ),
                        ),
                      )
                    : SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: List.generate(
                            _controller.categoryData.value
                                .where((element) =>
                                    element.id == widget.categoryId)
                                .toList()
                                .first
                                .children
                                .length,
                            (index) => Padding(
                              padding: EdgeInsets.only(right: 8.82.w),
                              child: Obx(
                                () => MyCustomContainer(
                                  text: _controller.categoryData.value
                                      .where((element) =>
                                          element.id == widget.categoryId)
                                      .toList()
                                      .first
                                      .children[index]
                                      .title,
                                  isSelected: _controller.categoryData.value
                                          .where((element) =>
                                              element.id == widget.categoryId)
                                          .toList()
                                          .first
                                          .children[index]
                                          .id ==
                                      _controller.currentCategoryId.value,
                                  onTap: () {
                                    _controller.updateCurrentCategoryId(
                                        newId: _controller.categoryData.value
                                                .where((element) =>
                                                    element.id ==
                                                    widget.categoryId)
                                                .toList()
                                                .first
                                                .children[index]
                                                .id ??
                                            0,
                                        getChild: true);
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                SizedBox(
                  height: 10.h,
                ),
                SizedBox(
                  // height: 34.95.h,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(
                        _controller.childCategoryData.length,
                        (index) => Padding(
                          padding: EdgeInsets.only(right: 8.82.w),
                          child: Obx(
                            () => MyCustomContainer(
                              text: _controller
                                  .childCategoryData.value[index].title,
                              isSelected: _controller
                                      .childCategoryData.value[index].id ==
                                  _controller.childCurrentCategoryId.value,
                              onTap: () {
                                _controller.updateChildCurrentCategoryId(
                                    newId: _controller.childCategoryData
                                            .value[index].id ??
                                        0);
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 19.h,
                ),

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
                          Get.to(const FilterByCategoryContainer());
                        },
                      )
                    ],
                  ),
                ),

                ////////////////////base///////////////
                SizedBox(
                  height: 15.h,
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: EdgeInsets.only(right: 17.h),
                    child: Text(
                        '${tr('count_items')}: ${_controller.generalSearchData.value.products?.total ?? ''}',
                        style: const TextStyle(
                          fontFamily: kTheArabicSansLight,
                          color: AppColors.kGrayColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                        )),
                  ),
                ),
                SizedBox(
                  height: 15.h,
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
                if (_controller.dataProducts.value.isNotEmpty) ...{
                  SeeMoreWidget(
                    currentDataProductsLength:
                        "${_controller.dataProducts.value.length}",
                    totalDataProductsLength:
                        "${_controller.generalSearchData.value.products?.total ?? _controller.dataProducts.value.length}",
                    onTap: () {
                      _controller.getCategoriesDataController();
                    },
                  )
                }
                // if (_controller.dataProducts.value.isNotEmpty) ...{
                //
                // }
              ]),
            )));
  }
}
