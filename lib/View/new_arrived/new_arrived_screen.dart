// ignore_for_file: file_names

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
import '../../const/styles.dart';

import '../../const/vars.dart';
import '../../controller/auth_controller/auth_controler.dart';
import '../../controller/gift_controller/gift_controller.dart';
import '../../controller/nav_bar_controller/NavBarController.dart';
import '../../controller/new_arrived_controller/new_arrived_controller.dart';
import '../../models/sales_products_model.dart';
import '../../widgets/based/filter_widget.dart';
import '../../widgets/based/see_more.dart';
import '../../widgets/based/sort_drop_down.dart';
import '../../widgets/dialog_widget.dart';
import '../../widgets/home/CustomNavBar2.dart';
import '../../widgets/product_profile/CustomAlertBox.dart';
import '../../widgets/product_profile/CustomCardWidget.dart';
import '../../widgets/shimmer/shimmer_item.dart';
import '../../widgets/shimmer/shimmer_slider.dart';
import '../cart/cart_screen.dart';
import '../dialog_controller.dart';
import 'filterby_new_arrived_screen.dart';

class NewArrivedScreen extends StatefulWidget {
  final bool? showBack;

  const NewArrivedScreen({super.key, this.showBack});

  @override
  State<NewArrivedScreen> createState() => _NewArrivedScreen();
}

class _NewArrivedScreen extends State<NewArrivedScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final ScrollController _scrollController = ScrollController();
  bool _isScrolled = false;
  double searchBarWidth = 1.0;
  double searchBarHeight = 0.0;
  double searchBarTranslationX = 0.0;
  double searchBarTranslationY = 0.0;
  double containerheight = 1.0;
  final NewArrivedController controller = Get.put(NewArrivedController());
  final NavController _controllerNav = Get.put(NavController());

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    controller.getNewArrivedDataController(currentPage: 1);
    showDialog();
  }

  final DialogController dialogController = Get.put(DialogController());
  showDialog() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      dialogController.addObjects(Get.find<AuthController>().popData);
    });
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
    final DialogController dialogController = Get.find<DialogController>();
    return Obx(() => Scaffold(
          key: _scaffoldKey,
          bottomNavigationBar: const ReusableBottomNavigationBar2(),
          appBar: PreferredSize(
            preferredSize:
                userController.userData.value.accountType == AccountTypes.queena
                    ? Size.fromHeight(80.h)
                    : Size.fromHeight(100.h),
            child: CustomAppBar(
              // showBagIcon: true,
              // showFavIcon: true,
              // showPersonIcon: true,
              showarrowIcon: true,
              showBagIcon: false,
              showFavIcon: false,
              showPersonIcon: false,

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
                  child: Text(tr('newArrived'),
                      style: TextStyle(
                        fontFamily: kTheArabicSansLight,
                        color: AppColors.mainColor,
                        fontSize: 23.sp,
                        fontWeight: FontWeight.w400,
                      )),
                ),
                SizedBox(
                  height: 10.h,
                ),
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
                          }),
                      //////////////second///////////////
                      FilterWidget(
                        onTap: () {
                          Get.to(const FilterByNewArrivedContainer());
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
                        '${tr('count_items')}: ${controller.generalSearchData.value.newArrivals?.total ?? ''}',
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
                                  isDiscount: controller
                                      .dataProducts.value[index].isOffer,
                                  imageUrl: Connection.urlOfProducts(
                                      image: controller.dataProducts
                                              .value[index].mainImage ??
                                          ''),
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
                        "${controller.dataProducts.value.length}",
                    totalDataProductsLength:
                        "${controller.generalSearchData.value.newArrivals?.total ?? 1}",
                    onTap: () {
                      controller.getNewArrivedDataController();
                    },
                  )
                }
              ],
            ),
          ),
        ));
  }
}
