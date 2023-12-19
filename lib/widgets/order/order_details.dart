import 'package:beauty_queen/const/app_colors.dart';
import 'package:beauty_queen/const/app_images.dart';
import 'package:beauty_queen/const/extensions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../const/styles.dart';
import '../../const/vars.dart';
import '../../controller/orders_controller/orders_controller.dart';
import '../product_profile/custom_color_container.dart';
import '../shimmer/shimmer_ticket.dart';
import 'rps_custom_painter.dart';

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
              ? ShimmerTicket()
              : Column(
                  children: [
                    // SizedBox(
                    //   height: 33.h,
                    // ),
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
                          margin: EdgeInsets.symmetric(horizontal: 20.w),
                          child: Column(
                            children: [
                              15.ph,
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                  if (controller.order.value.order?.status ==
                                      OrderState.shipped) ...{
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 7, vertical: 7),
                                      decoration: BoxDecoration(
                                          color: AppColors.lightGreenColor,
                                          borderRadius:
                                              BorderRadius.circular(9.r)),
                                      child: Center(
                                        child: Text(
                                          'تم التسليم',
                                          style: TextStyle(
                                            fontFamily: kTheArabicSansLight,
                                            fontSize: 15.sp,
                                            fontWeight: FontWeight.w600,
                                            color: AppColors.greenColor,
                                          ),
                                        ),
                                      ),
                                    )
                                  } else if (controller
                                          .order.value.order?.status ==
                                      OrderState.cancelled) ...{
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 7, vertical: 7),
                                      decoration: BoxDecoration(
                                          color: AppColors.klPinkColor,
                                          borderRadius:
                                              BorderRadius.circular(9.r)),
                                      child: Center(
                                        child: Text(
                                          'ألغيت',
                                          style: TextStyle(
                                            fontFamily: kTheArabicSansLight,
                                            fontSize: 15.sp,
                                            fontWeight: FontWeight.w600,
                                            color: AppColors.redColor,
                                          ),
                                        ),
                                      ),
                                    )
                                  } else ...{
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 7, vertical: 7),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(9.r)),
                                      child: Center(
                                        child: Text(
                                          controller
                                                  .order.value.order?.status ??
                                              '',
                                          style: TextStyle(
                                            fontFamily: kTheArabicSansLight,
                                            fontSize: 15.sp,
                                            fontWeight: FontWeight.w600,
                                            color: AppColors.mainColor,
                                          ),
                                        ),
                                      ),
                                    )
                                  },
                                ],
                              ),
                              ...List.generate(
                                  controller.order.value.order?.items?.length ??
                                      0,
                                  (index) => Column(
                                        children: [
                                          Row(
                                            children: [
                                              CachedNetworkImage(
                                                  height: 97.h,
                                                  width: 97.w,
                                                  imageUrl:
                                                      Connection.urlOfProducts(
                                                    image: controller
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
                                                      controller
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
                                                      controller
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
                                                  if (controller
                                                          .order
                                                          .value
                                                          .order
                                                          ?.items?[index]
                                                          .option !=
                                                      null) ...{
                                                    ...List.generate(
                                                        controller
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
                                                                if (controller
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
                                                                    width: 50.w,
                                                                    color: Color(int.parse(
                                                                        "ff${controller.order.value.order?.items?[index].options?[index2].color?.toUpperCase().replaceAll('#', '') ?? ''}",
                                                                        radix:
                                                                            16)),
                                                                  )
                                                                } else ...{
                                                                  Text(
                                                                      controller
                                                                              .order
                                                                              .value
                                                                              .order
                                                                              ?.items?[
                                                                                  index]
                                                                              .options?[
                                                                                  index2]
                                                                              .title ??
                                                                          '',
                                                                      style: TextStyle(
                                                                          fontFamily:
                                                                              kTheArabicSansLight,
                                                                          fontSize: 14.83
                                                                              .sp,
                                                                          fontWeight: FontWeight
                                                                              .w600,
                                                                          color:
                                                                              AppColors.kBlackColor)),
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
                                                      '${controller.order.value.order?.items?[index].price}د.ل',
                                                      style: TextStyle(
                                                          fontFamily:
                                                              kTheArabicSansLight,
                                                          fontSize: 16.57.sp,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: AppColors
                                                              .mainColor),
                                                    ),
                                                    if (controller
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
                                                            '${controller.order.value.order?.items?[index].quantity}x قطعة',
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
                                                    } else if (controller
                                                            .order
                                                            .value
                                                            .order
                                                            ?.items?[index]
                                                            .option !=
                                                        null) ...{
                                                      ...List.generate(
                                                        controller
                                                                .order
                                                                .value
                                                                .order
                                                                ?.items?[index]
                                                                .options
                                                                ?.length ??
                                                            0,
                                                        (index2) => Text(
                                                          '${controller.order.value.order?.items?[index].quantity}x قطعة',
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
                                          if (((controller.order.value.order
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
                            ],
                          ),
                        ),
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
                                      "${controller.order.value.order?.city.name}, ${controller.order.value.order?.area.name}",
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
