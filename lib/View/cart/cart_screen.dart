import 'dart:developer';

import 'package:beauty_queen/const/app_images.dart';
import 'package:beauty_queen/const/extensions.dart';
import 'package:beauty_queen/const/styles.dart';
import 'package:beauty_queen/controller/cart_controller/productController.dart';
import 'package:beauty_queen/widgets/cart/cart_item.dart';
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
import '../../controller/nav_bar_controller/NavBarController.dart';
import '../../models/products_model.dart';
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
  final NavController controller = Get.put(NavController());

  @override
  void initState() {
    super.initState();
    productController.getCartData();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvoked: (val) {
        controller.getCountOfCart();
      },
      child: SafeArea(
        child: Scaffold(
            body: Obx(() => Column(
                  children: [
                    10.ph,
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: SizedBox(),
                                ),
                                Expanded(
                                  flex: 5,
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
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
                                ),
                                Expanded(
                                  child: IconButton(
                                      onPressed: () {
                                        Get.back();
                                      },
                                      icon: const Icon(
                                        Icons.arrow_forward_ios,
                                        color: AppColors.kBlackColor,
                                        size: 25,
                                      )),
                                ),
                              ],
                            ),
                            20.ph,
                            productController.isLoading.value == true
                                ? const ShimmerCartItem()
                                : Column(children: [
                                    Container(
                                      color: AppColors.kPrimaryColor,
                                      // height: 50.83.h,
                                      padding:
                                          EdgeInsets.symmetric(vertical: 10),
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
                                                fontSize: (16.0 * 0.8).sp,
                                                fontWeight: FontWeight.w600,
                                                color: AppColors.kWhiteColor),
                                          ),
                                          // const Spacer(),
                                          // SvgPicture.asset(
                                          //     AppImages.kqueencrownImage),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 11.w),
                                      child: Column(
                                        children: [
                                          ...List.generate(
                                              productController.cartData.value
                                                      .products?.length ??
                                                  0,
                                              (index) => CartItem(
                                                    product: productController
                                                            .cartData
                                                            .value
                                                            .products?[index] ??
                                                        ProductsModel(),
                                                    index: index,
                                                  )),
                                          SizedBox(
                                            height: 21.h,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                '${tr('countItem')}(${productController.totalCount.value}) ',
                                                style: TextStyle(
                                                    fontFamily:
                                                        kTheArabicSansBold,
                                                    fontSize: 17.sp,
                                                    fontWeight: FontWeight.w400,
                                                    color: AppColors
                                                        .kPrimaryColor),
                                              ),
                                              Text(
                                                '${tr('all')}: ${productController.totalPrice.value} ${tr('Del')} ',
                                                style: TextStyle(
                                                    fontFamily:
                                                        kTheArabicSansLight,
                                                    fontSize: 21.sp,
                                                    fontWeight: FontWeight.w700,
                                                    color: AppColors
                                                        .kPrimaryColor),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ])
                          ],
                        ),
                      ),
                    ),
                    (productController.cartData.value.products?.length ?? 0) > 0
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 14),
                                height: 53.58.h,
                                width: 398.w,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 1.w,
                                        color: AppColors.kPrimaryColor),
                                    color: AppColors.klPinkColor,
                                    borderRadius: BorderRadius.circular(13.r)),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: 13.3.w,
                                    ),
                                    // SvgPicture.asset(AppImages.imageDiscount),
                                    Expanded(
                                      child: TextField(
                                        decoration: InputDecoration(
                                            errorBorder:
                                                const OutlineInputBorder(
                                              borderRadius: BorderRadius.zero,
                                              borderSide: BorderSide(
                                                  color: Colors.transparent),
                                            ),
                                            focusedBorder:
                                                const OutlineInputBorder(
                                              borderRadius: BorderRadius.zero,
                                              borderSide: BorderSide(
                                                  color: Colors.transparent),
                                            ),
                                            enabledBorder:
                                                const OutlineInputBorder(
                                              borderRadius: BorderRadius.zero,
                                              borderSide: BorderSide(
                                                  color: Colors.transparent),
                                            ),
                                            focusedErrorBorder:
                                                const OutlineInputBorder(
                                              borderRadius: BorderRadius.zero,
                                              borderSide: BorderSide(
                                                  color: Colors.transparent),
                                            ),
                                            hintText: 'ادخل البروموكود..',
                                            hintStyle: TextStyle(
                                                fontFamily: kTheArabicSansLight,
                                                fontSize: 18.sp,
                                                fontWeight: FontWeight.w500,
                                                color:
                                                    AppColors.kGreyBlueColor)),
                                        controller: promoCodeController,
                                      ),
                                    ),
                                    InkWell(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(13.r),
                                          bottomLeft: Radius.circular(13.r)),
                                      onTap: () async {
                                        LoadingScreen.show(context);
                                        try {
                                          await productController.checkCode(
                                              code: promoCodeController.text);
                                          if (!context.mounted) return;

                                          Navigator.of(context).pop();

                                          ErrorPopUp(
                                              message: tr('promoCodeAccepted2'),
                                              title: tr('promoCodeAccepted'),
                                              isError: false);
                                        } on DioException catch (e) {
                                          log('e1:$e');
                                          Navigator.of(context).pop();
                                          ErrorPopUp(
                                              message: (e.response?.data as Map)
                                                  .values
                                                  .first,
                                              title: tr('Error'));
                                        } catch (e) {
                                          log('e:$e');
                                          Navigator.of(context).pop();
                                          if (e == 'Check Network connection') {
                                            ErrorPopUp(
                                                message:
                                                    tr('network_connection'),
                                                title: 'خطا');
                                          } else if (e == 'checkPromoCode') {
                                            ErrorPopUp(
                                                message: tr('checkPromoCode'),
                                                title: 'خطا');
                                          } else {
                                            ErrorPopUp(
                                                message: tr('something_wrong'),
                                                title: 'خطا');
                                          }
                                        }
                                      },
                                      child: Container(
                                        height: 52.7.h,
                                        // width: 124.28.w,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        decoration: BoxDecoration(
                                          color: AppColors.kPrimaryColor,
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(13.r),
                                              bottomLeft:
                                                  Radius.circular(13.r)),
                                        ),
                                        child: Center(
                                          child: Text(
                                            tr('continus2'),
                                            style: TextStyle(
                                                fontFamily: kTheArabicSansLight,
                                                fontSize: 18.sp,
                                                fontWeight: FontWeight.w600,
                                                color: AppColors.kWhiteColor),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              20.ph,
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 14),
                                child: GestureDetector(
                                  onTap: () {
                                    Get.to(() => const TabView());
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    width:
                                        MediaQuery.of(context).size.width / 2,
                                    decoration: BoxDecoration(
                                      color: AppColors.kPrimaryColor,
                                      // borderRadius:
                                      //     BorderRadius.circular(46.r),
                                    ),
                                    child: Center(
                                      child: Text(
                                        tr('continus'),
                                        style: TextStyle(
                                            fontFamily: kTheArabicSansLight,
                                            fontSize: 21.sp,
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.kWhiteColor),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              20.ph
                            ],
                          )
                        : SizedBox(),
                  ],
                ))),
      ),
    );
  }
}
