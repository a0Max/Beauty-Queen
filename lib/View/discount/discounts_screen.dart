import 'package:beauty_queen/const/app_images.dart';
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
import '../../controller/discounts_controller/sales_controller.dart';
import '../../controller/nav_bar_controller/NavBarController.dart';
import '../../models/sales_products_model.dart';
import '../../widgets/based/filter_widget.dart';
import '../../widgets/based/see_more.dart';
import '../../widgets/based/sort_drop_down.dart';
import '../../widgets/home/CustomNavBar2.dart';
import '../../widgets/product_profile/CustomCardWidget.dart';
import '../../widgets/shimmer/shimmer_item.dart';
import '../../widgets/shimmer/shimmer_slider.dart';
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

  final AuthController userController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          key: _scaffoldKey,
          bottomNavigationBar: widget.showBack == true
              ? const ReusableBottomNavigationBar2()
              : null,
          appBar: PreferredSize(
              preferredSize: userController.userData.value.accountType ==
                      AccountTypes.queena
                  ? Size.fromHeight(_isScrolled
                      ? 80.h
                      : widget.showBack == true
                          ? 145.h
                          : 130.h)
                  : Size.fromHeight(_isScrolled ? 100.h : 160.h),
              child: CustomAppBar(
                showarrowIcon: widget.showBack == true ? true : false,
                showBagIcon: true,
                showFavIcon: widget.showBack == true ? false : true,
                showPersonIcon: widget.showBack == true ? false : true,
                countCart: _controllerNav.countCart.value,
                onPressed: () {
                  _scaffoldKey.currentState?.openEndDrawer();
                },
                isScrolled: _isScrolled,
                searchBarWidth:
                    searchBarWidth, // Replace with your desired width
                searchBarTranslationY: searchBarTranslationY,
                searchBarTranslationX: searchBarTranslationX,
              )),
          endDrawer: const MyEndDrawer(),
          body: SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                _controller.isLoading.value == true
                    ? ShimmerSlider(
                        height: 139.17.h,
                      )
                    : (_controller.generalSearchData.value.info?.banner != null)
                        ? SizedBox(
                            height: 139.17.h,
                            width: MediaQuery.of(context).size.width,
                            child: CachedNetworkImage(
                                imageUrl: Connection.urlOfStorage(
                                    image: _controller.generalSearchData.value
                                            .info?.banner ??
                                        '')))
                        : const SizedBox(),
                SizedBox(
                  height: 14.h,
                ),
                Center(
                  child: Text(tr('offers_sale_down'),
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
                        },
                      ),
                      //////////////second///////////////
                      FilterWidget(
                        onTap: () {
                          Get.to(const FilterByContainer());
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
                        '${tr('count_items')}: ${_controller.generalSearchData.value.salesCount ?? ''}',
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
                                    image: _controller.dataProducts.value[index]
                                            .mainImage ??
                                        ''),
                                newArrival: _controller.dataProducts[index] ??
                                    SalesProductsModel(),
                                favorite: _controller.dataProducts.value[index]
                                        .wishlist?.isNotEmpty ??
                                    false,
                                isDiscount: _controller
                                    .dataProducts.value[index].isOffer)),
                      ),
                // const SizedBox(
                //   height: 40,
                // ),

                if (_controller.dataProducts.value.isNotEmpty) ...{
                  SeeMoreWidget(
                    currentDataProductsLength:
                        "${_controller.dataProducts.value.length ?? 0}",
                    totalDataProductsLength:
                        "${_controller.generalSearchData.value.salesCount ?? 1}",
                    onTap: () {
                      _controller.getSalesDataController();
                    },
                  ),
                }
              ],
            ),
          ),
        ));
  }
}
