import 'package:beauty_queen/const/app_images.dart';
import 'package:beauty_queen/const/styles.dart';
import 'package:beauty_queen/controller/cart_controller/productController.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../const/app_colors.dart';
// import '../../const/images.dart';
import '../../const/vars.dart';
import '../../widgets/based/loading.dart';
import '../../widgets/based/error_pop_up.dart';
import '../../widgets/shimmer/shimmer_cart_item.dart';
import '../complete_order/cart_tab_screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _CartScreen();
  }
}

class _CartScreen extends State<CartScreen> {
  ProductController productController = Get.put(ProductController());
  TextEditingController promoCodeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    productController.getCartData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Obx(() => Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    width: 17.w,
                                  ),
                                  SvgPicture.asset(AppImages.imageCarts),
                                  SizedBox(
                                    width: 9.w,
                                  ),
                                  Text(
                                    tr('cart'),
                                    style: TextStyle(
                                        fontFamily: kTheArabicSansLight,
                                        fontSize: 23.sp,
                                        fontWeight: FontWeight.w700,
                                        color: AppColors.kPrimaryColor),
                                  ),
                                ],
                              ),
                              // const Spacer(),
                              IconButton(
                                  onPressed: () {
                                    Get.back();
                                  },
                                  icon: const Icon(
                                    Icons.arrow_forward_ios,
                                    color: AppColors.kBlackColor,
                                    size: 25,
                                  )),
                            ],
                          ),
                          Container(
                            color: AppColors.kPrimaryColor,
                            height: 50.83.h,
                            // width: 438.44.w,
                            width: MediaQuery.of(context).size.width,
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 17.w,
                                ),
                                Text(
                                  tr('minItemsPerOrder'),
                                  style: TextStyle(
                                      fontFamily: kTheArabicSansLight,
                                      fontSize: 19.sp,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.kWhiteColor),
                                ),
                                const Spacer(),
                                SvgPicture.asset(AppImages.kqueencrownImage),
                              ],
                            ),
                          ),
                          productController.isLoading.value == true
                              ? const ShimmerCartItem()
                              : Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 16.w),
                                  child: Column(
                                    children: [
                                      ...List.generate(
                                          productController.cartData.value
                                                  .products?.length ??
                                              0,
                                          (index) => Column(
                                                children: [
                                                  SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    child: Row(
                                                      children: [
                                                        CachedNetworkImage(
                                                          imageUrl: Connection.urlOfProducts(
                                                              image: productController
                                                                      .cartData
                                                                      .value
                                                                      .products?[
                                                                          index]
                                                                      .main_image ??
                                                                  ''),
                                                          height: 97.h,
                                                          width: 97.w,
                                                        ),
                                                        SizedBox(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width -
                                                              130.w,
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Row(
                                                                children: [
                                                                  SizedBox(
                                                                    width: 19.w,
                                                                  ),
                                                                  Text(
                                                                    productController
                                                                            .cartData
                                                                            .value
                                                                            .products?[index]
                                                                            .brand ??
                                                                        '',
                                                                    style: TextStyle(
                                                                        fontFamily:
                                                                            kTheArabicSansLight,
                                                                        fontSize:
                                                                            18.39
                                                                                .sp,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w600,
                                                                        color: AppColors
                                                                            .kBlackColor),
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    maxLines: 1,
                                                                  ),
                                                                  const Spacer(),
                                                                  Text(
                                                                    '${tr('Del')}${productController.cartData.value.products?[index].price}',
                                                                    style: TextStyle(
                                                                        fontFamily:
                                                                            kTheArabicSansLight,
                                                                        fontSize:
                                                                            17.47
                                                                                .sp,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w400,
                                                                        color: AppColors
                                                                            .kBlackColor),
                                                                  ),
                                                                ],
                                                              ),
                                                              Text(
                                                                productController
                                                                        .cartData
                                                                        .value
                                                                        .products?[
                                                                            index]
                                                                        .title ??
                                                                    '',
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                        kTheArabicSansLight,
                                                                    fontSize:
                                                                        16.55
                                                                            .sp,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                    color: AppColors
                                                                        .kGrayColor),
                                                                maxLines: 2,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                              ),
                                                              if (productController
                                                                      .cartData
                                                                      .value
                                                                      .products?[
                                                                          index]
                                                                      .opTitle !=
                                                                  null) ...{
                                                                Text(
                                                                  productController
                                                                          .cartData
                                                                          .value
                                                                          .products?[
                                                                              index]
                                                                          .opTitle ??
                                                                      '',
                                                                  style: TextStyle(
                                                                      fontFamily:
                                                                          kTheArabicSansLight,
                                                                      fontSize:
                                                                          16.55
                                                                              .sp,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      color: AppColors
                                                                          .kGrayColor),
                                                                ),
                                                              }
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 10.h,
                                                  ),
                                                  Align(
                                                    alignment:
                                                        Alignment.topLeft,
                                                    child: Container(
                                                      height: 46.7.h,
                                                      width: 123.53.w,
                                                      decoration: BoxDecoration(
                                                        border: Border.all(
                                                            width: 1.w,
                                                            color: AppColors
                                                                .kTextGrayColor),
                                                      ),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceAround,
                                                        children: [
                                                          IconButton(
                                                              onPressed: () {
                                                                productController
                                                                    .increment(
                                                                        index:
                                                                            index);
                                                              },
                                                              icon: const Icon(
                                                                Icons.add,
                                                                color: AppColors
                                                                    .kBlackColor,
                                                                size: 30,
                                                              )),
                                                          Text(
                                                            '${productController.cartData.value.products?[index].qty}',
                                                            style: TextStyle(
                                                                color: AppColors
                                                                    .kBlackColor,
                                                                fontSize:
                                                                    21.92.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                          ),
                                                          IconButton(
                                                              onPressed: () {
                                                                productController
                                                                    .decrement(
                                                                        index:
                                                                            index);
                                                              },
                                                              icon: productController
                                                                          .cartData
                                                                          .value
                                                                          .products?[
                                                                              index]
                                                                          .qty ==
                                                                      1
                                                                  ? SvgPicture
                                                                      .asset(
                                                                      AppImages
                                                                          .imageDelete,
                                                                      height:
                                                                          22.01
                                                                              .h,
                                                                      width:
                                                                          19.26
                                                                              .w,
                                                                    )
                                                                  : const Icon(
                                                                      CupertinoIcons
                                                                          .minus,
                                                                      color: AppColors
                                                                          .kBlackColor,
                                                                      size: 30,
                                                                    ))
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  const Divider(
                                                    thickness: 1,
                                                    color: AppColors
                                                        .kTextGrayColor,
                                                  ),
                                                ],
                                              )),
                                      SizedBox(
                                        height: 18.h,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            '${tr('countItem')}(${productController.totalCount.value}) ',
                                            style: TextStyle(
                                                fontFamily: kTheArabicSansLight,
                                                fontSize: 21.sp,
                                                fontWeight: FontWeight.w400,
                                                color: AppColors.kPrimaryColor),
                                          ),
                                          Text(
                                            '${tr('all')}: ${productController.totalPrice.value} ${tr('Del')} ',
                                            style: TextStyle(
                                                fontFamily: kTheArabicSansLight,
                                                fontSize: 21.sp,
                                                fontWeight: FontWeight.w700,
                                                color: AppColors.kPrimaryColor),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 51.h,
                                      ),
                                      Container(
                                        height: 53.58.h,
                                        width: 398.w,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                width: 1.w,
                                                color: AppColors.kPrimaryColor),
                                            color: AppColors.klPinkColor,
                                            borderRadius:
                                                BorderRadius.circular(13.r)),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(
                                              width: 13.3.w,
                                            ),
                                            SvgPicture.asset(
                                                AppImages.imageDiscount),
                                            Expanded(
                                              child: TextField(
                                                decoration: InputDecoration(
                                                    errorBorder:
                                                        const OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.zero,
                                                      borderSide: BorderSide(
                                                          color: Colors
                                                              .transparent),
                                                    ),
                                                    focusedBorder:
                                                        const OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.zero,
                                                      borderSide: BorderSide(
                                                          color: Colors
                                                              .transparent),
                                                    ),
                                                    enabledBorder:
                                                        const OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.zero,
                                                      borderSide: BorderSide(
                                                          color: Colors
                                                              .transparent),
                                                    ),
                                                    focusedErrorBorder:
                                                        const OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.zero,
                                                      borderSide: BorderSide(
                                                          color: Colors
                                                              .transparent),
                                                    ),
                                                    hintText: tr('addCoupon'),
                                                    hintStyle: TextStyle(
                                                        fontFamily:
                                                            kTheArabicSansLight,
                                                        fontSize: 18.sp,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: AppColors
                                                            .kWhiteColor)),
                                                controller: promoCodeController,
                                              ),
                                            ),
                                            InkWell(
                                              borderRadius: BorderRadius.only(
                                                  topLeft:
                                                      Radius.circular(13.r),
                                                  bottomLeft:
                                                      Radius.circular(13.r)),
                                              onTap: () async {
                                                LoadingScreen.show(context);
                                                try {
                                                  await productController
                                                      .checkCode(
                                                          code:
                                                              promoCodeController
                                                                  .text);
                                                  if (!context.mounted) return;

                                                  Navigator.of(context).pop();

                                                  ErrorPopUp(
                                                      message: tr(
                                                          'promoCodeAccepted2'),
                                                      title: tr(
                                                          'promoCodeAccepted'),
                                                      isError: false);
                                                } on DioException catch (e) {
                                                  if (!context.mounted) return;

                                                  Navigator.of(context).pop();
                                                  ErrorPopUp(
                                                      message: (e.response?.data
                                                              as Map)
                                                          .values
                                                          .first,
                                                      title: tr('Error'));
                                                } catch (e) {
                                                  if (!context.mounted) return;

                                                  Navigator.of(context).pop();
                                                  ErrorPopUp(
                                                      message:
                                                          tr('something_wrong'),
                                                      title: tr('Error'));
                                                }
                                              },
                                              child: Container(
                                                height: 52.7.h,
                                                // width: 124.28.w,
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10),
                                                decoration: BoxDecoration(
                                                  color:
                                                      AppColors.kPrimaryColor,
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  13.r),
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  13.r)),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    tr('continus2'),
                                                    style: TextStyle(
                                                        fontFamily:
                                                            kTheArabicSansLight,
                                                        fontSize: 18.sp,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: AppColors
                                                            .kWhiteColor),
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    width: MediaQuery.of(context).size.width,
                    decoration:
                        BoxDecoration(color: AppColors.kWhiteColor, boxShadow: [
                      BoxShadow(
                        blurRadius: 10.r,
                        offset: const Offset(0, 4),
                        spreadRadius: 0,
                      ),
                    ]),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        // SizedBox(width: 30.w),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              tr('total'),
                              style: TextStyle(
                                  fontFamily: kTheArabicSansLight,
                                  fontSize: 15.83.sp,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.klPinkColor),
                            ),
                            Text(
                              '${productController.totalPrice.value}${tr('Del')}',
                              style: TextStyle(
                                  fontFamily: kTheArabicSansLight,
                                  fontSize: 24.sp,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.kPrimaryColor),
                            )
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.to(() => const TabView());
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            width: MediaQuery.of(context).size.width / 2,
                            decoration: BoxDecoration(
                              color: AppColors.kPrimaryColor,
                              borderRadius: BorderRadius.circular(46.r),
                            ),
                            child: Center(
                              child: Text(
                                tr('continus'),
                                style: TextStyle(
                                    fontFamily: kTheArabicSansLight,
                                    fontSize: 24.sp,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.kWhiteColor),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ))),
    );
  }
}
