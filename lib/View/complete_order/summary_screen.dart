import 'package:beauty_queen/const/app_images.dart';
import 'package:beauty_queen/const/extensions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../const/app_colors.dart';
import '../../const/styles.dart';
import '../../const/vars.dart';
import '../../controller/complete_order_controller/basketController.dart';
import '../../widgets/order/rps_custom_painter.dart';
import '../../widgets/product_profile/custom_color_container.dart';
import 'productadded_screen.dart';

class SummaryScreen extends StatelessWidget {
  const SummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final BasketController basketController = Get.put(BasketController());

    return Scaffold(
      body: Obx(
        () => Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 40.h,
                          ),
                          Row(
                            children: [
                              SvgPicture.asset(AppImages.billPaymentImage),
                              SizedBox(
                                width: 20.w,
                              ),
                              Text(
                                'تأكيد الطلب',
                                style: TextStyle(
                                    fontFamily: kTheArabicSansLight,
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.kBlackColor),
                              ),
                              const Spacer(),
                              Text(
                                'عدد العناصر (${basketController.order.value.totalQty ?? 0})',
                                style: TextStyle(
                                    fontFamily: kTheArabicSansLight,
                                    fontSize: 24.sp,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.kBlackColor),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    20.ph,
                    Container(
                        margin: const EdgeInsets.symmetric(horizontal: 16),
                        child: CustomPaint(
                          size: Size(
                              MediaQuery.of(context).size.width,
                              (MediaQuery.of(context).size.width *
                                      1.3283208020050126)
                                  .toDouble()),
                          painter: RPSCustomPainter(),
                          child: Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 20.w, vertical: 10.h),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                15.ph,
                                Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceBetween, // To place text on the left and right
                                  children: [
                                    Column(
                                      children: [
                                        Text(
                                          'تاريخ و وقت الطلب:',
                                          style: TextStyle(
                                            fontFamily: kTheArabicSansLight,
                                            fontSize: 17.sp,
                                            fontWeight: FontWeight.w500,
                                            color: AppColors.kBlackColor,
                                          ),
                                        ),
                                        Text(
                                          '${basketController.order.value.order?.createdAt?.split("T").first} ${basketController.order.value.order?.createdAt?.split("T").last.substring(0, 5)}',
                                          style: TextStyle(
                                            fontFamily: kTheArabicSansLight,
                                            fontSize: 18.sp,
                                            fontWeight: FontWeight.w600,
                                            color: AppColors.kPrimaryColor,
                                          ),
                                        )
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                          'رقم الطلب:',
                                          style: TextStyle(
                                            fontFamily: kTheArabicSansLight,
                                            fontSize: 17.sp,
                                            fontWeight: FontWeight.w500,
                                            color: AppColors.kBlackColor,
                                          ),
                                        ),
                                        Text(
                                          '${basketController.order.value.order?.id ?? ''}#',
                                          style: TextStyle(
                                            fontFamily: kTheArabicSansLight,
                                            fontSize: 22.sp,
                                            fontWeight: FontWeight.w600,
                                            color: AppColors.kPrimaryColor,
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                                Text(
                                  'منتجات (${basketController.order.value.totalQty ?? 0})',
                                  style: TextStyle(
                                    fontFamily: kTheArabicSansLight,
                                    fontSize: 22.53.sp,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.kBlackColor,
                                  ),
                                ),
                                ...List.generate(
                                    basketController
                                            .order.value.order?.items?.length ??
                                        0,
                                    (index) => Column(
                                          children: [
                                            Row(
                                              children: [
                                                CachedNetworkImage(
                                                    height: 97.h,
                                                    width: 97.w,
                                                    imageUrl: Connection
                                                        .urlOfProducts(
                                                      image: basketController
                                                              .order
                                                              .value
                                                              .order
                                                              ?.items?[index]
                                                              .products
                                                              ?.first
                                                              .mainImage ??
                                                          '',
                                                    ) // controller.order.value.order?.items?[index].products.first,
                                                    ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    SizedBox(
                                                      width:
                                                          MediaQuery.of(context)
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
                                                    SizedBox(
                                                      width:
                                                          MediaQuery.of(context)
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
                                                            fontSize: 15.7.sp,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color: AppColors
                                                                .kGrayColor),
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
                                                                  ?.items?[
                                                                      index]
                                                                  .options
                                                                  ?.length ??
                                                              0,
                                                          (index2) => Row(
                                                                // crossAxisAlignment: CrossAxisAlignment.end,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  if (basketController
                                                                          .order
                                                                          .value
                                                                          .order
                                                                          ?.items?[
                                                                              index]
                                                                          .options?[
                                                                              index2]
                                                                          .isColor ==
                                                                      "1") ...{
                                                                    ColorContainer(
                                                                      height:
                                                                          20.h,
                                                                      currentId:
                                                                          0,
                                                                      width:
                                                                          50.w,
                                                                      color: Color(int.parse(
                                                                          "ff${basketController.order.value.order?.items?[index].options?[index2].color?.toUpperCase().replaceAll('#', '') ?? ''}",
                                                                          radix:
                                                                              16)),
                                                                    )
                                                                  } else ...{
                                                                    Text(
                                                                        basketController.order.value.order?.items?[index].options?[index2].title ??
                                                                            '',
                                                                        style: TextStyle(
                                                                            fontFamily:
                                                                                kTheArabicSansLight,
                                                                            fontSize:
                                                                                14.83.sp,
                                                                            fontWeight: FontWeight.w600,
                                                                            color: AppColors.kBlackColor)),
                                                                  },
                                                                ],
                                                              ))
                                                    }
                                                  ],
                                                ),
                                                const Spacer(),
                                                SizedBox(
                                                  height: 97.h,
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        '${basketController.order.value.order?.items?[index].price}د.ل',
                                                        style: TextStyle(
                                                            fontFamily:
                                                                kTheArabicSansLight,
                                                            fontSize: 16.57.sp,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color: AppColors
                                                                .mainColor),
                                                      ),
                                                      if (basketController
                                                              .order
                                                              .value
                                                              .order
                                                              ?.items?[index]
                                                              .option ==
                                                          null) ...{
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            const SizedBox(),
                                                            Text(
                                                              '${basketController.order.value.order?.items?[index].quantity}x قطعة',
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      kTheArabicSansLight,
                                                                  fontSize:
                                                                      14.83.sp,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
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
                                                                  ?.items?[
                                                                      index]
                                                                  .options
                                                                  ?.length ??
                                                              0,
                                                          (index2) => Text(
                                                            '${basketController.order.value.order?.items?[index].quantity}x قطعة',
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    kTheArabicSansLight,
                                                                fontSize:
                                                                    14.83.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
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
                                            if (((basketController
                                                            .order
                                                            .value
                                                            .order
                                                            ?.items
                                                            ?.length ??
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
                              ],
                            ),
                          ),
                        )),
                    ////////////////container/////////////////////////

                    SizedBox(
                      height: 47.h,
                    ),
                    ////////////////////////////////////////////////
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Column(
                        children: [
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'الاجمالي',
                                  style: TextStyle(
                                      fontFamily: kTheArabicSansLight,
                                      fontSize: 18.1.sp,
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.kTextGrayColor),
                                ),
                                Text(
                                  '${num.parse("${basketController.order.value.subtotal ?? '0'}")} ${tr('Del')}',
                                  style: TextStyle(
                                      fontFamily: kTheArabicSansLight,
                                      fontSize: 18.1.sp,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.kBlackColor),
                                ),
                              ]),
                          ///////////second row////////
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'خصم البروموكود',
                                  style: TextStyle(
                                      fontFamily: kTheArabicSansLight,
                                      fontSize: 18.1.sp,
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.kTextGrayColor),
                                ),
                                Text(
                                  '-${num.parse("${basketController.order.value.discount ?? '0'}")} ${tr('Del')}',
                                  style: TextStyle(
                                      fontFamily: kTheArabicSansLight,
                                      fontSize: 18.1.sp,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.kBlackColor),
                                ),
                              ]),
                          /////////third row//////////////
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'تخفيض الفاتورة',
                                  style: TextStyle(
                                      fontFamily: kTheArabicSansLight,
                                      fontSize: 18.1.sp,
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.kTextGrayColor),
                                ),
                                Text(
                                  '-${num.parse(basketController.order.value.flashDiscountStatus ?? '0')} ${tr('Del')}',
                                  style: TextStyle(
                                      fontFamily: kTheArabicSansLight,
                                      fontSize: 18.1.sp,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.kBlackColor),
                                ),
                              ]),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'تكلفة التوصيل',
                                  style: TextStyle(
                                      fontFamily: kTheArabicSansLight,
                                      fontSize: 18.1.sp,
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.kTextGrayColor),
                                ),
                                Text(
                                  '${num.parse(basketController.order.value.shippingCost ?? '0')} ${tr('Del')}',
                                  style: TextStyle(
                                      fontFamily: kTheArabicSansLight,
                                      fontSize: 18.1.sp,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.kBlackColor),
                                ),
                              ]),
                          Divider(
                            color: AppColors.kTextGrayColor,
                            thickness: 1.w,
                          ),
                          15.ph,
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'قيمة الفاتورة',
                                  style: TextStyle(
                                      fontFamily: kTheArabicSansLight,
                                      fontSize: 19.sp,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.kBlackColor),
                                ),
                                Text(
                                  '${num.parse("${basketController.order.value.totalPrice ?? '0'}")} ${tr('Del')}',
                                  style: TextStyle(
                                      fontFamily: kTheArabicSansLight,
                                      fontSize: 22.44.sp,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.kPrimaryColor),
                                ),
                              ]),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 160.h,
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
                        '${num.parse("${basketController.order.value.totalPrice ?? '0'}")} ${tr('Del')}',
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
                      ///todo send request to add the order
                      Get.to(const ProductAddedScreen());
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
                          tr('confirem_order'),
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
        ),
      ),
    );
  }
}
