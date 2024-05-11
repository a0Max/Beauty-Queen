// ignore_for_file: file_names

import 'package:beauty_queen/const/extensions.dart';
import 'package:beauty_queen/widgets/based/CustomAppBar.dart';
import 'package:beauty_queen/widgets/drawer/CustomEndDrawer.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';

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
import '../../controller/auth_controller/auth_controler.dart';
import '../../controller/gift_controller/gift_controller.dart';
import '../../controller/home_controller/home_controller.dart';
import '../../controller/nav_bar_controller/NavBarController.dart';
import '../../models/sales_products_model.dart';
import '../../widgets/based/filter_widget.dart';
import '../../widgets/based/see_more.dart';
import '../../widgets/based/sort_drop_down.dart';
import '../../widgets/gifts/gift_widget.dart';
import '../../widgets/home/CustomNavBar2.dart';
import '../../widgets/product_profile/CustomAlertBox.dart';
import '../../widgets/product_profile/CustomCardWidget.dart';
import '../../widgets/shimmer/shimmer_item.dart';
import '../../widgets/shimmer/shimmer_slider.dart';
import '../cart/cart_screen.dart';
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
  final NavController _controllerNav = Get.put(NavController());

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

  final AuthController userController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          key: _scaffoldKey,
          bottomNavigationBar: widget.showBack == true
              ? const ReusableBottomNavigationBar2()
              : null,
          appBar: PreferredSize(
            preferredSize:
                userController.userData.value.accountType == AccountTypes.queena
                    ? Size.fromHeight(_isScrolled
                        ? 80.h
                        : widget.showBack == true
                            ? 145.h
                            : 130.h)
                    : Size.fromHeight(_isScrolled ? 100.h : 160.h),
            child: CustomAppBar(
              // showBagIcon: true,
              // showFavIcon: true,
              // showPersonIcon: true,
              showarrowIcon: widget.showBack == true ? true : false,
              showBagIcon: true,
              showFavIcon: widget.showBack == true ? false : true,
              showPersonIcon: widget.showBack == true ? false : true,

              onPressed: () {
                // Handle the button click here, e.g., open the end drawer.
                _scaffoldKey.currentState?.openEndDrawer();
              },
              isScrolled: _isScrolled,
              searchBarHeight: searchBarHeight,
              containerHeight: containerheight,
              countCart: _controllerNav.countCart.value,
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
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  child: HtmlWidget(
                    controller.generalSearchData.value.info?.description ?? '',
                    textStyle: TextStyle(
                        fontFamily: kTheArabicSansBold,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                controller.isLoading.value == true
                    ? ShimmerSlider(
                        height: 139.17.h,
                      )
                    : (controller.generalSearchData.value.info?.banner != null)
                        ? SizedBox(
                            height: 139.17.h,
                            width: MediaQuery.of(context).size.width,
                            child: CachedNetworkImage(
                                imageUrl: Connection.urlOfStorage(
                                    image: controller.generalSearchData.value
                                            .info?.banner ??
                                        '')))
                        : const SizedBox(),
                SizedBox(
                  height: 20.h,
                ),
                Center(
                  child: Text(tr('giftCard'),
                      style: TextStyle(
                        fontFamily: kTheArabicSansBold,
                        color: AppColors.mainColor,
                        fontSize: 17.5.sp,
                        fontWeight: FontWeight.bold,
                      )),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  height: 270.69.h,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      GiftWidget(
                        price: '100',
                        onTap: () {
                          final HomeController _controller =
                              Get.put(HomeController());
                          _controller.addToCart(productId: 1513);
                        },
                      ),
                      10.pw,
                      GiftWidget(
                        price: '250',
                        onTap: () {
                          final HomeController _controller =
                              Get.put(HomeController());
                          _controller.addToCart(productId: 1514);
                        },
                      ),
                      10.pw,
                      GiftWidget(
                        price: '500',
                        onTap: () {
                          final HomeController _controller =
                              Get.put(HomeController());
                          _controller.addToCart(productId: 1515);
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 25.h,
                ),
                //////////custom drop down////////////

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  child: Row(
                    children: [
                      SortDropDown(
                        value: controller.valueSort.value == ''
                            ? null
                            : controller.valueSort.value,
                        onChanged: (String? newValue) {
                          SortTypes.listOfTTypesOfSort.forEach((key, value) {
                            if (value == newValue) {
                              controller.updateSortType(
                                  newKeySort: key, newValueSort: value);
                            }
                          });
                        },
                      ),

                      //////////////second///////////////
                      FilterWidget(
                        onTap: () {
                          Get.to(const FilterByGiftsContainer());
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
                        '${tr('count_items')}: ${controller.generalSearchData.value.gifts?.total ?? ''}',
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
                controller.isLoading.value == true
                    ? Wrap(
                        runSpacing: 7,
                        children:
                            List.generate(2, (index) => const ShimmerItem()),
                      )
                    : Wrap(
                        runSpacing: 7,
                        children: List.generate(
                            controller.dataProducts.value.length ?? 0,
                            (index) => CustomCardWidget(
                                  imageUrl: Connection.urlOfProducts(
                                      image: controller.dataProducts
                                              .value[index].mainImage ??
                                          ''),
                                  isDiscount: controller
                                      .dataProducts.value[index].isOffer,
                                  newArrival:
                                      controller.dataProducts.value[index] ??
                                          SalesProductsModel(),
                                  favorite: controller.dataProducts.value[index]
                                          .wishlist?.isNotEmpty ??
                                      false,
                                )),
                      ),

                if (controller.dataProducts.value.isNotEmpty) ...{
                  SeeMoreWidget(
                    currentDataProductsLength:
                        "${controller.dataProducts.value.length ?? 0}",
                    totalDataProductsLength:
                        "${controller.generalSearchData.value.gifts?.total ?? 1}",
                    onTap: () {
                      controller.getGiftsDataController();
                    },
                  ),
                }
              ],
            ),
          ),
        ));
  }
}
