import 'dart:developer';

import 'package:beauty_queen/const/app_colors.dart';
import 'package:beauty_queen/const/app_images.dart';
import 'package:beauty_queen/const/extensions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../View/home/bottom_nav_screen.dart';
import '../../const/styles.dart';
import '../../const/vars.dart';
import '../../controller/complete_order_controller/basketController.dart';
import '../../controller/orders_controller/orders_controller.dart';
import '../based/error_pop_up.dart';
import '../based/loading.dart';
import '../product_profile/CustomAlertBox.dart';
import '../product_profile/custom_color_container.dart';
import '../shimmer/shimmer_ticket.dart';

class ShowModalSheetDetailOrder extends StatelessWidget {
  const ShowModalSheetDetailOrder({super.key});
  @override
  Widget build(BuildContext context) {
    OrdersController controller = Get.put(OrdersController());

    return Scaffold(
        // backgroundColor: Colors.transparent,
        //   ,
        appBar: AppBar(
          surfaceTintColor: AppColors.kWhiteColor,
          automaticallyImplyLeading: false,
          elevation: 1,
          backgroundColor: AppColors.kWhiteColor,
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(
                  Icons.close,
                  size: 30.r,
                  color: AppColors.kPrimaryColor,
                )),
          ],
          title: Text(
            "سجل الطلبات",
            style: TextStyle(
                fontFamily: kTheArabicSansLight,
                color: AppColors.kBlackColor,
                fontSize: 23.74.sp,
                fontWeight: FontWeight.w600),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Obx(() => controller.loadingDetailsOrders.value == true
              ? const ShimmerTicket()
              : Column(
                  children: [
                    // SizedBox(
                    //   height: 33.h,
                    // ),

                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        children: [
                          Container(
                              decoration: BoxDecoration(
                                image: const DecorationImage(
                                    image: AssetImage(AppImages.ticket1Image),
                                    fit: BoxFit.fill),
                                // color: cardColor(context),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 20.w),
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
                                              '${controller.order.value.order?.createdAt?.split("T").first} ${controller.order.value.order?.createdAt?.split("T").last.substring(0, 5)}',
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
                                              '${controller.order.value.order?.id ?? ''}#',
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
                                    15.ph
                                  ])),
                          Container(
                              decoration: BoxDecoration(
                                image: const DecorationImage(
                                    image: AssetImage(AppImages.ticket2Image),
                                    fit: BoxFit.fill),
                                // color: cardColor(context),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 20.w),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    30.ph,
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'منتجات (${controller.order.value.totalQty})',
                                          style: TextStyle(
                                            fontFamily: kTheArabicSansLight,
                                            fontSize: 22.53.sp,
                                            fontWeight: FontWeight.w600,
                                            color: AppColors.kBlackColor,
                                          ),
                                        ),
                                        Column(
                                          children: [
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 7,
                                                      vertical: 7),
                                              decoration: BoxDecoration(
                                                  color:
                                                      AppColors.lightGreenColor,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          9.r)),
                                              child: Center(
                                                child: Text(
                                                  controller.order.value.order
                                                      ?.getTheTextOfFinalState(),
                                                  style: TextStyle(
                                                    fontFamily:
                                                        kTheArabicSansLight,
                                                    fontSize: 15.sp,
                                                    fontWeight: FontWeight.w600,
                                                    color: AppColors.greenColor,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            if (controller.order.value.order
                                                    ?.status ==
                                                OrderState.pending) ...{
                                              InkWell(
                                                onTap: () async {
                                                  showDialog(
                                                      context: context,
                                                      builder: (BuildContext
                                                          context) {
                                                        return CustomAlertDialog(
                                                          height: 180.64.h,
                                                          dilougText:
                                                              tr('cancelOrder'),
                                                          buttonOneText:
                                                              tr('no'),
                                                          buttonTwoText:
                                                              tr('yes'),
                                                          onButtonTwoPressed:
                                                              () async {
                                                            Navigator.of(
                                                                    context)
                                                                .pop();

                                                            BasketController
                                                                basketController =
                                                                Get.put(
                                                                    BasketController());

                                                            try {
                                                              LoadingScreen
                                                                  .show(
                                                                      context);
                                                              await basketController
                                                                  .cancelOrder(
                                                                      orderId:
                                                                          '${controller.order.value.order?.id}');
                                                              // controller.order.value.order.id
                                                              // Navigator.of(context)
                                                              //     .pop();

                                                              controller
                                                                  .getOrders();
                                                              if (Get.previousRoute ==
                                                                  '/OrdersScreen') {
                                                                Get.back();
                                                              } else {
                                                                Get.offAll(
                                                                    const MainView());
                                                              }
                                                            } on DioException catch (e) {
                                                              log('error1:$e');
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                              ErrorPopUp(
                                                                  message: (e
                                                                          .response
                                                                          ?.data)
                                                                      .values
                                                                      .first,
                                                                  title: 'خطا');
                                                            } catch (e) {
                                                              log('error3:$e');
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                              if (e ==
                                                                  'Check Network connection') {
                                                                ErrorPopUp(
                                                                    message: tr(
                                                                        'network_connection'),
                                                                    title:
                                                                        'خطا');
                                                              } else {
                                                                ErrorPopUp(
                                                                    message: tr(
                                                                        'something_wrong'),
                                                                    title:
                                                                        'خطا');
                                                              }
                                                            }
                                                          },
                                                        );
                                                      });
                                                },
                                                child: Text(
                                                  'الغاء',
                                                  style: TextStyle(
                                                    fontFamily:
                                                        kTheArabicSansLight,
                                                    fontSize: 15.sp,
                                                    fontWeight: FontWeight.w600,
                                                    color: AppColors.redColor,
                                                  ),
                                                ),
                                              )
                                            }
                                          ],
                                        ),
                                      ],
                                    ),
                                    ...List.generate(
                                        controller.order.value.order?.items
                                                ?.length ??
                                            0,
                                        (index) => Column(
                                              children: [
                                                if (controller
                                                        .order
                                                        .value
                                                        .order
                                                        ?.items?[index]
                                                        .status !=
                                                    OrderState.cancelled) ...{
                                                  Row(
                                                    children: [
                                                      CachedNetworkImage(
                                                          height: 97.h,
                                                          width: 97.w,
                                                          imageUrl: Connection
                                                              .urlOfProducts(
                                                            image: controller
                                                                    .order
                                                                    .value
                                                                    .order
                                                                    ?.items?[
                                                                        index]
                                                                    .products
                                                                    ?.first
                                                                    .mainImage ??
                                                                '',
                                                          ) // controller.order.value.order?.items?[index].products.first,
                                                          ),
                                                      5.pw,
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          SizedBox(
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width /
                                                                3,
                                                            child: Text(
                                                              controller
                                                                      .order
                                                                      .value
                                                                      .order
                                                                      ?.items?[
                                                                          index]
                                                                      .products
                                                                      ?.first
                                                                      .brand
                                                                      ?.title ??
                                                                  '',
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      kTheArabicSansLight,
                                                                  fontSize:
                                                                      17.44.sp,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  color: AppColors
                                                                      .kBlackColor),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width /
                                                                3,
                                                            child: Text(
                                                              controller
                                                                      .order
                                                                      .value
                                                                      .order
                                                                      ?.items?[
                                                                          index]
                                                                      .products
                                                                      ?.first
                                                                      .title ??
                                                                  '',
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      kTheArabicSansLight,
                                                                  fontSize:
                                                                      15.7.sp,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  color: AppColors
                                                                      .kGrayColor),
                                                            ),
                                                          ),
                                                          if (controller
                                                                  .order
                                                                  .value
                                                                  .order
                                                                  ?.items?[
                                                                      index]
                                                                  .option !=
                                                              null) ...{
                                                            ...List.generate(
                                                                controller
                                                                        .order
                                                                        .value
                                                                        .order
                                                                        ?.items?[
                                                                            index]
                                                                        .options
                                                                        ?.length ??
                                                                    0,
                                                                (index2) =>
                                                                    Container(
                                                                      height:
                                                                          20.h,
                                                                      child:
                                                                          Row(
                                                                        // crossAxisAlignment: CrossAxisAlignment.end,
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceBetween,
                                                                        children: [
                                                                          if (controller.order.value.order?.items?[index].options?[index2].isColor ==
                                                                              "1") ...{
                                                                            ColorContainer(
                                                                              height: 20.h,
                                                                              currentId: 0,
                                                                              width: 50.w,
                                                                              color: Color(int.parse("ff${controller.order.value.order?.items?[index].options?[index2].color?.toUpperCase().replaceAll('#', '') ?? ''}", radix: 16)),
                                                                            )
                                                                          } else ...{
                                                                            Text(controller.order.value.order?.items?[index].options?[index2].title ?? '',
                                                                                style: TextStyle(fontFamily: kTheArabicSansLight, fontSize: 14.83.sp, fontWeight: FontWeight.w600, color: AppColors.kBlackColor)),
                                                                          },
                                                                        ],
                                                                      ),
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
                                                              '${controller.order.value.order?.items?[index].price}د.ل',
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      kTheArabicSansLight,
                                                                  fontSize:
                                                                      16.57.sp,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  color: AppColors
                                                                      .mainColor),
                                                            ),
                                                            if (controller
                                                                    .order
                                                                    .value
                                                                    .order
                                                                    ?.items?[
                                                                        index]
                                                                    .option ==
                                                                null) ...{
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  const SizedBox(),
                                                                  Text(
                                                                    '${controller.order.value.order?.items?[index].quantity}x قطعة',
                                                                    style: TextStyle(
                                                                        fontFamily:
                                                                            kTheArabicSansLight,
                                                                        fontSize:
                                                                            14.83
                                                                                .sp,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w600,
                                                                        color: AppColors
                                                                            .kBlackColor),
                                                                  ),
                                                                ],
                                                              )
                                                            } else if (controller
                                                                    .order
                                                                    .value
                                                                    .order
                                                                    ?.items?[
                                                                        index]
                                                                    .option !=
                                                                null) ...{
                                                              ...List.generate(
                                                                controller
                                                                        .order
                                                                        .value
                                                                        .order
                                                                        ?.items?[
                                                                            index]
                                                                        .options
                                                                        ?.length ??
                                                                    0,
                                                                (index2) =>
                                                                    Text(
                                                                  '${controller.order.value.order?.items?[index].quantity}x قطعة',
                                                                  style: TextStyle(
                                                                      fontFamily:
                                                                          kTheArabicSansLight,
                                                                      fontSize:
                                                                          14.83
                                                                              .sp,
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
                                                  if (((controller
                                                                  .order
                                                                  .value
                                                                  .order
                                                                  ?.items
                                                                  ?.length ??
                                                              0) -
                                                          1) !=
                                                      index) ...{
                                                    const Divider(
                                                      color: AppColors
                                                          .kDividerColor,
                                                      indent: 10,
                                                      endIndent: 10,
                                                    )
                                                  } else ...{
                                                    30.ph
                                                  }
                                                }
                                              ],
                                            )),
                                    40.ph
                                  ])),
                        ],
                      ),
                    ),
                    ///////////divder/////////
                    Row(children: <Widget>[
                      Expanded(
                          child: Divider(
                        endIndent: 10.w,
                        color: AppColors.kTextGrayColor,
                        thickness: 1.w,
                        indent: 10.w,
                      )),
                      Text(
                        'عدد العناصر',
                        style: TextStyle(
                            fontFamily: kTheArabicSansLight,
                            fontSize: 17.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColors.kTextGrayColor),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Text(
                        '${controller.order.value.totalQty} قطع',
                        style: TextStyle(
                            fontFamily: kTheArabicSansLight,
                            fontSize: 19.53.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.kPrimaryColor),
                      ),
                      Expanded(
                          child: Divider(
                        endIndent: 10.w,
                        color: AppColors.kTextGrayColor,
                        thickness: 1.w,
                        indent: 10.w,
                      )),
                    ]),

                    24.ph,
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        children: [
                          Container(
                            // height: 137.9.h,

                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.symmetric(vertical: 10.h),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(14.r),
                                color: AppColors.kWhiteColor,
                                boxShadow: [BoxShadow(blurRadius: 0.5.r)]),
                            child: Padding(
                              padding: EdgeInsets.only(right: 20.w),
                              child: Column(
                                children: [
                                  // SizedBox(
                                  //   height: 10.h,
                                  // ),
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: Text(
                                      'طريقة الإستلام',
                                      style: TextStyle(
                                          fontFamily: kTheArabicSansLight,
                                          fontSize: 19.sp,
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.klPinkColor),
                                    ),
                                  ),
                                  Row(children: [
                                    SvgPicture.asset(AppImages.homeIconImage),
                                    SizedBox(
                                      width: 10.w,
                                    ),
                                    Text(
                                      "${controller.order.value.order?.city?.name ?? ''}, ${controller.order.value.order?.area?.name ?? ''}",
                                      style: TextStyle(
                                          fontFamily: kTheArabicSansLight,
                                          fontSize: 18.1.sp,
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.kBlackColor),
                                    ),
                                  ]),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 27.h,
                          ),
                          ////////////rows///////////
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
                                  "${controller.order.value.subtotal}",
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
                                  "-${controller.order.value.discount}",
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
                                  "-${controller.order.value.order?.specialDiscount ?? ''}",
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
                                  "${controller.order.value.shippingCost}",
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
                          // SizedBox(
                          //   height: 30.h,
                          // ),
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
                                  "${controller.order.value.totalPrice}",
                                  style: TextStyle(
                                      fontFamily: kTheArabicSansLight,
                                      fontSize: 22.44.sp,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.kPrimaryColor),
                                ),
                              ]),
                          ///////////////////////// fourth container

                          SizedBox(
                            height: 50.h,
                          ),
                        ],
                      ),
                    ),
                  ],
                )),
        ));
  }
}
