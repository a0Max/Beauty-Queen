import 'dart:developer';

import 'package:beauty_queen/View/product_profile/tab_screen_one.dart';
import 'package:beauty_queen/const/app_images.dart';
import 'package:beauty_queen/const/extensions.dart';
import 'package:beauty_queen/const/styles.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:widget_zoom/widget_zoom.dart';
import '../../const/app_colors.dart';
import '../../const/size.dart';
import '../../const/vars.dart';
import '../../controller/AlKasam_controller/alkasam_controller.dart';
import '../../controller/nav_bar_controller/NavBarController.dart';
import '../../controller/product_controller/product_profile_controller.dart';
import '../../controller/product_controller/product_profile_controller_provider.dart';
import '../../controller/queen_controller/queen_controller.dart';
import '../../models/options_model.dart';
import '../../models/sales_products_model.dart';
import '../../widgets/drawer/CustomEndDrawer.dart';
import '../../widgets/product_profile/CustomAlertBox.dart';
import '../../widgets/product_profile/CustomCardWidget.dart';
import '../../widgets/product_profile/CustomCardWidget2.dart';
import '../../widgets/product_profile/custom_color_container.dart';
import '../../widgets/product_profile/details_static.dart';
import '../../widgets/shimmer/shimmer_new_items.dart';
import '../../widgets/shimmer/shimmer_profile.dart';
import '../../widgets/shimmer/shimmer_text.dart';
import '../brands/branddetail_screen.dart';
import '../cart/cart_screen.dart';
import '../categories/alkasam_screen.dart';
import '../categories/filter_screen2.dart';
import '../home/bottom_nav_screen.dart';
import '../offers/beautypharmacyscreen.dart';
import '../whats_queena/Quinaprogram_screen.dart';
import 'currentPriceWithBlack.dart';
import 'currentPriceWithPink.dart';
import 'oldPriceWithBlack.dart';
import 'tab_screen_two.dart';

class ItemProfilePage extends StatefulWidget {
  bool? isQueenOffer;
  final int itemId;
  ItemProfilePage({super.key, required this.itemId, this.isQueenOffer});

  @override
  State<ItemProfilePage> createState() => _ItemProfilePageState();
}

class _ItemProfilePageState extends State<ItemProfilePage>
    with SingleTickerProviderStateMixin {
  // final ProductProfileController controller =
  //     Get.put(ProductProfileController());
  bool isFavorite = false;
  final NavController _controllerNav = Get.put(NavController());
  late TabController tabsController;
  int indexTap = 0;
  @override
  void initState() {
    super.initState();
    tabsController = TabController(vsync: this, length: 2);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      getDataOfProduct();
    });
  }

  final ScrollController scrollController = ScrollController();

  getDataOfProduct() async {
    final controller = context.read<ProductProfileControllerProvider>();

    await controller.getCurrentProduct(productId: widget.itemId);
    setState(() {
      try {
        isFavorite =
            controller.productData.last.product.wishlist?.isNotEmpty ?? false;
      } catch (e) {
        log("###########${controller.productData}");
        print("###########${controller.productData}");
      }
    });
  }

  // String? selectedDropdownItem;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    final controller = context.watch<ProductProfileControllerProvider>();
    final productOptionsIsEmpty = (controller.isLoading == false)
        ? controller.productData.last.productOptions.isEmpty
        : null;
    final productIsFlashDiscount = (controller.isLoading == false)
        ? controller.productData.last.product.isFlashDiscount
        : null;
    final productIsOffer = (controller.isLoading == false)
        ? controller.productData.last.product.isOffer
        : null;
    final productMainPrice = (controller.isLoading == false)
        ? controller.productData.last.product.price
        : null;
    final productFlashDiscountPrice = (controller.isLoading == false)
        ? controller.productData.last.product.flashDiscountPrice
        : null;
    final productOfferPrice = (controller.isLoading == false)
        ? controller.productData.last.product.offerPrice
        : null;
    final selectedOptionsPrice =
        ((controller.isLoading == false) || controller.selectedOptions.isEmpty)
            ? null
            : controller.selectedOptions.first.price;

    final selectedOptions =
        ((controller.isLoading == false) || controller.selectedOptions.isEmpty)
            ? null
            : controller.selectedOptions.first;
    return WillPopScope(
      // canPop: true,
      onWillPop: () async {
        print('onWillPop');
        controller.removeLastAll();
        print(Get.previousRoute);
        return true;
      },
      child: Scaffold(
        key: _scaffoldKey,
        endDrawer: const MyEndDrawer(),
        body: RefreshIndicator(
            onRefresh: () async {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                getDataOfProduct();
              });
            },
            child: Obx(() => Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            SizedBox(
                              height: 43.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    10.pw,
                                    GestureDetector(
                                      onTap: () {
                                        _scaffoldKey.currentState
                                            ?.openEndDrawer();
                                      },
                                      child: SvgPicture.asset(
                                        AppImages.imageMenu,
                                        height: 20.h,
                                        width: 20.w,
                                      ),
                                    ),
                                    // 10.pw,
                                  ],
                                ),
                                Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Get.to(const CartScreen());
                                      },
                                      child: Badge(
                                          label: Text(
                                              (_controllerNav.countCart.value)
                                                  .toString()),
                                          isLabelVisible: ((_controllerNav
                                                  .countCart.value) !=
                                              0),
                                          child: SvgPicture.asset(
                                            AppImages.imageShop,
                                            height: 30.h,
                                            width: 30.w,
                                          )),
                                    ),
                                    10.pw,
                                    IconButton(
                                        onPressed: () {
                                          Get.back();
                                        },
                                        icon: const Icon(
                                          Icons.arrow_forward_ios,
                                          color: AppColors.kBlackColor,
                                          size: 25,
                                        )),
                                    10.pw,
                                  ],
                                ),
                              ],
                            ),
                            Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                child: Column(children: [
                                  controller.isLoading == true
                                      ? const ShimmerProfile()
                                      : (controller.productData.isNotEmpty ??
                                              false)
                                          ? Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    alignment:
                                                        Alignment.topRight,
                                                    child: Wrap(children: [
                                                      if (widget.isQueenOffer !=
                                                          true) ...{
                                                        GestureDetector(
                                                            onTap: () {
                                                              Get.to(
                                                                  AlKasamScreen());
                                                            },
                                                            child: Text(
                                                              '${tr('sections')} / ',
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    kTheArabicSansLight,
                                                                color: AppColors
                                                                    .kGrayColor,
                                                                fontSize: 16.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                              ),
                                                              maxLines: 2,
                                                              overflow:
                                                                  TextOverflow
                                                                      .visible,
                                                            )),
                                                        ...List.generate(
                                                          controller
                                                                  .productData
                                                                  .last
                                                                  .product
                                                                  ?.category
                                                                  ?.length ??
                                                              0,
                                                          (index) => ((controller
                                                                              .productData
                                                                              .last
                                                                              .product
                                                                              ?.category
                                                                              ?.length ??
                                                                          0) -
                                                                      1) !=
                                                                  index
                                                              ? GestureDetector(
                                                                  onTap: () {
                                                                    final AlkasamController
                                                                        controller0 =
                                                                        Get.put(
                                                                            AlkasamController());
                                                                    controller0.updateCurrentCategoryId(
                                                                        newId: int.parse(
                                                                            "${controller.productData.last.product?.category?[index].id ?? 0}"),
                                                                        getChild:
                                                                            null);
                                                                    Get.to(
                                                                        FliterScreen2(
                                                                      categoryId:
                                                                          int.parse(
                                                                              "${controller.productData.last.product?.category?[index].id ?? 0}"),
                                                                    ));
                                                                  },
                                                                  child: Text(
                                                                      '${controller.productData.last.product?.category?[index].title ?? ''} / ',
                                                                      style:
                                                                          TextStyle(
                                                                        fontFamily:
                                                                            kTheArabicSansLight,
                                                                        color: AppColors
                                                                            .kGrayColor,
                                                                        fontSize:
                                                                            16.sp,
                                                                        fontWeight:
                                                                            FontWeight.w400,
                                                                      )))
                                                              : GestureDetector(
                                                                  onTap: () {
                                                                    final AlkasamController
                                                                        controller0 =
                                                                        Get.put(
                                                                            AlkasamController());
                                                                    controller0.updateCurrentCategoryId(
                                                                        newId: int.parse(
                                                                            "${controller.productData.last.product?.category?[index].id ?? 0}"),
                                                                        getChild:
                                                                            null);
                                                                    Get.to(
                                                                        FliterScreen2(
                                                                      categoryId:
                                                                          int.parse(
                                                                              "${controller.productData.last.product?.category?[index].id ?? 0}"),
                                                                    ));
                                                                  },
                                                                  child: Text(
                                                                    '${controller.productData.last.product?.category?[index].title ?? ''} ',
                                                                    style:
                                                                        TextStyle(
                                                                      fontFamily:
                                                                          kTheArabicSansLight,
                                                                      color: AppColors
                                                                          .kBlackColor,
                                                                      fontSize:
                                                                          16.sp,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w700,
                                                                    ),
                                                                  )),
                                                        ),
                                                      } else ...{
                                                        GestureDetector(
                                                            onTap: () {
                                                              Navigator
                                                                  .pushAndRemoveUntil(
                                                                      context,
                                                                      MaterialPageRoute(
                                                                        builder:
                                                                            (context) =>
                                                                                const MainView(),
                                                                      ),
                                                                      (route) =>
                                                                          false);
                                                            },
                                                            child: Text(
                                                              'الرئسيه / ',
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    kTheArabicSansLight,
                                                                color: AppColors
                                                                    .kGrayColor,
                                                                fontSize: 16.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                              ),
                                                              maxLines: 2,
                                                              overflow:
                                                                  TextOverflow
                                                                      .visible,
                                                            )),
                                                        GestureDetector(
                                                            onTap: () {
                                                              Get.to(
                                                                  const BeautyPharmacyScreen());
                                                            },
                                                            child: Text(
                                                                'العروض',
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      kTheArabicSansLight,
                                                                  color: AppColors
                                                                      .kGrayColor,
                                                                  fontSize:
                                                                      16.sp,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                )))
                                                      }
                                                    ])),
                                                SizedBox(
                                                  height: 43.h,
                                                ),
                                                if (controller.selectedOptions
                                                        .isNotEmpty &&
                                                    controller.selectedOptions
                                                            .first !=
                                                        null &&
                                                    (controller.productData.last
                                                                .productOptions !=
                                                            null &&
                                                        controller
                                                            .productData
                                                            .last
                                                            .productOptions
                                                            .isNotEmpty)) ...{
                                                  CarouselSlider(
                                                      options: CarouselOptions(
                                                        padEnds: false,
                                                        height: 258.48.h,
                                                        enableInfiniteScroll:
                                                            false,
                                                        onPageChanged:
                                                            (index, reason) {
                                                          // controller.update();
                                                          controller
                                                              .changeSliderIndex(
                                                                  index);
                                                        },
                                                      ),
                                                      items: List.generate(
                                                        controller
                                                                .selectedOptions
                                                                .first
                                                                .getCurrentImages()
                                                                .length ??
                                                            0,
                                                        (index) => WidgetZoom(
                                                          heroAnimationTag:
                                                              'tag',
                                                          zoomWidget: CachedNetworkImage(
                                                              imageUrl: Connection.urlOfOptions(
                                                                  image: controller
                                                                          .selectedOptions
                                                                          .first
                                                                          .getCurrentImages()[
                                                                              index]
                                                                          .file ??
                                                                      ''),
                                                              width: 258.48.w,
                                                              height: 258.48.h,
                                                              fit: BoxFit
                                                                  .fitWidth),
                                                        ),
                                                      )),
                                                } else ...{
                                                  CarouselSlider(
                                                      options: CarouselOptions(
                                                        padEnds: false,
                                                        height: 258.48.h,
                                                        enableInfiniteScroll:
                                                            false,
                                                        onPageChanged:
                                                            (index, reason) {
                                                          // controller.update();
                                                          controller
                                                              .changeSliderIndex(
                                                                  index);
                                                        },
                                                      ),
                                                      items: List.generate(
                                                        controller.productData
                                                                .last.product
                                                                ?.getCurrentImages()
                                                                .length ??
                                                            0,
                                                        (index) => WidgetZoom(
                                                          heroAnimationTag:
                                                              'tag',
                                                          zoomWidget: CachedNetworkImage(
                                                              imageUrl: controller
                                                                          .productData
                                                                          .last
                                                                          .product
                                                                          ?.getCurrentImages()[
                                                                      index] ??
                                                                  '',
                                                              width: 258.48.w,
                                                              height: 258.48.h,
                                                              fit: BoxFit
                                                                  .fitWidth),
                                                        ),
                                                      )),
                                                },
                                                SizedBox(
                                                  height: 10.h,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: List.generate(
                                                      controller.productData
                                                              .last.product
                                                              ?.getCurrentImages()
                                                              .length ??
                                                          0,
                                                      (index) => Container(
                                                            margin:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                        6),
                                                            height: controller
                                                                        .selectedSliderIndex ==
                                                                    index
                                                                ? 13
                                                                : 10,
                                                            width: controller
                                                                        .selectedSliderIndex ==
                                                                    index
                                                                ? 13
                                                                : 10,
                                                            decoration: BoxDecoration(
                                                                shape: BoxShape
                                                                    .circle,
                                                                color: controller
                                                                            .selectedSliderIndex ==
                                                                        index
                                                                    ? AppColors
                                                                        .kPinkColor
                                                                    : AppColors
                                                                        .klPinkColor),
                                                          )),
                                                ),
                                                SizedBox(
                                                  height: 10.h,
                                                ),
                                                (controller.isLoading != true)
                                                    ? Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          GestureDetector(
                                                            onTap: () {
                                                              Get.to(
                                                                  BrandDetailScreen(
                                                                brandId: int.parse(
                                                                    "${controller.productData.last.product?.brand?.id ?? 0}"),
                                                              ));
                                                            },
                                                            child: Text(
                                                              controller
                                                                      .productData
                                                                      .last
                                                                      .product
                                                                      ?.brand
                                                                      ?.title ??
                                                                  '',
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      kTheArabicSansBold,
                                                                  fontSize:
                                                                      15.sp,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  color: AppColors
                                                                      .kPrimaryColor),
                                                            ),
                                                          ),
                                                          if (productIsFlashDiscount !=
                                                                  '1' &&
                                                              productIsOffer !=
                                                                  '1' &&
                                                              productOptionsIsEmpty ==
                                                                  true) ...{
                                                            CurrentPriceWithBlack(
                                                              price:
                                                                  '$productMainPrice',
                                                            )
                                                          } else if (productIsFlashDiscount !=
                                                                  '1' &&
                                                              productIsOffer ==
                                                                  '1' &&
                                                              productOptionsIsEmpty ==
                                                                  true) ...{
                                                            if ("$productOfferPrice" !=
                                                                '0.00') ...{
                                                              SizedBox(
                                                                  width: (MediaQuery.of(context)
                                                                              .size
                                                                              .width /
                                                                          2) -
                                                                      40,
                                                                  child: Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      children: [
                                                                        OldPriceWithBlack(
                                                                          price:
                                                                              '$productMainPrice',
                                                                        ),
                                                                        CurrentPriceWithPink(
                                                                          price:
                                                                              '$productOfferPrice',
                                                                        )
                                                                      ]))
                                                            } else ...{
                                                              CurrentPriceWithBlack(
                                                                price:
                                                                    '$productMainPrice',
                                                              )
                                                            }
                                                          } else if (productIsFlashDiscount ==
                                                                  '1' &&
                                                              productOptionsIsEmpty ==
                                                                  true) ...{
                                                            if ("$productOfferPrice" !=
                                                                '0.00') ...{
                                                              SizedBox(
                                                                  width: (MediaQuery.of(context)
                                                                              .size
                                                                              .width /
                                                                          2) -
                                                                      40,
                                                                  child: Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      children: [
                                                                        OldPriceWithBlack(
                                                                          price:
                                                                              '$productMainPrice',
                                                                        ),
                                                                        CurrentPriceWithPink(
                                                                          price:
                                                                              '$productFlashDiscountPrice',
                                                                        )
                                                                      ]))
                                                            } else ...{
                                                              CurrentPriceWithBlack(
                                                                price:
                                                                    '$productMainPrice',
                                                              )
                                                            }
                                                          } else if (productIsFlashDiscount !=
                                                                  '1' &&
                                                              productIsOffer !=
                                                                  '1' &&
                                                              productOptionsIsEmpty !=
                                                                  true) ...{
                                                            if (controller
                                                                        .productData
                                                                        .last
                                                                        .productOptions?[
                                                                            0]
                                                                        .title ==
                                                                    TypeOfOptions
                                                                        .color ||
                                                                controller
                                                                        .productData
                                                                        .last
                                                                        .productOptions?[
                                                                            0]
                                                                        .options
                                                                        .first
                                                                        .isColor ==
                                                                    "1") ...{
                                                              CurrentPriceWithBlack(
                                                                price:
                                                                    '${selectedOptionsPrice ?? productMainPrice}',
                                                              )
                                                            } else ...{
                                                              if (context
                                                                      .watch<
                                                                          ProductProfileControllerProvider>()
                                                                      .selectedOptions
                                                                      .first ==
                                                                  null) ...{
                                                                Text(
                                                                  "${controller.productData.last.productOptions.first.options.first.price ?? ''} ${tr('Del')}-${controller.productData.last.productOptions.first.options.last.price ?? ''} ${tr('Del')}",
                                                                  textAlign:
                                                                      TextAlign
                                                                          .right,
                                                                  style:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        15.16
                                                                            .sp,
                                                                    fontFamily:
                                                                        kTheArabicSansBold,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                    height:
                                                                        0.08,
                                                                  ),
                                                                )
                                                              } else ...{
                                                                CurrentPriceWithBlack(
                                                                  price:
                                                                      '${context.watch<ProductProfileControllerProvider>().selectedOptions.first.price}',
                                                                )
                                                              }
                                                            }
                                                          } else if (productIsFlashDiscount !=
                                                                  '1' &&
                                                              productIsOffer ==
                                                                  '1' &&
                                                              productOptionsIsEmpty !=
                                                                  true) ...{
                                                            if (controller
                                                                    .productData
                                                                    .last
                                                                    .productOptions
                                                                    .first
                                                                    .options
                                                                    .first
                                                                    .offerPrice ==
                                                                controller
                                                                    .productData
                                                                    .last
                                                                    .productOptions
                                                                    .first
                                                                    .options
                                                                    .last
                                                                    .offerPrice) ...{
                                                              if ("$productOfferPrice" !=
                                                                  '0.00') ...{
                                                                SizedBox(
                                                                    width: (MediaQuery.of(context).size.width /
                                                                            2) -
                                                                        40,
                                                                    child: Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceBetween,
                                                                        children: [
                                                                          OldPriceWithBlack(
                                                                            price:
                                                                                '$productMainPrice',
                                                                          ),
                                                                          CurrentPriceWithPink(
                                                                            price:
                                                                                '${selectedOptionsPrice ?? productOfferPrice}',
                                                                          )
                                                                        ]))
                                                              } else ...{
                                                                CurrentPriceWithBlack(
                                                                  price:
                                                                      '${context.watch<ProductProfileControllerProvider>().selectedOptions.first.price}',
                                                                )
                                                              }
                                                            } else ...{
                                                              if (context
                                                                      .watch<
                                                                          ProductProfileControllerProvider>()
                                                                      .selectedOptions
                                                                      .isEmpty ||
                                                                  (context
                                                                          .watch<
                                                                              ProductProfileControllerProvider>()
                                                                          .selectedOptions
                                                                          .first ==
                                                                      null)) ...{
                                                                Text(
                                                                  "${controller.productData.last.productOptions.first.options.first.offerPrice ?? ''} ${tr('Del')}-${controller.productData.last.productOptions.first.options.last.offerPrice ?? ''} ${tr('Del')}",
                                                                  textAlign:
                                                                      TextAlign
                                                                          .right,
                                                                  style:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        15.16
                                                                            .sp,
                                                                    fontFamily:
                                                                        kTheArabicSansBold,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                    // decoration:
                                                                    // TextDecoration
                                                                    //     .lineThrough,
                                                                    height:
                                                                        0.08,
                                                                  ),
                                                                )
                                                              } else ...{
                                                                if ("$productOfferPrice" !=
                                                                    '0.00') ...{
                                                                  SizedBox(
                                                                      width: (MediaQuery.of(context).size.width /
                                                                              2) -
                                                                          40,
                                                                      child: Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.spaceBetween,
                                                                          children: [
                                                                            // OldPriceWithBlack(
                                                                            //   price:
                                                                            //   '${(context.watch<ProductProfileControllerProvider>().selectedOptions.first != null) ? context.watch<ProductProfileControllerProvider>().selectedOptions.first.price : productMainPrice}',
                                                                            // ),
                                                                            // CurrentPriceWithPink(
                                                                            //   price:
                                                                            //   '${(context.watch<ProductProfileControllerProvider>().selectedOptions.first != null) ? context.watch<ProductProfileControllerProvider>().selectedOptions.first.offerPrice : productOfferPrice}',
                                                                            //
                                                                            //   // '${context.watch<ProductProfileControllerProvider>().selectedOptions.first.offerPrice}',
                                                                            // )
                                                                            OldPriceWithBlack(
                                                                              price: '${context.watch<ProductProfileControllerProvider>().selectedOptions.first.price}',
                                                                            ),
                                                                            CurrentPriceWithPink(
                                                                              price: '${context.watch<ProductProfileControllerProvider>().selectedOptions.first.offerPrice}',
                                                                            )
                                                                          ]))
                                                                } else ...{
                                                                  CurrentPriceWithBlack(
                                                                    price:
                                                                        '${context.watch<ProductProfileControllerProvider>().selectedOptions.first.price}',
                                                                  )
                                                                }
                                                              }
                                                            },
                                                          } else if (productIsFlashDiscount ==
                                                                  '1' &&
                                                              productOptionsIsEmpty !=
                                                                  true) ...{
                                                            if ("$productOfferPrice" !=
                                                                    '0.00' ||
                                                                (context
                                                                        .watch<
                                                                            ProductProfileControllerProvider>()
                                                                        .selectedOptions
                                                                        .first ==
                                                                    null)) ...{
                                                              SizedBox(
                                                                  width: (MediaQuery.of(context)
                                                                              .size
                                                                              .width /
                                                                          2) -
                                                                      40,
                                                                  child: Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      children: [
                                                                        OldPriceWithBlack(
                                                                          price:
                                                                              '$productMainPrice',
                                                                        ),
                                                                        CurrentPriceWithPink(
                                                                          price:
                                                                              '${selectedOptionsPrice ?? productFlashDiscountPrice}',
                                                                        )
                                                                      ]))
                                                            } else ...{
                                                              SizedBox(
                                                                  width: (MediaQuery.of(context)
                                                                              .size
                                                                              .width /
                                                                          2) -
                                                                      40,
                                                                  child: Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      children: [
                                                                        OldPriceWithBlack(
                                                                          price:
                                                                              '${context.watch<ProductProfileControllerProvider>().selectedOptions.first.price}',
                                                                        ),
                                                                        CurrentPriceWithPink(
                                                                          price:
                                                                              '${context.watch<ProductProfileControllerProvider>().selectedOptions.first.flashDiscountPrice}',
                                                                        )
                                                                      ]))
                                                              // CurrentPriceWithBlack(
                                                              //   price:
                                                              //       '${context.watch<ProductProfileControllerProvider>().selectedOptions.first.flashDiscountPrice}',
                                                              // )
                                                            }
                                                          }
                                                        ],
                                                      )
                                                    : SizedBox(),
                                                10.ph,
                                                Align(
                                                  alignment: Alignment.topRight,
                                                  child: Text(
                                                    controller.productData.last
                                                            .product?.title ??
                                                        '',
                                                    style: TextStyle(
                                                        fontFamily:
                                                            kTheArabicSansLight,
                                                        fontSize: 15.sp,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        color: AppColors
                                                            .kBlackColor),
                                                  ),
                                                ),
                                              ],
                                            )
                                          : const SizedBox(),
                                  SizedBox(
                                    height: 17.h,
                                  ),
                                  // ///////////container//////////
                                  if (controller.isLoading == false &&
                                      (controller.productData.isNotEmpty ??
                                          false)) ...{
                                    if ((controller.productData.last?.product
                                            ?.isQueena ==
                                        "1")) ...{
                                      Row(
                                        children: [
                                          SvgPicture.asset(
                                            AppImages.pointsQueenaImage,
                                            width: 30.w,
                                          ),
                                          10.pw,
                                          Text(tr('collect')),
                                          if ("${controller.productData.last.product.isOffer}" ==
                                              '1') ...{
                                            Text(
                                              " +${double.parse("${double.parse('${controller.productData.last.product.offerPrice}') / 10}").toString().split('.').first} ",
                                              style: const TextStyle(
                                                  color: AppColors.mainColor,
                                                  fontFamily:
                                                      kTheArabicSansLight),
                                            ),
                                          } else ...{
                                            Text(
                                              " +${double.parse("${double.parse('${controller.productData.last.product.price}') / 10}").toString().split('.').first} ",
                                              style: const TextStyle(
                                                  color: AppColors.mainColor,
                                                  fontFamily:
                                                      kTheArabicSansLight),
                                            ),
                                          },
                                          Text(tr('con_collect')),
                                        ],
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          // if (Get.previousRoute ==
                                          //     '/QuinaprogramScreen') {
                                          //   Navigator.of(context).pop();
                                          // } else {
                                          Get.to(QuinaprogramScreen(
                                            reCreate: true,
                                          ));
                                          // }
                                        },
                                        child: const Row(
                                          children: [
                                            Text(
                                              'برنامج كوينا للولاء',
                                              style: TextStyle(
                                                  fontFamily:
                                                      kTheArabicSansLight),
                                            ),
                                            Text('التفاصيل',
                                                style: TextStyle(
                                                    color: AppColors.mainColor,
                                                    decoration: TextDecoration
                                                        .underline,
                                                    decorationColor:
                                                        AppColors.mainColor,
                                                    fontFamily:
                                                        kTheArabicSansLight)),
                                          ],
                                        ),
                                      )
                                    },
                                  },
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  ((controller.productData.isNotEmpty ??
                                              false) &&
                                          controller.isLoading != true)
                                      ? SizedBox(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: List.generate(
                                                controller
                                                        .productData
                                                        .last
                                                        .productOptions
                                                        ?.length ??
                                                    0,
                                                (index) => Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        if (controller
                                                                    .productData
                                                                    .last
                                                                    .productOptions?[
                                                                        index]
                                                                    .title ==
                                                                TypeOfOptions
                                                                    .color &&
                                                            controller
                                                                    .productData
                                                                    .last
                                                                    .productOptions?[
                                                                        index]
                                                                    .options
                                                                    .first
                                                                    .isColor ==
                                                                "1") ...{
                                                          Wrap(
                                                            spacing: 10,
                                                            runSpacing: 10,
                                                            alignment:
                                                                WrapAlignment
                                                                    .start,
                                                            children:
                                                                List.generate(
                                                                    controller
                                                                            .productData
                                                                            .last
                                                                            .productOptions?[
                                                                                index]
                                                                            .options
                                                                            ?.length ??
                                                                        0,
                                                                    (index2) =>
                                                                        ColorContainer(
                                                                          height:
                                                                              50.h,
                                                                          width:
                                                                              50.w,
                                                                          inStock: ((controller.productData.last.productOptions?[index].options?[index2].stock == null ||
                                                                              controller.productData.last.productOptions?[index].options?[index2].stock == "0" ||
                                                                              num.parse(controller.productData.last.productOptions?[index].options?[index2].stock ?? '0') <= 0)),
                                                                          currentId: controller
                                                                              .productData
                                                                              .last
                                                                              .productOptions?[index]
                                                                              .options?[index2]
                                                                              .id,
                                                                          selectedId: controller.selectedOptions[index] == null
                                                                              ? 0
                                                                              : controller.selectedOptions[index].id ?? 0,
                                                                          color: Color(int.parse(
                                                                              "ff${controller.productData.last.productOptions?[index].options?[index2].color?.toUpperCase().replaceAll('#', '') ?? ''}",
                                                                              radix: 16)),
                                                                          onClick:
                                                                              () {
                                                                            print(controller.productData.last.productOptions?[index].options?[index2].stock);
                                                                            if ((controller.productData.last.productOptions?[index].options?[index2].stock == null ||
                                                                                controller.productData.last.productOptions?[index].options?[index2].stock == "0" ||
                                                                                num.parse(controller.productData.last.productOptions?[index].options?[index2].stock ?? '0') <= 0)) {
                                                                              showDialog(
                                                                                  context: context,
                                                                                  builder: (BuildContext context) {
                                                                                    return CustomAlertDialog(
                                                                                      buttonTwo: false,
                                                                                      dilougText: tr('will_be_avaible_soon'),
                                                                                      buttonOneText: tr('okay'),
                                                                                    );
                                                                                  });
                                                                            } else {
                                                                              controller.updateToSelected(index: index, selected: controller.productData.last.productOptions?[index].options?[index2]);
                                                                            }
                                                                          },
                                                                        )),
                                                          ),
                                                          const SizedBox(
                                                            height: 10,
                                                          ),
                                                          DropdownButtonFormField<
                                                              OptionsModel>(
                                                            // padding: EdgeInsets
                                                            //     .symmetric(
                                                            //         horizontal: 10,
                                                            //         vertical: 0),
                                                            isExpanded: true,
                                                            decoration:
                                                                InputDecoration(
                                                              labelStyle:
                                                                  TextStyle(
                                                                fontFamily:
                                                                    kTheArabicSansLight,
                                                              ),
                                                              contentPadding:
                                                                  EdgeInsets.symmetric(
                                                                      horizontal:
                                                                          10,
                                                                      vertical:
                                                                          0),
                                                              labelText: controller
                                                                  .productData
                                                                  .last
                                                                  .productOptions?[
                                                                      index]
                                                                  .title,
                                                              // filled: true,
                                                              fillColor:
                                                                  Colors.white,
                                                              border:
                                                                  const OutlineInputBorder(
                                                                      borderSide:
                                                                          BorderSide(
                                                                        color: Colors
                                                                            .black,
                                                                      ),
                                                                      borderRadius:
                                                                          BorderRadius
                                                                              .zero),
                                                              focusedBorder:
                                                                  const OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .zero,
                                                                borderSide:
                                                                    BorderSide(
                                                                  color: Colors
                                                                      .black,
                                                                ),
                                                              ),
                                                            ),
                                                            onChanged:
                                                                (selectedItem) {
                                                              if ((selectedItem
                                                                          ?.stock ==
                                                                      null ||
                                                                  selectedItem
                                                                          ?.stock ==
                                                                      "0" ||
                                                                  num.parse(selectedItem
                                                                              ?.stock ??
                                                                          '0') <=
                                                                      0)) {
                                                                showDialog(
                                                                    context:
                                                                        context,
                                                                    builder:
                                                                        (BuildContext
                                                                            context) {
                                                                      return CustomAlertDialog(
                                                                        buttonTwo:
                                                                            false,
                                                                        dilougText:
                                                                            tr('will_be_avaible_soon'),
                                                                        buttonOneText:
                                                                            tr('okay'),
                                                                      );
                                                                    });
                                                              } else {
                                                                print(
                                                                    selectedItem
                                                                        ?.stock);
                                                                controller.updateToSelected(
                                                                    index:
                                                                        index,
                                                                    selected:
                                                                        selectedItem);
                                                              }
                                                            },
                                                            value: controller
                                                                    .selectedOptions[
                                                                index],
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  kTheArabicSansLight,
                                                            ),
                                                            items: controller
                                                                .productData
                                                                .last
                                                                .productOptions?[
                                                                    index]
                                                                .options
                                                                ?.map<
                                                                        DropdownMenuItem<
                                                                            OptionsModel>>(
                                                                    (value) {
                                                              return DropdownMenuItem<
                                                                  OptionsModel>(
                                                                value: value,
                                                                child: Row(
                                                                  children: [
                                                                    Container(
                                                                        width: 20
                                                                            .w,
                                                                        height: 20
                                                                            .h,
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          color: Color(int.parse(
                                                                              "ff${value.color?.toUpperCase().replaceAll('#', '') ?? ''}",
                                                                              radix: 16)),
                                                                          shape:
                                                                              BoxShape.circle,
                                                                        )),
                                                                    // Text('dd'),
                                                                    Padding(
                                                                      padding: EdgeInsets
                                                                          .all(8
                                                                              .r),
                                                                    ),
                                                                    Text(
                                                                        "${value.title} ",
                                                                        style: kHintTextStyle.copyWith(
                                                                            fontWeight:
                                                                                FontWeight.w400,
                                                                            fontSize: 0.8 * 14)),
                                                                    if (value.code !=
                                                                            null &&
                                                                        value.code !=
                                                                            '') ...{
                                                                      Text(
                                                                          "- ${value.code} ",
                                                                          style: kHintTextStyle.copyWith(
                                                                              fontWeight: FontWeight.w400,
                                                                              fontSize: 0.8 * 14)),
                                                                    }
                                                                  ],
                                                                ),
                                                              );
                                                            }).toList(),
                                                          ),
                                                        } else ...{
                                                          Wrap(
                                                            spacing: 10,
                                                            runSpacing: 10,
                                                            alignment:
                                                                WrapAlignment
                                                                    .start,
                                                            children:
                                                                List.generate(
                                                                    controller
                                                                            .productData
                                                                            .last
                                                                            .productOptions?[
                                                                                index]
                                                                            .options
                                                                            ?.length ??
                                                                        0,
                                                                    (index2) =>
                                                                        TextContainer(
                                                                          isText: controller.productData.last.productOptions?[index].options?[index2].isSize == '1'
                                                                              ? true
                                                                              : false,
                                                                          height:
                                                                              50.h,
                                                                          inStock: ((controller.productData.last.productOptions?[index].options?[index2].stock == null ||
                                                                              controller.productData.last.productOptions?[index].options?[index2].stock == "0" ||
                                                                              num.parse(controller.productData.last.productOptions?[index].options?[index2].stock ?? '0') <= 0)),
                                                                          width:
                                                                              50.w,
                                                                          currentId: controller
                                                                              .productData
                                                                              .last
                                                                              .productOptions?[index]
                                                                              .options?[index2]
                                                                              .id,
                                                                          selectedId: controller.selectedOptions[index] == null
                                                                              ? 0
                                                                              : controller.selectedOptions[index].id ?? 0,
                                                                          text: controller.productData.last.productOptions?[index].options?[index2].isSize == '1'
                                                                              ? (controller.productData.last.productOptions?[index].options?[index2].size)
                                                                              : (controller.productData.last.productOptions?[index].options?[index2].mainImage.file),
                                                                          onClick:
                                                                              () {
                                                                            if ((controller.productData.last.productOptions?[index].options?[index2].stock == null ||
                                                                                controller.productData.last.productOptions?[index].options?[index2].stock == "0" ||
                                                                                num.parse(controller.productData.last.productOptions?[index].options?[index2].stock ?? '0') <= 0)) {
                                                                              showDialog(
                                                                                  context: context,
                                                                                  builder: (BuildContext context) {
                                                                                    return CustomAlertDialog(
                                                                                      buttonTwo: false,
                                                                                      dilougText: tr('will_be_avaible_soon'),
                                                                                      buttonOneText: tr('okay'),
                                                                                    );
                                                                                  });
                                                                            } else {
                                                                              print(controller.productData.last.productOptions?[index].options?[index2].stock);
                                                                              controller.updateToSelected(index: index, selected: controller.productData.last.productOptions?[index].options?[index2]);
                                                                            }
                                                                          },
                                                                        )),
                                                          ),
                                                          const SizedBox(
                                                            height: 10,
                                                          ),
                                                          DropdownButtonFormField<
                                                              OptionsModel>(
                                                            isExpanded: true,
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  kTheArabicSansLight,
                                                            ),
                                                            decoration:
                                                                InputDecoration(
                                                              contentPadding:
                                                                  EdgeInsets.symmetric(
                                                                      horizontal:
                                                                          10,
                                                                      vertical:
                                                                          0),
                                                              labelText: controller
                                                                  .productData
                                                                  .last
                                                                  .productOptions?[
                                                                      index]
                                                                  .title,
                                                              filled: true,
                                                              fillColor:
                                                                  Colors.white,
                                                              border:
                                                                  const OutlineInputBorder(
                                                                      borderSide:
                                                                          BorderSide(
                                                                        color: Colors
                                                                            .black,
                                                                      ),
                                                                      borderRadius:
                                                                          BorderRadius
                                                                              .zero),
                                                              focusedBorder:
                                                                  const OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .zero,
                                                                borderSide:
                                                                    BorderSide(
                                                                  color: Colors
                                                                      .black,
                                                                ),
                                                              ),
                                                            ),
                                                            onChanged:
                                                                (selectedItem) {
                                                              log('selectedItem:${selectedItem?.title}');
                                                              log('selectedItem:${selectedItem?.id}');
                                                              if ((selectedItem
                                                                          ?.stock ==
                                                                      null ||
                                                                  selectedItem
                                                                          ?.stock ==
                                                                      "0" ||
                                                                  num.parse(selectedItem
                                                                              ?.stock ??
                                                                          '0') <=
                                                                      0)) {
                                                                showDialog(
                                                                    context:
                                                                        context,
                                                                    builder:
                                                                        (BuildContext
                                                                            context) {
                                                                      return CustomAlertDialog(
                                                                        buttonTwo:
                                                                            false,
                                                                        dilougText:
                                                                            tr('will_be_avaible_soon'),
                                                                        buttonOneText:
                                                                            tr('okay'),
                                                                      );
                                                                    });
                                                              } else {
                                                                controller.updateToSelected(
                                                                    index:
                                                                        index,
                                                                    selected:
                                                                        selectedItem);
                                                              }
                                                              // print(selectedItem
                                                              //     ?.stock);
                                                            },
                                                            value: controller
                                                                    .selectedOptions[
                                                                index],
                                                            items: controller
                                                                .productData
                                                                .last
                                                                ?.productOptions?[
                                                                    index]
                                                                ?.options
                                                                ?.map<
                                                                        DropdownMenuItem<
                                                                            OptionsModel>>(
                                                                    (OptionsModel
                                                                        value) {
                                                              return DropdownMenuItem<
                                                                  OptionsModel>(
                                                                value: value,
                                                                child: Row(
                                                                  children: [
                                                                    Container(
                                                                        width: 20
                                                                            .w,
                                                                        height: 20
                                                                            .h,
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          shape:
                                                                              BoxShape.circle,
                                                                          image:
                                                                              DecorationImage(image: CachedNetworkImageProvider(Connection.urlOfOptions(image: value.mainImage?.file ?? ''))),
                                                                        )),
                                                                    Padding(
                                                                      padding: EdgeInsets
                                                                          .all(8
                                                                              .r),
                                                                    ),
                                                                    Text(
                                                                        "${value.title}",
                                                                        style: kHintTextStyle.copyWith(
                                                                            fontWeight:
                                                                                FontWeight.w400,
                                                                            fontSize: 0.8 * 14)),
                                                                    if (value.code !=
                                                                            null &&
                                                                        value.code !=
                                                                            '') ...{
                                                                      Text(
                                                                          "- ${value.code} ",
                                                                          style: kHintTextStyle.copyWith(
                                                                              fontWeight: FontWeight.w400,
                                                                              fontSize: 0.8 * 14)),
                                                                    }
                                                                  ],
                                                                ),
                                                              );
                                                            }).toList(),
                                                          ),
                                                        }
                                                      ],
                                                    )),
                                          ),
                                        )
                                      : const SizedBox(),
                                  SizedBox(
                                    height: 17.h,
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    child: Row(
                                      // alignment: WrapAlignment.start,
                                      // spacing: 10.w,
                                      children: [
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            SizedBox(
                                              width: 57.w,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    padding:
                                                        const EdgeInsets.all(5),
                                                    width: 50.w,
                                                    height: 50.h,
                                                    decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        border: Border.all(
                                                            color: AppColors
                                                                .kCDGColor2
                                                                .withOpacity(
                                                                    .1))),
                                                    child: SvgPicture.asset(
                                                        AppImages.imageNewItem),
                                                  ),
                                                  Text(
                                                    tr('newْnusedProduct'),
                                                    style: const TextStyle(
                                                        fontSize: 10,
                                                        fontFamily:
                                                            kTheArabicSansLight),
                                                    textAlign: TextAlign.center,
                                                  )
                                                ],
                                              ),
                                            ),
                                            10.pw,
                                            SizedBox(
                                              width: 60.w,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    padding:
                                                        const EdgeInsets.all(5),
                                                    width: 50.w,
                                                    height: 50.h,
                                                    decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        border: Border.all(
                                                            color: AppColors
                                                                .kCDGColor2
                                                                .withOpacity(
                                                                    .1))),
                                                    child: SvgPicture.asset(
                                                        AppImages
                                                            .imageOriginalItem),
                                                  ),
                                                  Text(
                                                    tr('original'),
                                                    style: TextStyle(
                                                        fontSize: 10,
                                                        fontFamily:
                                                            kTheArabicSansLight),
                                                    textAlign: TextAlign.center,
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        Expanded(
                                          child: (controller
                                                      .productData.isNotEmpty ??
                                                  false)
                                              ? ("${controller.productData.last.is_flash_discount.status}" ==
                                                      "true")
                                                  ? Column(
                                                      children: [
                                                        Text(
                                                          'اشتري سعر التخفيض قبل انتهاء الوقت ${DateTime.parse(controller.productData.last.is_flash_discount.endAt ?? '')}',
                                                          style:
                                                              kTheSansTextStyleGray
                                                                  .copyWith(
                                                                      fontSize:
                                                                          0.6 *
                                                                              18),
                                                        ),
                                                        CountdownTimer(
                                                          endTime: DateTime.parse(controller
                                                                      .productData
                                                                      .last
                                                                      .is_flash_discount
                                                                      .endAt ??
                                                                  '')
                                                              .millisecondsSinceEpoch,
                                                          widgetBuilder: (context,
                                                              currentRemainingTime) {
                                                            return Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .end,
                                                              children: [
                                                                Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Text(
                                                                      'ثانيه:',
                                                                      style: timerTextStyle.copyWith(
                                                                          fontSize:
                                                                              0.6 * 14),
                                                                    ),
                                                                    Text(
                                                                      (currentRemainingTime?.sec).toString().toString().split('').length >
                                                                              1
                                                                          ? "${(currentRemainingTime?.sec)}"
                                                                          : "0${(currentRemainingTime?.sec)}" ??
                                                                              '00',
                                                                      style: timerTextStyle.copyWith(
                                                                          fontSize:
                                                                              3 * 14),
                                                                    ),
                                                                  ],
                                                                ),
                                                                Column(
                                                                  children: [
                                                                    const Text(
                                                                      ':',
                                                                      style:
                                                                          timerTextStyle,
                                                                    ),
                                                                    10.ph,
                                                                  ],
                                                                ),
                                                                Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Text(
                                                                      'دقيقه:',
                                                                      style: timerTextStyle.copyWith(
                                                                          fontSize:
                                                                              0.6 * 14),
                                                                    ),
                                                                    Text(
                                                                      (currentRemainingTime?.min).toString().split('').length >
                                                                              1
                                                                          ? "${currentRemainingTime?.min}"
                                                                          : "0${currentRemainingTime?.min}" ??
                                                                              '00',
                                                                      style: timerTextStyle.copyWith(
                                                                          fontSize:
                                                                              3 * 14),
                                                                    ),
                                                                  ],
                                                                ),
                                                                Column(
                                                                  children: [
                                                                    const Text(
                                                                      ':',
                                                                      style:
                                                                          timerTextStyle,
                                                                    ),
                                                                    10.ph,
                                                                  ],
                                                                ),
                                                                Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Text(
                                                                      'ساعه:',
                                                                      style: timerTextStyle.copyWith(
                                                                          fontSize:
                                                                              0.6 * 14),
                                                                    ),
                                                                    Text(
                                                                      "${int.parse("${(currentRemainingTime?.hours)}") + (DateTime(int.parse((controller.productData.last.is_flash_discount.endAt ?? '').toString().split(" ").first.toString().split('-').first), int.parse((controller.productData.last.is_flash_discount.endAt ?? '').toString().split(" ").first.toString().split('-')[1]), int.parse((controller.productData.last.is_flash_discount.endAt ?? '').toString().split(" ").first.toString().split('-').last)).difference(DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day + 1)).inHours) ?? '00'}".split('').length >
                                                                              1
                                                                          ? "${int.parse("${(currentRemainingTime?.hours)}") + (DateTime(int.parse((controller.productData.last.is_flash_discount.endAt ?? '').toString().split(" ").first.toString().split('-').first), int.parse((controller.productData.last.is_flash_discount.endAt ?? '').toString().split(" ").first.toString().split('-')[1]), int.parse((controller.productData.last.is_flash_discount.endAt ?? '').toString().split(" ").first.toString().split('-').last)).difference(DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day + 1)).inHours) ?? '00'}"
                                                                          : "0${"${int.parse("${(currentRemainingTime?.hours)}") + (DateTime(int.parse((controller.productData.last.is_flash_discount.endAt ?? '').toString().split(" ").first.toString().split('-').first), int.parse((controller.productData.last.is_flash_discount.endAt ?? '').toString().split(" ").first.toString().split('-')[1]), int.parse((controller.productData.last.is_flash_discount.endAt ?? '').toString().split(" ").first.toString().split('-').last)).difference(DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day + 1)).inHours) ?? '00'}"}",
                                                                      style: timerTextStyle.copyWith(
                                                                          fontSize:
                                                                              3 * 14),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ],
                                                            );
                                                          },
                                                          onEnd: () {
                                                            print(
                                                                'Countdown ended');
                                                            // You can do something here when the countdown ends
                                                          },
                                                        ),
                                                      ],
                                                    )
                                                  : SizedBox()
                                              : SizedBox(),
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 17.h,
                                  ),
                                  DetailsStatic(
                                    title: tr('Free_delivery_service'),
                                    body: tr('Free_delivery_service2'),
                                    icon: AppImages.imageFreeDelivery,
                                  ),
                                  DetailsStatic(
                                    title: tr('Prompt_same_day_delivery'),
                                    body: tr('Prompt_same_day_delivery2'),
                                    icon: AppImages.imageDelivery,
                                  ),
                                  DetailsStatic(
                                    title: tr(
                                        'Free_gifts_and_samples_with_your_order'),
                                    body: tr(
                                        'Free_gifts_and_samples_with_your_order2'),
                                    icon: AppImages.imageGift,
                                  ),
                                  DetailsStatic(
                                      title: tr('customers_service'),
                                      body: tr('customers_service2'),
                                      icon: AppImages.imageArtboard,
                                      isPhone: true),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  TabBar(
                                    tabs: [
                                      Tab(
                                        icon: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            SvgPicture.asset(
                                                AppImages.imageDetails),
                                            SizedBox(
                                              width: 10.w,
                                            ),
                                            Text(
                                              tr('details_product'),
                                              style: TextStyle(
                                                  fontFamily:
                                                      kTheArabicSansLight,
                                                  fontSize: 16.sp,
                                                  fontWeight: FontWeight.w400,
                                                  color: AppColors.kBlackColor),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Tab(
                                        icon: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            SvgPicture.asset(
                                                AppImages.imageRate),
                                            SizedBox(
                                              width: 10.w,
                                            ),
                                            Text(
                                              tr('rate'),
                                              style: TextStyle(
                                                  fontFamily:
                                                      kTheArabicSansLight,
                                                  fontSize: 16.sp,
                                                  fontWeight: FontWeight.w400,
                                                  color: AppColors.kBlackColor),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                    controller: tabsController,
                                    indicatorColor: AppColors.kPrimaryColor,
                                    onTap: (x) {
                                      setState(() {
                                        indexTap = x;
                                      });
                                    },
                                  ),
                                  // Text(
                                  //     '${controller.index}, ${tabsController.index}'),

                                  if (controller.productData.isNotEmpty) ...{
                                    indexTap == 0
                                        ? TabScreenOne()
                                        : TabScreenTwo(),
                                  },
                                  //////////////////////////////////
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  Divider(
                                    thickness: 1.w,
                                    color: AppColors.kTextGrayColor,
                                  ),
                                  (controller.productData.isNotEmpty ?? false)
                                      ? Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              if (controller.productData.last
                                                          .completeYourOutfit !=
                                                      null &&
                                                  controller
                                                      .productData
                                                      .last
                                                      .completeYourOutfit
                                                      .isNotEmpty) ...{
                                                Text(
                                                  'أكملي إطلالتك...',
                                                  style: TextStyle(
                                                      fontFamily:
                                                          kTheArabicSansBold,
                                                      fontSize: 16.sp,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color:
                                                          AppColors.mainColor),
                                                  textAlign: TextAlign.start,
                                                ),
                                                10.ph,
                                                HtmlWidget(
                                                  "${controller.productData.last.product.completeYourOutfitDescription ?? ''}",
                                                  textStyle: TextStyle(
                                                      fontFamily:
                                                          kTheArabicSansLight),
                                                ),
                                                10.ph,
                                                SizedBox(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  height: 200.h,
                                                  child: CarouselSlider(
                                                    options: CarouselOptions(
                                                      viewportFraction: 1.0,
                                                      // Set to 1.0 for full width current page
                                                      // aspectRatio: 1.3,
                                                      autoPlay: true,
                                                      onPageChanged:
                                                          (index, reason) {
                                                        setState(() {
                                                          currentIndex = index;
                                                        });
                                                        log("currentIndex:$currentIndex");
                                                        // _controller.updateCurrentSlider(
                                                        //     newSlider: index);
                                                      },
                                                      enlargeCenterPage:
                                                          true, // Make the current page full width
                                                    ),
                                                    items: List.generate(
                                                        controller
                                                                .productData
                                                                .last
                                                                .completeYourOutfit
                                                                .length ??
                                                            0,
                                                        (index) => Container(
                                                              decoration: BoxDecoration(
                                                                  border: Border.all(
                                                                      color: Colors
                                                                          .grey
                                                                          .shade500)),
                                                              child:
                                                                  CustomCardWidget2(
                                                                hideTage: true,
                                                                imageUrl: Connection.urlOfProducts(
                                                                    image: controller
                                                                            .productData
                                                                            .last
                                                                            .completeYourOutfit[index]
                                                                            .mainImage ??
                                                                        ''),
                                                                newArrival: controller
                                                                        .productData
                                                                        .last
                                                                        .completeYourOutfit[index] ??
                                                                    SalesProductsModel(),
                                                                favorite: controller
                                                                        .productData
                                                                        .last
                                                                        .completeYourOutfit[
                                                                            index]
                                                                        .wishlist
                                                                        ?.isNotEmpty ??
                                                                    false,
                                                              ),
                                                            )),
                                                    disableGesture: true,
                                                  ),
                                                ),
                                                10.ph,
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: List.generate(
                                                      controller
                                                              .productData
                                                              .last
                                                              .completeYourOutfit
                                                              .length ??
                                                          0,
                                                      (index) => Container(
                                                            margin:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                        6),
                                                            height:
                                                                currentIndex ==
                                                                        index
                                                                    ? 13
                                                                    : 10,
                                                            width:
                                                                currentIndex ==
                                                                        index
                                                                    ? 13
                                                                    : 10,
                                                            decoration: BoxDecoration(
                                                                shape: BoxShape
                                                                    .circle,
                                                                color: currentIndex ==
                                                                        index
                                                                    ? AppColors
                                                                        .kPinkColor
                                                                    : AppColors
                                                                        .klPinkColor),
                                                          )),
                                                )
                                              }
                                            ],
                                          ),
                                        )
                                      : SizedBox(),
                                  SizedBox(
                                    height: 27.h,
                                  ),
                                  (controller.productData.isNotEmpty ?? false)
                                      ? GestureDetector(
                                          onTap: () {
                                            List text = controller
                                                .productData
                                                .last
                                                .product_banner
                                                .bannerUrlLink
                                                .toString()
                                                .split('/');
                                            print('text:$text');
                                            // if (text[1] == LinkTypes.category) {
                                            AlkasamController controller000 =
                                                Get.put(AlkasamController());
                                            controller000
                                                .updateCurrentCategoryId(
                                                    newId:
                                                        int.parse("${text[2]}"),
                                                    getChild: null,
                                                    subId: int.parse(
                                                        "${text.last}"));
                                            Get.to(FliterScreen2(
                                              categoryId:
                                                  int.parse(text[2].toString()),
                                            ));
                                            // }
                                          },
                                          child: CachedNetworkImage(
                                            imageUrl: Connection.urlOfStorage(
                                                image: controller
                                                        .productData
                                                        .last
                                                        .product_banner
                                                        ?.file ??
                                                    ''),
                                          ),
                                        )
                                      : const SizedBox(),
                                  SizedBox(
                                    height: 32.h,
                                  ),
                                ])),
                            if (widget.isQueenOffer != true) ...{
                              controller.isLoading == true
                                  ? const Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        ShimmerText(),
                                        ShimmerNewItems(),
                                      ],
                                    )
                                  : Column(
                                      children: [
                                        (controller.productData.isNotEmpty ==
                                                true)
                                            ? Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 15),
                                                    child: Text(
                                                      tr('related_product'),
                                                      style: TextStyle(
                                                          fontFamily:
                                                              kTheArabicSansLight,
                                                          fontSize: 17.sp,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          color: AppColors
                                                              .kPrimaryColor),
                                                    ),
                                                  ),
                                                  if ((controller.productData
                                                              .isNotEmpty ??
                                                          false) &&
                                                      (controller
                                                                  .productData
                                                                  .last
                                                                  .p
                                                                  ?.length ??
                                                              0) <=
                                                          2) ...{
                                                    Row(
                                                        children: List.generate(
                                                            ((controller
                                                                            .productData
                                                                            .last
                                                                            .p
                                                                            ?.length ??
                                                                        0) /
                                                                    2)
                                                                .roundToDouble()
                                                                .toInt(),
                                                            (index) {
                                                      return Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          CustomCardWidget(
                                                            isDiscount:
                                                                controller
                                                                    .productData
                                                                    .last
                                                                    .p?[0]
                                                                    .isOffer,
                                                            // width: (MediaQuery.of(context).size.width / 2) - 40,
                                                            imageUrl: Connection.urlOfProducts(
                                                                image: controller
                                                                        .productData
                                                                        .last
                                                                        .p?[0]
                                                                        .mainImage ??
                                                                    ''),
                                                            newArrival: controller
                                                                    .productData
                                                                    .last
                                                                    .p?[0] ??
                                                                SalesProductsModel(),
                                                            favorite: controller
                                                                    .productData
                                                                    .last
                                                                    .p?[0]
                                                                    .wishlist
                                                                    ?.isNotEmpty ??
                                                                false,
                                                          ),
                                                          if ((controller
                                                                      .productData
                                                                      .last
                                                                      .p
                                                                      ?.length ??
                                                                  0) ==
                                                              2) ...{
                                                            CustomCardWidget(
                                                              // width: (MediaQuery.of(context).size.width / 2) - 40,
                                                              imageUrl: Connection.urlOfProducts(
                                                                  image: controller
                                                                          .productData
                                                                          .last
                                                                          .p?[1]
                                                                          .mainImage ??
                                                                      ''),
                                                              isDiscount:
                                                                  controller
                                                                      .productData
                                                                      .last
                                                                      .p?[1]
                                                                      .isOffer,
                                                              newArrival: controller
                                                                      .productData
                                                                      .last
                                                                      .p?[1] ??
                                                                  SalesProductsModel(),
                                                              favorite: controller
                                                                      .productData
                                                                      .last
                                                                      .p?[1]
                                                                      .wishlist
                                                                      ?.isNotEmpty ??
                                                                  false,
                                                            )
                                                          } else ...{
                                                            const SizedBox()
                                                          }
                                                        ],
                                                      );
                                                    }))
                                                  } else ...{
                                                    (controller.productData
                                                                .isNotEmpty ??
                                                            false)
                                                        ? CarouselSlider(
                                                            options:
                                                                CarouselOptions(
                                                              viewportFraction:
                                                                  1.0,
                                                              // Set to 1.0 for full width current page
                                                              aspectRatio: 1.0,
                                                              autoPlay: (controller
                                                                              .productData
                                                                              .last
                                                                              .p
                                                                              ?.length ??
                                                                          0) >
                                                                      2
                                                                  ? true
                                                                  : false,
                                                              enlargeCenterPage:
                                                                  true, // Make the current page full width
                                                            ),
                                                            items: List.generate(
                                                                ((controller.productData.last.p?.length ??
                                                                            0) /
                                                                        2)
                                                                    .roundToDouble()
                                                                    .toInt(),
                                                                (index) {
                                                              int value =
                                                                  index * 2;
                                                              return Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  CustomCardWidget(
                                                                    // width: (MediaQuery.of(context).size.width / 2) - 40,
                                                                    imageUrl: Connection.urlOfProducts(
                                                                        image: controller.productData.last.p?[value].mainImage ??
                                                                            ''),

                                                                    isDiscount: controller
                                                                        .productData
                                                                        .last
                                                                        .p?[value]
                                                                        .isOffer,
                                                                    newArrival: controller
                                                                            .productData
                                                                            .last
                                                                            .p?[value] ??
                                                                        SalesProductsModel(),
                                                                    favorite: controller
                                                                            .productData
                                                                            .last
                                                                            .p?[value]
                                                                            .wishlist
                                                                            ?.isNotEmpty ??
                                                                        false,
                                                                  ),
                                                                  if ((controller
                                                                              .productData
                                                                              .last
                                                                              .p
                                                                              ?.length ??
                                                                          0) >
                                                                      value +
                                                                          1) ...{
                                                                    CustomCardWidget(
                                                                      // width: (MediaQuery.of(context).size.width / 2) - 40,
                                                                      imageUrl: Connection.urlOfProducts(
                                                                          image:
                                                                              controller.productData.last.p?[value + 1].mainImage ?? ''),

                                                                      isDiscount: controller
                                                                          .productData
                                                                          .last
                                                                          .p?[value +
                                                                              1]
                                                                          .isOffer,
                                                                      newArrival: controller
                                                                              .productData
                                                                              .last
                                                                              .p?[value + 1] ??
                                                                          SalesProductsModel(),
                                                                      favorite: controller
                                                                              .productData
                                                                              .last
                                                                              .p?[value + 1]
                                                                              .wishlist
                                                                              ?.isNotEmpty ??
                                                                          false,
                                                                    )
                                                                  } else ...{
                                                                    const SizedBox()
                                                                  }
                                                                ],
                                                              );
                                                            }))
                                                        : const SizedBox()
                                                  }
                                                ],
                                              )
                                            : const SizedBox(),
                                        (controller.productData.isNotEmpty ==
                                                    true) &&
                                                controller.productData.last
                                                        ?.discover_brand !=
                                                    null
                                            ? Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              right: 15),
                                                      child: Text(
                                                        'إكتشفي هذه الماركة ... ${controller.productData.last?.product?.brand?.titleAr ?? ''}',
                                                        style: TextStyle(
                                                          fontFamily:
                                                              kTheArabicSansBold,
                                                          color: AppColors
                                                              .mainColor,
                                                          fontSize: 16.sp,
                                                          fontWeight:
                                                              FontWeight.w200,
                                                        ),
                                                      )),
                                                  15.ph,
                                                  controller.productData.last
                                                                  ?.discover_brand !=
                                                              null &&
                                                          controller
                                                                  .productData
                                                                  .last
                                                                  ?.discover_brand
                                                                  .mobileImage !=
                                                              null &&
                                                          controller
                                                                  .productData
                                                                  .last
                                                                  ?.discover_brand
                                                                  .mobileImage
                                                                  .file !=
                                                              null
                                                      ? CachedNetworkImage(
                                                          imageUrl: Connection.urlOfBrands3(
                                                              image: controller
                                                                      .productData
                                                                      .last
                                                                      ?.discover_brand
                                                                      .mobileImage
                                                                      .file ??
                                                                  ''))
                                                      : SizedBox(),
                                                  15.ph,
                                                  Container(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 15),
                                                      child: Column(children: [
                                                        Text(
                                                          controller
                                                                  .productData
                                                                  .last
                                                                  ?.discover_brand
                                                                  ?.description ??
                                                              '',
                                                          style: TextStyle(
                                                            fontFamily:
                                                                kTheArabicSansLight,
                                                            color: AppColors
                                                                .kGrayColor,
                                                            fontSize: 16.sp,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                        15.ph,
                                                        Center(
                                                          child:
                                                              GestureDetector(
                                                            onTap: () {
                                                              Get.to(
                                                                  BrandDetailScreen(
                                                                brandId: int.parse(
                                                                    "${controller.productData.last?.product?.brand?.id ?? 0}"),
                                                              ));
                                                            },
                                                            child: Container(
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                      vertical:
                                                                          13),
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width /
                                                                  2,
                                                              decoration:
                                                                  ShapeDecoration(
                                                                color: AppColors
                                                                    .kPrimaryColor,
                                                                shape:
                                                                    RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              5),
                                                                ),
                                                              ),
                                                              child: Center(
                                                                child: Text(
                                                                    'عرض التفاصيل و كل المنتجات',
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            15.11
                                                                                .sp,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w700,
                                                                        color: AppColors
                                                                            .kWhiteColor,
                                                                        fontFamily:
                                                                            kTheArabicSansLight)),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ])),
                                                  20.ph,
                                                ],
                                              )
                                            : const SizedBox(),
                                        (controller.productData.isNotEmpty ==
                                                    true) &&
                                                (controller
                                                            .productData
                                                            .last
                                                            .sameBrandProducts
                                                            ?.length ??
                                                        0) >
                                                    0
                                            ? Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 15),
                                                    child: Text(
                                                      tr('same_brand'),
                                                      style: TextStyle(
                                                          fontFamily:
                                                              kTheArabicSansLight,
                                                          fontSize: 17.sp,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          color: AppColors
                                                              .kPrimaryColor),
                                                    ),
                                                  ),
                                                  if ((controller
                                                                  .productData
                                                                  .last
                                                                  .sameBrandProducts
                                                                  ?.length ??
                                                              0) <=
                                                          2 &&
                                                      (controller.productData
                                                              .isNotEmpty ??
                                                          false)) ...{
                                                    Row(
                                                      children: List.generate(
                                                          ((controller
                                                                          .productData
                                                                          .last
                                                                          .sameBrandProducts
                                                                          ?.length ??
                                                                      0) /
                                                                  2)
                                                              .roundToDouble()
                                                              .toInt(),
                                                          (index) {
                                                        return Row(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            CustomCardWidget(
                                                              // width: (MediaQuery.of(context).size.width / 2) - 40,
                                                              imageUrl: Connection.urlOfProducts(
                                                                  image: controller
                                                                          .productData
                                                                          .last
                                                                          .sameBrandProducts?[
                                                                              0]
                                                                          .mainImage ??
                                                                      ''),

                                                              isDiscount: controller
                                                                  .productData
                                                                  .last
                                                                  .sameBrandProducts?[
                                                                      0]
                                                                  .isOffer,
                                                              newArrival: controller
                                                                      .productData
                                                                      .last
                                                                      .sameBrandProducts?[0] ??
                                                                  SalesProductsModel(),
                                                              favorite: controller
                                                                      .productData
                                                                      .last
                                                                      .sameBrandProducts?[
                                                                          0]
                                                                      .wishlist
                                                                      ?.isNotEmpty ??
                                                                  false,
                                                            ),
                                                            if ((controller
                                                                        .productData
                                                                        .last
                                                                        .sameBrandProducts
                                                                        ?.length ??
                                                                    0) ==
                                                                2) ...{
                                                              CustomCardWidget(
                                                                // width: (MediaQuery.of(context).size.width / 2) - 40,
                                                                imageUrl: Connection.urlOfProducts(
                                                                    image: controller
                                                                            .productData
                                                                            .last
                                                                            .sameBrandProducts?[1]
                                                                            .mainImage ??
                                                                        ''),

                                                                isDiscount: controller
                                                                    .productData
                                                                    .last
                                                                    .sameBrandProducts?[
                                                                        1]
                                                                    .isOffer,
                                                                newArrival: controller
                                                                        .productData
                                                                        .last
                                                                        .sameBrandProducts?[1] ??
                                                                    SalesProductsModel(),
                                                                favorite: controller
                                                                        .productData
                                                                        .last
                                                                        .sameBrandProducts?[
                                                                            1]
                                                                        .wishlist
                                                                        ?.isNotEmpty ??
                                                                    false,
                                                              )
                                                            }
                                                          ],
                                                        );
                                                      }),
                                                    )
                                                  } else ...{
                                                    (controller.productData
                                                                .isNotEmpty ??
                                                            false)
                                                        ? CarouselSlider(
                                                            options:
                                                                CarouselOptions(
                                                              viewportFraction:
                                                                  1.0,
                                                              // Set to 1.0 for full width current page
                                                              aspectRatio: 1.0,
                                                              autoPlay: (controller
                                                                              .productData
                                                                              .last
                                                                              .sameBrandProducts
                                                                              ?.length ??
                                                                          0) >
                                                                      2
                                                                  ? true
                                                                  : false,
                                                              enlargeCenterPage:
                                                                  true, // Make the current page full width
                                                            ),
                                                            items: List.generate(
                                                                ((controller.productData.last.sameBrandProducts?.length ??
                                                                            0) /
                                                                        2)
                                                                    .roundToDouble()
                                                                    .toInt(),
                                                                (index) {
                                                              int value =
                                                                  index * 2;
                                                              return Row(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .min,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  CustomCardWidget(
                                                                    // width: (MediaQuery.of(context).size.width / 2) - 40,
                                                                    imageUrl: Connection.urlOfProducts(
                                                                        image: controller.productData.last.sameBrandProducts?[value].mainImage ??
                                                                            ''),

                                                                    isDiscount: controller
                                                                        .productData
                                                                        .last
                                                                        .sameBrandProducts?[
                                                                            value]
                                                                        .isOffer,
                                                                    newArrival: controller
                                                                            .productData
                                                                            .last
                                                                            .sameBrandProducts?[value] ??
                                                                        SalesProductsModel(),
                                                                    favorite: controller
                                                                            .productData
                                                                            .last
                                                                            .sameBrandProducts?[value]
                                                                            .wishlist
                                                                            ?.isNotEmpty ??
                                                                        false,
                                                                  ),
                                                                  if ((controller
                                                                              .productData
                                                                              .last
                                                                              .sameBrandProducts
                                                                              ?.length ??
                                                                          0) >
                                                                      value +
                                                                          1) ...{
                                                                    CustomCardWidget(
                                                                      // width: (MediaQuery.of(context).size.width / 2) - 40,
                                                                      imageUrl: Connection.urlOfProducts(
                                                                          image:
                                                                              controller.productData.last.sameBrandProducts?[value + 1].mainImage ?? ''),
                                                                      newArrival: controller
                                                                              .productData
                                                                              .last
                                                                              .sameBrandProducts?[value + 1] ??
                                                                          SalesProductsModel(),

                                                                      isDiscount: controller
                                                                          .productData
                                                                          .last
                                                                          .sameBrandProducts?[value +
                                                                              1]
                                                                          .isOffer,
                                                                      favorite: controller
                                                                              .productData
                                                                              .last
                                                                              .sameBrandProducts?[value + 1]
                                                                              .wishlist
                                                                              ?.isNotEmpty ??
                                                                          false,
                                                                    )
                                                                  } else ...{
                                                                    CustomCardWidget(
                                                                      // width: (MediaQuery.of(context).size.width / 2) - 40,
                                                                      imageUrl: Connection.urlOfProducts(
                                                                          image:
                                                                              controller.productData.last.sameBrandProducts?[0].mainImage ?? ''),
                                                                      newArrival: controller
                                                                              .productData
                                                                              .last
                                                                              .sameBrandProducts?[0] ??
                                                                          SalesProductsModel(),

                                                                      isDiscount: controller
                                                                          .productData
                                                                          .last
                                                                          .sameBrandProducts?[
                                                                              0]
                                                                          .isOffer,
                                                                      favorite: controller
                                                                              .productData
                                                                              .last
                                                                              .sameBrandProducts?[0]
                                                                              .wishlist
                                                                              ?.isNotEmpty ??
                                                                          false,
                                                                    )
                                                                  }
                                                                ],
                                                              );
                                                            }))
                                                        : const SizedBox()
                                                  }
                                                ],
                                              )
                                            : const SizedBox()
                                      ],
                                    )
                            } else ...{
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 14),
                                width: MediaQuery.of(context).size.width,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    if (controller.productData.isNotEmpty &&
                                        controller.productData.last.offers !=
                                            null &&
                                        controller.productData.last.offers
                                                .length >
                                            0) ...{
                                      Text(
                                        'باقي العروض ...',
                                        style: TextStyle(
                                            fontFamily: kTheArabicSansBold,
                                            fontSize: 17.sp,
                                            fontWeight: FontWeight.w700,
                                            color: AppColors.mainColor),
                                      ),
                                      10.ph,
                                      CarouselSlider(
                                        options: CarouselOptions(
                                          viewportFraction: 1.0,
                                          aspectRatio: 1.15,
                                          autoPlay: true,
                                          height: 280.h,

                                          enlargeCenterPage:
                                              true, // Make the current page full width
                                        ),
                                        items: List.generate(
                                            controller.productData.last.offers
                                                    ?.length ??
                                                0,
                                            (index) => GestureDetector(
                                                  onTap: () {
                                                    Get.to(ChangeNotifierProvider(
                                                        create: (context) =>
                                                            ProductProfileControllerProvider(),
                                                        child: ItemProfilePage(
                                                            isQueenOffer: true,
                                                            itemId: controller
                                                                    .productData
                                                                    .last
                                                                    .offers?[
                                                                        index]
                                                                    .id ??
                                                                0)));
                                                  },
                                                  child: Stack(
                                                    fit: StackFit.loose,
                                                    alignment:
                                                        Alignment.topCenter,
                                                    children: [
                                                      Container(
                                                        width: kScreenWidth,
                                                        // margin:
                                                        //     const EdgeInsets.only(bottom: 170),
                                                        height: 170.h,
                                                        decoration:
                                                            BoxDecoration(
                                                          image:
                                                              DecorationImage(
                                                            image: CachedNetworkImageProvider(Connection.urlOfProducts(
                                                                image: controller
                                                                        .productData
                                                                        .last
                                                                        .offers?[
                                                                            index]
                                                                        .offerImage
                                                                        ?.file ??
                                                                    '')),
                                                            fit: BoxFit.fill,
                                                          ),
                                                        ),
                                                      ),
                                                      Positioned(
                                                        top: 150.h,
                                                        child: Container(
                                                          margin:
                                                              const EdgeInsets
                                                                  .only(
                                                                  left: 20,
                                                                  right: 20,
                                                                  bottom: 20),
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width -
                                                              40,
                                                          // height: 181.04.h,
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  horizontal:
                                                                      20),
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors.white,
                                                            boxShadow: [
                                                              BoxShadow(
                                                                color: const Color
                                                                    .fromARGB(
                                                                    32,
                                                                    0,
                                                                    0,
                                                                    0),
                                                                blurRadius:
                                                                    28.r,
                                                                offset:
                                                                    const Offset(
                                                                        0, 4),
                                                                spreadRadius: 0,
                                                              ),
                                                            ],
                                                          ),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              10.ph,
                                                              Text(
                                                                controller
                                                                        .productData
                                                                        .last
                                                                        .offers?[
                                                                            index]
                                                                        .title ??
                                                                    '',
                                                                style:
                                                                    TextStyle(
                                                                  color: AppColors
                                                                      .kPrimaryColor,
                                                                  fontSize:
                                                                      18.sp,
                                                                  fontFamily:
                                                                      kTheArabicSansBold,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                ),
                                                              ),
                                                              Text(
                                                                controller
                                                                        .productData
                                                                        .last
                                                                        .offers?[
                                                                            index]
                                                                        .offerDescription ??
                                                                    '',
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style:
                                                                    TextStyle(
                                                                  color: AppColors
                                                                      .kBlackPinkColor,
                                                                  height: 2,
                                                                  fontSize:
                                                                      13.sp,
                                                                  fontFamily:
                                                                      kTheArabicSansLight,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 10.h,
                                                              ),
                                                              InkWell(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10.69.r),
                                                                onTap: () {
                                                                  Get.to(ChangeNotifierProvider(
                                                                      create: (context) =>
                                                                          ProductProfileControllerProvider(),
                                                                      child: ItemProfilePage(
                                                                          isQueenOffer:
                                                                              true,
                                                                          itemId:
                                                                              controller.productData.last.offers?[index].id ?? 0)));
                                                                },
                                                                child:
                                                                    Container(
                                                                  width:
                                                                      109.71.w,
                                                                  height:
                                                                      37.93.h,
                                                                  decoration:
                                                                      ShapeDecoration(
                                                                    color: AppColors
                                                                        .kPrimaryColor,
                                                                    shape:
                                                                        RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              10.69.r),
                                                                    ),
                                                                  ),
                                                                  child: Center(
                                                                    child: Text(
                                                                      tr('shop_now'),
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                      style:
                                                                          TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize:
                                                                            12.83.sp,
                                                                        fontFamily:
                                                                            kTheArabicSansLight,
                                                                        fontWeight:
                                                                            FontWeight.w700,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 10.h,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                )),
                                        disableGesture: true,
                                      )
                                      // Text(
                                      //     '${controller.productData.last.offers.length}')
                                    }
                                  ],
                                ),
                              )
                            }
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: 100.h,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: AppColors.kWhiteColor,
                          boxShadow: [
                            BoxShadow(
                              color: const Color.fromARGB(32, 0, 0, 0),
                              blurRadius: 28.r,
                              offset: const Offset(0, 4),
                              spreadRadius: 0,
                            ),
                          ]),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  // for(dynamic selected in controller.selectedOptions){
                                  //   if (selected==null) {
                                  //     showDialog(
                                  //         context: context,
                                  //         builder: (BuildContext context) {
                                  //           return CustomAlertDialog(
                                  //             buttonTwo:false,
                                  //             dilougText:tr('chooseOptionFirst'),
                                  //             buttonOneText: tr('okay'),
                                  //           );
                                  //         });
                                  //     return;
                                  //   }
                                  // }
                                  controller.decrement();
                                },
                                child: Container(
                                    height: 47.61.h,
                                    width: 49.08.w,
                                    color: AppColors.kPrimaryColor,
                                    child: Center(
                                      child: Text(
                                        '-',
                                        style: TextStyle(
                                            color: AppColors.kWhiteColor,
                                            fontSize: 30.sp,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    )),
                              ),

                              Container(
                                  height: 47.61.h,
                                  width: 49.08.w,
                                  color: AppColors.kWhiteColor,
                                  child: Center(
                                    child: Text(
                                      '${controller.count}',
                                      style: TextStyle(
                                        color: AppColors.kBlackColor,
                                        fontSize: 19.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  )),
                              GestureDetector(
                                onTap: () {
                                  // for(dynamic selected in controller.selectedOptions){
                                  //   if (selected==null) {
                                  //     showDialog(
                                  //         context: context,
                                  //         builder: (BuildContext context) {
                                  //           return CustomAlertDialog(
                                  //             buttonTwo:false,
                                  //             dilougText:tr('chooseOptionFirst'),
                                  //             buttonOneText: tr('okay'),
                                  //           );
                                  //         });
                                  //     return;
                                  //   }
                                  // }
                                  controller.increment();
                                },
                                child: Container(
                                    height: 47.61.h,
                                    width: 49.08.w,
                                    color: AppColors.kPrimaryColor,
                                    child: Center(
                                      child: Icon(
                                        Icons.add,
                                        color: AppColors.kWhiteColor,
                                        size: 30.r,
                                      ),
                                    )),
                              ),
                              // SizedBox(width: 17.w),
                            ],
                          ),
                          if (controller.isLoading != true) ...{
                            if ((controller.productData.isNotEmpty == true) &&
                                (controller.productData.last.product.stock ==
                                        null ||
                                    controller.productData.last.product.stock ==
                                        "0")) ...{
                              Container(
                                  height: 47.61.h,
                                  width: MediaQuery.of(context).size.width / 2,
                                  color: AppColors.kCDGColor,
                                  child: Center(
                                    child: Text(
                                      tr('not_availble_now'),
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14.11.sp,
                                        fontFamily: kTheArabicSansLight,
                                        fontWeight: FontWeight.w700,
                                        // height: 0.09,
                                      ),
                                    ),
                                  ))
                            } else ...{
                              GestureDetector(
                                onTap: () async {
                                  await controller.addToCart();
                                  await _controllerNav.getCountOfCart();
                                },
                                child: Container(
                                    height: 47.61.h,
                                    width:
                                        MediaQuery.of(context).size.width / 2,
                                    color: AppColors.kPrimaryColor,
                                    child: Center(
                                      child: Text(
                                        tr('addToCart'),
                                        style: TextStyle(
                                            fontFamily: kTheArabicSansLight,
                                            color: AppColors.kWhiteColor,
                                            fontSize: 15.89.sp,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    )),
                              ),
                            }
                          }
                        ],
                      ),
                    ),
                  ],
                ))),
      ),
    );
  }
}
