import 'dart:developer';

import 'package:beauty_queen/const/app_images.dart';
import 'package:beauty_queen/const/extensions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../const/app_colors.dart';
import '../../const/styles.dart';
import '../../const/vars.dart';
import '../../controller/complete_order_controller/basketController.dart';
import '../../controller/product_controller/product_profile_controller_provider.dart';
import '../../widgets/based/error_pop_up.dart';
import '../../widgets/based/loading.dart';
import '../../widgets/product_profile/custom_color_container.dart';
import '../brands/branddetail_screen.dart';
import '../product_profile/products_screen.dart';
import 'productadded_screen.dart';

class SummaryScreen extends StatelessWidget {
  const SummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final BasketController basketController = Get.put(BasketController());

    return Scaffold(
      body: Obx(
        () => SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 40.h,
                    ),
                    // Row(
                    //   children: [
                    // SvgPicture.asset(AppImages.billPaymentImage),
                    // SizedBox(
                    //   width: 10.w,
                    // ),
                    Text(
                      'الفاتورة',
                      style: TextStyle(
                          fontFamily: kTheArabicSansBold,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w700,
                          color: AppColors.mainColor),
                    ),
                    // const Spacer(),
                    // Text(
                    //   'عدد العناصر (${basketController.order.value.totalQty ?? 0})',
                    //   style: TextStyle(
                    //       fontFamily: kTheArabicSansLight,
                    //       fontSize: 21.sp,
                    //       fontWeight: FontWeight.bold,
                    //       color: AppColors.kBlackColor),
                    // ),
                    // ],
                    // ),
                    Divider(
                      color: AppColors.kBlackRedColor.withOpacity(.4),
                      indent: 10,
                      endIndent: 10,
                    ),
                    Card(
                      color: Colors.white,
                      surfaceTintColor: Colors.white,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  'رقم الطلب:',
                                  style: TextStyle(
                                    fontFamily: kTheArabicSansLight,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                5.pw,
                                Text(
                                  '${basketController.order.value.order?.id ?? ''}',
                                  style: TextStyle(
                                    fontFamily: kTheArabicSansLight,
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w600,
                                    color:
                                        AppColors.kTextDGColor.withOpacity(1),
                                  ),
                                )
                              ],
                            ),
                            10.ph,
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'تاريخ و وقت الطلب:',
                                  style: TextStyle(
                                    fontFamily: kTheArabicSansLight,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                5.pw,
                                Text(
                                  '${basketController.order.value.order?.createdAt?.split("T").first} ${basketController.order.value.order?.createdAt?.split("T").last.substring(0, 5)}',
                                  style: TextStyle(
                                    fontFamily: kTheArabicSansLight,
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w600,
                                    color:
                                        AppColors.kTextDGColor.withOpacity(1),
                                  ),
                                )
                              ],
                            ),
                            Divider(
                              color: AppColors.kBlackRedColor.withOpacity(.4),
                              // indent: 10,
                              // endIndent: 10,
                            ),
                            Text(
                              "${basketController.order.value.order?.city?.name ?? ''}, ${basketController.order.value.order?.area?.name ?? ''}",
                              style: TextStyle(
                                  fontFamily: kTheArabicSansLight,
                                  fontSize: 18.1.sp,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.kBlackColor),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              10.ph,
              Container(
                decoration: BoxDecoration(color: AppColors.kPinkColor),
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                margin: EdgeInsets.symmetric(horizontal: 20.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "الصنف",
                      style: TextStyle(
                          fontFamily: kTheArabicSansLight,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                    Text(
                      "سعر القطعة",
                      style: TextStyle(
                          fontFamily: kTheArabicSansLight,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                  ],
                ),
              ),
              10.ph,

              Container(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        20.ph,
                        ...List.generate(
                            basketController.order.value.order?.items?.length ??
                                0,
                            (index) => Column(
                                  children: [
                                    Row(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            if (basketController
                                                    .order.value.order?.id !=
                                                null) {
                                              Get.to(ChangeNotifierProvider(
                                                  create: (context) =>
                                                      ProductProfileControllerProvider(),
                                                  child: ItemProfilePage(
                                                      itemId: int.parse(
                                                          basketController
                                                                  .order
                                                                  .value
                                                                  .order
                                                                  ?.id
                                                                  .toString() ??
                                                              '0'))));
                                            }
                                          },
                                          child: CachedNetworkImage(
                                              height: 97.h,
                                              width: 97.w,
                                              imageUrl: (basketController
                                                          .order
                                                          .value
                                                          .order
                                                          ?.items?[index]
                                                          .options
                                                          ?.isNotEmpty ??
                                                      false)
                                                  ? Connection.urlOfOptions(
                                                      image: basketController
                                                              .order
                                                              .value
                                                              .order
                                                              ?.items?[index]
                                                              .options
                                                              ?.first
                                                              .mainImage
                                                              ?.file ??
                                                          '',
                                                    )
                                                  : Connection.urlOfProducts(
                                                      image: basketController
                                                              .order
                                                              .value
                                                              .order
                                                              ?.items?[index]
                                                              .products
                                                              ?.first
                                                              .mainImage ??
                                                          '') // controller.order.value.order?.items?[index].products.first,
                                              ),
                                        ),
                                        5.pw,
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                Navigator.of(context)
                                                    .push<void>(
                                                        MaterialPageRoute(
                                                            builder: (_) {
                                                  return BrandDetailScreen(
                                                    brandId: int.parse(
                                                        "${basketController.order.value.order?.items?[index].products?.first.brandId}"),
                                                  );
                                                }));
                                              },
                                              child: SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    3,
                                                child: Text(
                                                  basketController
                                                          .order
                                                          .value
                                                          .order
                                                          ?.items?[index]
                                                          .products
                                                          ?.first
                                                          .brand
                                                          ?.title ??
                                                      '',
                                                  style: TextStyle(
                                                      fontFamily:
                                                          kTheArabicSansLight,
                                                      fontSize: 17.44.sp,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: AppColors
                                                          .kBlackColor),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  3,
                                              child: Text(
                                                basketController
                                                        .order
                                                        .value
                                                        .order
                                                        ?.items?[index]
                                                        .products
                                                        ?.first
                                                        .title ??
                                                    '',
                                                style: TextStyle(
                                                    fontFamily:
                                                        kTheArabicSansLight,
                                                    fontSize: (.9 * 16).sp,
                                                    fontWeight: FontWeight.w500,
                                                    color:
                                                        AppColors.kBlackColor),
                                              ),
                                            ),
                                            if (basketController
                                                    .order
                                                    .value
                                                    .order
                                                    ?.items?[index]
                                                    .option !=
                                                null) ...{
                                              ...List.generate(
                                                  basketController
                                                          .order
                                                          .value
                                                          .order
                                                          ?.items?[index]
                                                          .options
                                                          ?.length ??
                                                      0,
                                                  (index2) => Row(
                                                        // crossAxisAlignment: CrossAxisAlignment.end,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                            "${basketController.order.value.order?.items?[index].options?[index2].title ?? ''} - ${basketController.order.value.order?.items?[index].options?[index2].code ?? ''}",
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    kTheArabicSansLight,
                                                                fontSize:
                                                                    16.55.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                color: AppColors
                                                                    .kGrayColor),
                                                          ),
                                                          // if (basketController
                                                          //         .order
                                                          //         .value
                                                          //         .order
                                                          //         ?.items?[
                                                          //             index]
                                                          //         .options?[
                                                          //             index2]
                                                          //         .isColor ==
                                                          //     "1") ...{
                                                          //   ColorContainer(
                                                          //     height: 20.h,
                                                          //     currentId: 0,
                                                          //     width: 50.w,
                                                          //     color: Color(
                                                          //         int.parse(
                                                          //             "ff${basketController.order.value.order?.items?[index].options?[index2].color?.toUpperCase().replaceAll('#', '') ?? ''}",
                                                          //             radix:
                                                          //                 16)),
                                                          //   )
                                                          // }
                                                          // else ...{
                                                          //   Text(
                                                          //       basketController
                                                          //               .order
                                                          //               .value
                                                          //               .order
                                                          //               ?.items?[
                                                          //                   index]
                                                          //               .options?[
                                                          //                   index2]
                                                          //               .title ??
                                                          //           '',
                                                          //       style: TextStyle(
                                                          //           fontFamily:
                                                          //               kTheArabicSansLight,
                                                          //           fontSize:
                                                          //               14.83
                                                          //                   .sp,
                                                          //           fontWeight:
                                                          //               FontWeight
                                                          //                   .w600,
                                                          //           color: AppColors
                                                          //               .kBlackColor)),
                                                          // },
                                                        ],
                                                      ))
                                            }
                                          ],
                                        ),
                                        const Spacer(),
                                        SizedBox(
                                          height: 97.h,
                                          child: Column(
                                            // mainAxisAlignment:
                                            //     MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Text(
                                                '${basketController.order.value.order?.items?[index].price}د.ل',
                                                style: TextStyle(
                                                    fontFamily:
                                                        kTheArabicSansLight,
                                                    fontSize: 16.57.sp,
                                                    fontWeight: FontWeight.w600,
                                                    color:
                                                        AppColors.kBlackColor),
                                              ),
                                              if (basketController
                                                      .order
                                                      .value
                                                      .order
                                                      ?.items?[index]
                                                      .option ==
                                                  null) ...{
                                                Row(
                                                  // mainAxisAlignment:
                                                  //     MainAxisAlignment
                                                  //         .spaceBetween,
                                                  children: [
                                                    const SizedBox(),
                                                    Text(
                                                      '${basketController.order.value.order?.items?[index].quantity} قطع',
                                                      style: TextStyle(
                                                          fontFamily:
                                                              kTheArabicSansLight,
                                                          fontSize: 14.83.sp,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: AppColors
                                                              .kBlackColor),
                                                    ),
                                                  ],
                                                )
                                              } else if (basketController
                                                      .order
                                                      .value
                                                      .order
                                                      ?.items?[index]
                                                      .option !=
                                                  null) ...{
                                                ...List.generate(
                                                  basketController
                                                          .order
                                                          .value
                                                          .order
                                                          ?.items?[index]
                                                          .options
                                                          ?.length ??
                                                      0,
                                                  (index2) => Text(
                                                    '${basketController.order.value.order?.items?[index].quantity} قطع',
                                                    style: TextStyle(
                                                        fontFamily:
                                                            kTheArabicSansLight,
                                                        fontSize: 14.83.sp,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: AppColors
                                                            .kBlackColor),
                                                  ),
                                                )
                                              }
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                    if (((basketController.order.value.order
                                                    ?.items?.length ??
                                                0) -
                                            1) !=
                                        index) ...{
                                      const Divider(
                                        color: AppColors.kDividerColor,
                                        indent: 10,
                                        endIndent: 10,
                                      )
                                    } else ...{
                                      30.ph
                                    }
                                  ],
                                ))
                      ])),

              ////////////////container/////////////////////////
              20.ph,

              Divider(
                color: AppColors.kBlackRedColor.withOpacity(.4),
                indent: 10,
                endIndent: 10,
              ),
              ////////////////////////////////////////////////
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'عدد العناصر: ',
                              style: TextStyle(
                                  fontFamily: kTheArabicSansLight,
                                  fontSize: 18.1.sp,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.kPinkColor),
                            ),
                            Text(
                              ' 1 قطع',
                              style: TextStyle(
                                  fontFamily: kTheArabicSansLight,
                                  fontSize: 18.1.sp,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.kPinkColor),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'الاجمالي',
                                    style: TextStyle(
                                        fontFamily: kTheArabicSansLight,
                                        fontSize: 18.1.sp,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black),
                                  ),
                                  Text(
                                    '${num.parse("${basketController.order.value.subtotal ?? '0'}")} ${tr('Del')}',
                                    style: TextStyle(
                                        fontFamily: kTheArabicSansBold,
                                        fontSize: 18.1.sp,
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.kBlackColor),
                                  ),
                                ]),

                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'خصم البروموكود',
                                    style: TextStyle(
                                        fontFamily: kTheArabicSansLight,
                                        fontSize: 18.1.sp,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black),
                                  ),
                                  Text(
                                    '-${num.parse("${basketController.order.value.discount ?? '0'}")} ${tr('Del')}',
                                    style: TextStyle(
                                        fontFamily: kTheArabicSansBold,
                                        fontSize: 18.1.sp,
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.kBlackColor),
                                  ),
                                ]),
                            /////////third row//////////////
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'تخفيض الفاتورة',
                                    style: TextStyle(
                                        fontFamily: kTheArabicSansLight,
                                        fontSize: 18.1.sp,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black),
                                  ),
                                  Text(
                                    '-${num.parse(basketController.order.value.flashDiscountStatus ?? '0')} ${tr('Del')}',
                                    style: TextStyle(
                                        fontFamily: kTheArabicSansBold,
                                        fontSize: 18.1.sp,
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.kBlackColor),
                                  ),
                                ]),
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'تكلفة التوصيل',
                                    style: TextStyle(
                                        fontFamily: kTheArabicSansLight,
                                        fontSize: 18.1.sp,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black),
                                  ),
                                  Text(
                                    '${num.parse("${basketController.order.value.shippingCost ?? 0}")} ${tr('Del')}',
                                    style: TextStyle(
                                        fontFamily: kTheArabicSansBold,
                                        fontSize: 18.1.sp,
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.kBlackColor),
                                  ),
                                ]),
                            Divider(
                              color: AppColors.kTextGrayColor.withOpacity(.3),
                              thickness: 1.w,
                            ),
                            15.ph,
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'قيمة الفاتورة',
                                    style: TextStyle(
                                        fontFamily: kTheArabicSansLight,
                                        fontSize: 19.sp,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black),
                                  ),
                                  Text(
                                    '${num.parse("${basketController.order.value.totalPrice ?? '0'}")} ${tr('Del')}',
                                    style: TextStyle(
                                        fontFamily: kTheArabicSansBold,
                                        fontSize: 22.44.sp,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.kPrimaryColor),
                                  ),
                                ]),
                          ],
                        ),
                      ),
                    ],
                  )),
              SizedBox(
                height: 20.h,
              ),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Row(
                    children: [
                      Expanded(child: SizedBox()),
                      Expanded(
                          flex: 2,
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  try {
                                    LoadingScreen.show(context);
                                    await basketController.completeOrder(
                                        orderId:
                                            '${basketController.order.value.order?.id}');
                                    Navigator.of(context).pop();
                                    basketController.clearData();
                                    Get.to(ProductAddedScreen());
                                    // Navigator.pushAndRemoveUntil(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //       builder: (context) => const ProductAddedScreen(),
                                    //     ),
                                    //     (route) => false);
                                  } on DioException catch (e) {
                                    log('error1:$e');
                                    Navigator.of(context).pop();
                                    // try {
                                    ErrorPopUp(
                                        message:
                                            (e.response?.data).values.first,
                                        title: 'خطا');
                                    // } catch (e) {
                                    //   log('error2:$e');
                                    //   ErrorPopUp(
                                    //       message: tr('something_wrong'), title: 'خطا');
                                    // }
                                  } catch (e, s) {
                                    FirebaseCrashlytics.instance
                                        .recordError('Api Crash $e', s);
                                    log('error3:$e');
                                    Navigator.of(context).pop();
                                    if (e == 'Check Network connection') {
                                      ErrorPopUp(
                                          message: tr('network_connection'),
                                          title: 'خطا');
                                    } else {
                                      ErrorPopUp(
                                          message: tr('something_wrong'),
                                          title: 'خطا');
                                    }
                                  }
                                },
                                child: Container(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8),
                                  width: MediaQuery.of(context).size.width - 40,
                                  decoration: BoxDecoration(
                                    color: AppColors.kPrimaryColor,
                                    // borderRadius: BorderRadius.circular(46.r),
                                  ),
                                  child: Center(
                                    child: Text(
                                      tr('confirem_order'),
                                      style: TextStyle(
                                          fontFamily: kTheArabicSansBold,
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.kWhiteColor),
                                    ),
                                  ),
                                ),
                              ),
                              10.ph,
                              GestureDetector(
                                onTap: () async {
                                  Navigator.of(context).pop();
                                },
                                child: Container(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8),
                                  width: MediaQuery.of(context).size.width - 40,
                                  decoration: BoxDecoration(
                                    color: AppColors.kPrimaryColor,
                                    // borderRadius: BorderRadius.circular(46.r),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'الرجوع',
                                      style: TextStyle(
                                          fontFamily: kTheArabicSansBold,
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.kWhiteColor),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ))
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
