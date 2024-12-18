import 'package:beauty_queen/const/extensions.dart';
import 'package:beauty_queen/const/styles.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
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
import '../../const/vars.dart';
import '../../controller/AlKasam_controller/alkasam_controller.dart';
import '../../controller/auth_controller/auth_controler.dart';
import '../../controller/brands_controller/brands_controller.dart';
import '../../models/sales_products_model.dart';
import '../../widgets/based/CustomAppBar.dart';
import '../../widgets/based/filter_widget.dart';
import '../../widgets/based/see_more.dart';
import '../../widgets/based/sort_drop_down.dart';
import '../../widgets/home/CustomNavBar2.dart';
import '../../widgets/product_profile/CustomCardWidget.dart';
import '../../widgets/drawer/CustomEndDrawer.dart';
import '../../widgets/shimmer/shimmer_item.dart';
import '../../widgets/shimmer/shimmer_slider.dart';
import '../categories/filter_screen2.dart';
import 'filterby_category_screen.dart';

class BrandDetailScreen extends StatefulWidget {
  final int brandId;
  const BrandDetailScreen({super.key, required this.brandId});

  @override
  State<BrandDetailScreen> createState() => _BrandDetailScreenState();
}

class _BrandDetailScreenState extends State<BrandDetailScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isScrolled = false;
  double searchBarWidth = 1.0;
  double searchBarTranslationX = 0.0;
  double searchBarTranslationY = 0.0;
  final ScrollController _scrollController = ScrollController();
  BrandsController controller = Get.put(BrandsController());

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    controller.getDetailsOfBrand(idOfBrand: widget.brandId, currentPage: 1);
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
      key: scaffoldKey,
      appBar: PreferredSize(
        preferredSize:
            userController.userData.value.accountType == AccountTypes.queena
                ? Size.fromHeight(80.h)
                : Size.fromHeight(100.h),
        child: CustomAppBar(
          showarrowIcon: true,
          showBagIcon: true,

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
      bottomNavigationBar: const ReusableBottomNavigationBar2(),
      body: Obx(() => SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                SizedBox(
                  height: 16.h,
                ),
                controller.isLoading.value == true
                    ? ShimmerSlider(
                        height: 70.h,
                      )
                    : (controller.generalSearchData.value.brand?.logo != null)
                        ? Container(
                            height: 70.h,
                            width: MediaQuery.of(context).size.width,
                            color: Color(int.parse(
                                "ff${controller.generalSearchData.value.brand?.logoBackground?.toUpperCase().replaceAll('#', '') ?? ''}",
                                radix: 16)),
                            child: CachedNetworkImage(
                                imageUrl: Connection.urlOfBrands3(
                                    image: controller.generalSearchData.value
                                            .brand?.logo ??
                                        '')),
                          )
                        : const SizedBox(),
                if ((controller.generalSearchData.value.brand?.mobileSlides
                            ?.isNotEmpty ??
                        false) &&
                    controller.generalSearchData.value.brand?.mobileSlides
                            ?.first.file !=
                        null &&
                    controller.isLoading.value != true) ...{
                  (controller.generalSearchData.value.brand?.mobileSlides
                                  ?.length ??
                              0) >
                          1
                      ? Container(
                          margin: EdgeInsets.only(top: 10),
                          child: CarouselSlider(
                              options: CarouselOptions(
                                viewportFraction:
                                    1.0, // Set to 1.0 for full width current page
                                aspectRatio: 2.74,
                                autoPlay: (controller.generalSearchData.value
                                                .brand?.mobileSlides?.length ??
                                            0) >
                                        1
                                    ? true
                                    : false,
                                enlargeCenterPage:
                                    true, // Make the current page full width
                              ),
                              items: List.generate(
                                controller.generalSearchData.value.brand
                                        ?.mobileSlides?.length ??
                                    0,
                                (index) => CachedNetworkImage(
                                  imageUrl: Connection.urlOfBrands3(
                                      image: controller
                                              .generalSearchData
                                              .value
                                              .brand
                                              ?.mobileSlides?[index]
                                              .file ??
                                          ''),
                                  fit: BoxFit.fill,
                                ),
                              )),
                        )
                      : Container(
                          margin: EdgeInsets.only(top: 10),
                          child: CachedNetworkImage(
                            imageUrl: Connection.urlOfBrands3(
                                image: controller.generalSearchData.value.brand
                                        ?.mobileSlides?.first.file ??
                                    ''),
                            fit: BoxFit.fill,
                          ),
                        )
                },
                if (controller.isLoading.value == true) ...{
                  const SizedBox()
                } else ...{
                  if (controller.generalSearchData.value.brand
                              ?.shortDescription !=
                          null &&
                      (controller.generalSearchData.value.brand!
                              .shortDescription?.isNotEmpty ??
                          false)) ...{
                    SizedBox(
                      height: 16.h,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 15.w),
                      child: HtmlWidget(
                        controller.generalSearchData.value.brand
                                ?.shortDescription ??
                            '',
                        textStyle: TextStyle(
                            fontFamily: kTheArabicSansBold,
                            fontWeight: FontWeight.w200),
                      ),
                    ),
                  },
                },
                if (controller.isLoading.value == true) ...{
                  const SizedBox()
                } else ...{
                  if (controller.generalSearchData.value.categories != null &&
                      (controller
                              .generalSearchData.value.categories?.isNotEmpty ??
                          false)) ...{
                    SizedBox(
                      height: 20.h,
                    ),
                    Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12.w),
                        child: SizedBox(
                          height: 140,
                          child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: [
                                ...List.generate(
                                    controller.generalSearchData.value
                                            .categories?.length ??
                                        0,
                                    (index) => Row(
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                final AlkasamController
                                                    controller0 = Get.put(
                                                        AlkasamController());
                                                controller0.updateCurrentCategoryId(
                                                    newId: int.parse(
                                                        "${controller.generalSearchData.value.categories?[index].id ?? 0}"),
                                                    getChild: null,
                                                    subId: controller
                                                        .generalSearchData
                                                        .value
                                                        .brand
                                                        ?.id);
                                                Get.to(FliterScreen2(
                                                  brandId: int.parse(
                                                      "${widget.brandId}"),
                                                  categoryId: int.parse(
                                                      "${controller.generalSearchData.value.categories?[index].id ?? 0}"),
                                                ));
                                              },
                                              child: Column(
                                                children: [
                                                  Container(
                                                    width: 100,
                                                    height: 100,
                                                    decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        image: DecorationImage(
                                                            image: CachedNetworkImageProvider(Connection.urlOfBrands3(
                                                                image: controller
                                                                        .generalSearchData
                                                                        .value
                                                                        .categories?[
                                                                            index]
                                                                        .image
                                                                        ?.file ??
                                                                    '')))),
                                                  ),
                                                  Text(
                                                    controller
                                                            .generalSearchData
                                                            .value
                                                            .categories?[index]
                                                            .title ??
                                                        '',
                                                    style: TextStyle(
                                                      fontFamily:
                                                          kTheArabicSansLight,
                                                      color:
                                                          AppColors.kGrayColor,
                                                      fontSize: 16.sp,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            10.pw,
                                          ],
                                        )),
                              ]),
                        )),
                  },
                },
                10.ph,
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
                                  newKeySort: key,
                                  newValueSort: value,
                                  idOfBrand: widget.brandId);
                            }
                          });
                        },
                      ),
                      //////////////second///////////////
                      FilterWidget(
                        onTap: () {
                          Get.to(FilterByBrandsContainer(
                            brandId: widget.brandId,
                          ));
                        },
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 19.h,
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: EdgeInsets.only(right: 17.h),
                    child: Text(
                        '${tr('count_items')}: ${controller.generalSearchData.value.products?.total ?? ''}',
                        style: const TextStyle(
                          fontFamily: kTheArabicSansLight,
                          color: AppColors.kGrayColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        )),
                  ),
                ),
                SizedBox(
                  height: 19.h,
                ),
                controller.isLoading.value == true
                    ? Wrap(
                        runSpacing: 7,
                        children:
                            List.generate(2, (index) => const ShimmerItem()),
                      )
                    : Wrap(
                        runSpacing: 24,
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
                        "${controller.generalSearchData.value.products?.total ?? 1}",
                    onTap: () {
                      controller.getDetailsOfBrand(idOfBrand: widget.brandId);
                    },
                  ),
                }
                // SizedBox(
                //   height: 50.h,
                // ),
              ],
            ),
          )),
    );
  }
}
