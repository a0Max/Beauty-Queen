import 'package:beauty_queen/const/app_colors.dart';
import 'package:beauty_queen/const/app_images.dart';
import 'package:beauty_queen/const/extensions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../const/styles.dart';
import '../../const/vars.dart';
import '../../controller/orders_controller/orders_controller.dart';
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
                fontFamily: kTheArabicSansBold,
                color: AppColors.mainColor,
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
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        children: [
                          Card(
                              color: Colors.white,
                              surfaceTintColor: Colors.white,
                              child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 10),
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        15.ph,
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment
                                              .start, // To place text on the left and right
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  'رقم الطلب:',
                                                  style: TextStyle(
                                                    fontFamily:
                                                        kTheArabicSansLight,
                                                    fontSize: 14.sp,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                Text(
                                                  '${controller.order.value.order?.id ?? ''}',
                                                  style: TextStyle(
                                                    fontFamily:
                                                        kTheArabicSansLight,
                                                    fontSize: 15.sp,
                                                    fontWeight: FontWeight.w600,
                                                    color: AppColors
                                                        .kTextDGColor
                                                        .withOpacity(.5),
                                                  ),
                                                )
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  'تاريخ و وقت الطلب:',
                                                  style: TextStyle(
                                                    fontFamily:
                                                        kTheArabicSansLight,
                                                    fontSize: 14.sp,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                Text(
                                                  '${controller.order.value.order?.createdAt?.split("T").first} ${controller.order.value.order?.createdAt?.split("T").last.substring(0, 5)}',
                                                  style: TextStyle(
                                                    fontFamily:
                                                        kTheArabicSansLight,
                                                    fontSize: 15.sp,
                                                    fontWeight: FontWeight.w600,
                                                    color: AppColors
                                                        .kTextDGColor
                                                        .withOpacity(.5),
                                                  ),
                                                )
                                              ],
                                            ),
                                            Divider(
                                              color: AppColors.kBlackRedColor
                                                  .withOpacity(.4),
                                              // indent: 10,
                                              // endIndent: 10,
                                            ),
                                            Text(
                                              "${controller.order.value.order?.city?.name ?? ''}, ${controller.order.value.order?.area?.name ?? ''}",
                                              style: TextStyle(
                                                  fontFamily:
                                                      kTheArabicSansLight,
                                                  fontSize: 18.1.sp,
                                                  fontWeight: FontWeight.w500,
                                                  color: AppColors.kBlackColor),
                                            ),
                                          ],
                                        ),
                                        15.ph
                                      ]))),
                          10.ph,
                          if (OrderState.getImageState(
                                  state:
                                      controller.order.value.order?.status) !=
                              null) ...{
                            Image.asset(OrderState.getImageState(
                                    state:
                                        controller.order.value.order?.status) ??
                                ''),
                            10.ph,
                          },
                          Card(
                            color: AppColors.kShadowColor,
                            elevation: 0,
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: Row(
                                children: [
                                  Expanded(
                                      flex: 1,
                                      child: SvgPicture.asset(
                                        AppImages.orderState,
                                        color: AppColors.mainColor,
                                        width: 40.w,
                                      )),
                                  Expanded(
                                      flex: 5,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'تقرير الطلب',
                                            style: TextStyle(
                                              fontFamily: kTheArabicSansBold,
                                              fontSize: 15.sp,
                                              fontWeight: FontWeight.w600,
                                              color: AppColors.mainColor,
                                            ),
                                          ),
                                          if (controller
                                                  .order.value.order?.status ==
                                              OrderState.cancelled) ...{
                                            Text(
                                              controller.order.value.order
                                                      ?.cancelReason ??
                                                  '',
                                              style: TextStyle(
                                                fontFamily: kTheArabicSansLight,
                                                fontSize: 13.sp,
                                                fontWeight: FontWeight.w300,
                                                color: Colors.black,
                                              ),
                                            ),
                                          } else ...{
                                            Text(
                                              OrderState.getMessageState(
                                                      state: controller
                                                          .order
                                                          .value
                                                          .order
                                                          ?.status) ??
                                                  '',
                                              style: TextStyle(
                                                fontFamily: kTheArabicSansLight,
                                                fontSize: 13.sp,
                                                fontWeight: FontWeight.w300,
                                                color: Colors.black,
                                              ),
                                            ),
                                          }
                                        ],
                                      )),
                                  10.pw,
                                ],
                              ),
                            ),
                          ),
                          5.ph,
                          Card(
                            color: AppColors.kShadowColor,
                            elevation: 0,
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: Row(
                                children: [
                                  Expanded(
                                      flex: 1,
                                      child: SvgPicture.asset(
                                        AppImages.imageArtboard,
                                        color: AppColors.mainColor,
                                        width: 40.w,
                                      )),
                                  Expanded(
                                      flex: 5,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            tr('customers_service'),
                                            style: TextStyle(
                                              fontFamily: kTheArabicSansBold,
                                              fontSize: 15.sp,
                                              fontWeight: FontWeight.w600,
                                              color: AppColors.mainColor,
                                            ),
                                          ),
                                          Text(
                                            tr('customers_service2'),
                                            style: TextStyle(
                                              fontFamily: kTheArabicSansLight,
                                              fontSize: 13.sp,
                                              fontWeight: FontWeight.w300,
                                              color: Colors.black,
                                            ),
                                          ),
                                          Text(
                                            '0928225378 - 0911308356',
                                            style: TextStyle(
                                              fontFamily: kTheArabicSansBold,
                                              fontSize: 13.sp,
                                              fontWeight: FontWeight.w700,
                                              color: AppColors.kTextDGColor,
                                            ),
                                          ),
                                        ],
                                      )),
                                  10.pw,
                                ],
                              ),
                            ),
                          ),
                          10.ph,
                          Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              "تفاصيل الطلب",
                              style: TextStyle(
                                  fontFamily: kTheArabicSansBold,
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.mainColor),
                            ),
                          ),
                          5.ph,
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  decoration:
                                      BoxDecoration(color: AppColors.mainColor),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 5),
                                  // margin: EdgeInsets.symmetric(
                                  //     horizontal: 20.w),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
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
                                ...List.generate(
                                    controller
                                            .order.value.order?.items?.length ??
                                        0,
                                    (index) => Column(
                                          children: [
                                            if (controller.order.value.order
                                                    ?.items?[index].status !=
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
                                                                ?.items?[index]
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
                                                              fontSize: 15.7.sp,
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
                                                              ?.items?[index]
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
                                                                  height: 20.h,
                                                                  child: Row(
                                                                    // crossAxisAlignment: CrossAxisAlignment.end,
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    children: [
                                                                      if (controller
                                                                              .order
                                                                              .value
                                                                              .order
                                                                              ?.items?[index]
                                                                              .options?[index2]
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
                                                                              "ff${controller.order.value.order?.items?[index].options?[index2].color?.toUpperCase().replaceAll('#', '') ?? ''}",
                                                                              radix: 16)),
                                                                        )
                                                                      } else ...{
                                                                        Text(
                                                                            controller.order.value.order?.items?[index].options?[index2].title ??
                                                                                '',
                                                                            style: TextStyle(
                                                                                fontFamily: kTheArabicSansLight,
                                                                                fontSize: 14.83.sp,
                                                                                fontWeight: FontWeight.w600,
                                                                                color: AppColors.kBlackColor)),
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
                                                                ?.items?[index]
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
                                                  color:
                                                      AppColors.kDividerColor,
                                                  indent: 10,
                                                  endIndent: 10,
                                                )
                                              } else ...{
                                                30.ph
                                              }
                                            }
                                          ],
                                        )),
                              ]),
                        ],
                      ),
                    ),
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

                    // 24.ph,
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        children: [
                          // SizedBox(
                          //   height: 27.h,
                          // ),
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
