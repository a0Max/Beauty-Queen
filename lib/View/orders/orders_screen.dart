import 'package:beauty_queen/const/styles.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../const/app_colors.dart';
import '../../const/vars.dart';
import '../../controller/orders_controller/orders_controller.dart';
import '../../widgets/order/order_details.dart';
import '../../widgets/order/pink_ticket.dart';
import '../../widgets/shimmer/shimmer_orders.dart';
import 'details_of_order.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final ScrollController _scrollController = ScrollController();
  OrdersController controller = Get.put(OrdersController());

  @override
  void initState() {
    super.initState();
    controller.getOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          backgroundColor: AppColors.kWhiteColor,
          title: Text(
            "طلباتي",
            style: TextStyle(
                color: AppColors.kBlackColor,
                fontSize: 23.74.sp,
                fontFamily: kTheArabicSansBold,
                fontWeight: FontWeight.w400),
          ),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: const Icon(
                  Icons.arrow_forward_ios,
                  color: AppColors.kBlackColor,
                  size: 30,
                )),
          ]),
      key: _scaffoldKey,
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Obx(
          () => Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              child: Column(
                children: controller.loadingOrders.value == true
                    ? [const ShimmerOrders()]
                    : [
                        ...List.generate(
                            controller.listOfOrders.value.length,
                            (index) => Column(
                                  children: [
                                    Container(
                                      height: 163.93.h,
                                      width: MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              width: 1.w,
                                              color: AppColors.kDividerColor),
                                          borderRadius:
                                              BorderRadius.circular(11.r),
                                          color: AppColors.kWhiteColor,
                                          boxShadow: [
                                            BoxShadow(
                                              color: const Color.fromARGB(
                                                  32, 0, 0, 0),
                                              blurRadius: 28.r,
                                              offset: const Offset(0, 4),
                                              spreadRadius: 0,
                                            ),
                                          ]),
                                      child: Column(
                                        children: [
                                          Align(
                                            alignment: Alignment.topCenter,
                                            child: Container(
                                              height: 47.h,
                                              width: 358.w,
                                              decoration: BoxDecoration(
                                                  color: AppColors.kCDGColor,
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  11.r),
                                                          topRight:
                                                              Radius.circular(
                                                                  11.r))),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  Text(
                                                    "رقم الطلب: #${controller.listOfOrders.value[index].id}",
                                                    style: TextStyle(
                                                        fontFamily:
                                                            kTheArabicSansLight,
                                                        color: AppColors
                                                            .kBlackColor,
                                                        fontSize: 18.sp,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                  if (controller
                                                          .listOfOrders
                                                          .value[index]
                                                          .status ==
                                                      OrderState.shipped) ...{
                                                    Text(
                                                      "تم التسليم",
                                                      style: TextStyle(
                                                          fontFamily:
                                                              kTheArabicSansLight,
                                                          color: const Color(
                                                              0xff169D00),
                                                          fontSize: 18.sp,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                  } else if (controller
                                                          .listOfOrders
                                                          .value[index]
                                                          .status ==
                                                      OrderState.cancelled) ...{
                                                    Text(
                                                      'ألغيت',
                                                      style: TextStyle(
                                                        fontFamily:
                                                            kTheArabicSansLight,
                                                        fontSize: 15.sp,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color:
                                                            AppColors.redColor,
                                                      ),
                                                    ),
                                                  } else if (controller
                                                          .listOfOrders
                                                          .value[index]
                                                          .status ==
                                                      OrderState.pending) ...{
                                                    Text(
                                                      'قيد الانتظار',
                                                      style: TextStyle(
                                                        fontFamily:
                                                            kTheArabicSansLight,
                                                        fontSize: 15.sp,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color:
                                                            AppColors.redColor,
                                                      ),
                                                    ),
                                                  } else if (controller
                                                          .listOfOrders
                                                          .value[index]
                                                          .status ==
                                                      OrderState.confirmed) ...{
                                                    Text(
                                                      'مؤكد',
                                                      style: TextStyle(
                                                        fontFamily:
                                                            kTheArabicSansLight,
                                                        fontSize: 15.sp,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color:
                                                            AppColors.redColor,
                                                      ),
                                                    ),
                                                  } else if (controller
                                                          .listOfOrders
                                                          .value[index]
                                                          .status ==
                                                      OrderState.delayed) ...{
                                                    Text(
                                                      'تأخير',
                                                      style: TextStyle(
                                                        fontFamily:
                                                            kTheArabicSansLight,
                                                        fontSize: 15.sp,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color:
                                                            AppColors.redColor,
                                                      ),
                                                    ),
                                                  } else if (controller
                                                          .listOfOrders
                                                          .value[index]
                                                          .status ==
                                                      OrderState
                                                          .readyToPickup) ...{
                                                    Text(
                                                      'جاهز للاستلام',
                                                      style: TextStyle(
                                                        fontFamily:
                                                            kTheArabicSansLight,
                                                        fontSize: 15.sp,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color:
                                                            AppColors.redColor,
                                                      ),
                                                    ),
                                                  } else if (controller
                                                          .listOfOrders
                                                          .value[index]
                                                          .status ==
                                                      OrderState
                                                          .atShippingAgent) ...{
                                                    Text(
                                                      'مع وكيل الشحن',
                                                      style: TextStyle(
                                                        fontFamily:
                                                            kTheArabicSansLight,
                                                        fontSize: 15.sp,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color:
                                                            AppColors.redColor,
                                                      ),
                                                    ),
                                                  } else ...{
                                                    Text(
                                                      controller.order.value
                                                              .order?.status ??
                                                          '',
                                                      style: TextStyle(
                                                        fontFamily:
                                                            kTheArabicSansLight,
                                                        fontSize: 15.sp,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color:
                                                            AppColors.mainColor,
                                                      ),
                                                    ),
                                                  }
                                                ],
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 20.h,
                                          ),
                                          ///////////////second row/////////////
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Text.rich(TextSpan(children: [
                                                TextSpan(
                                                  text: 'عدد العناصر:',
                                                  style: TextStyle(
                                                      fontFamily:
                                                          kTheArabicSansLight,
                                                      fontSize: 14.sp,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: AppColors
                                                          .kTextGrayColor),
                                                ),
                                                TextSpan(
                                                  text:
                                                      '${controller.listOfOrders.value[index]?.orderItems ?? ''} قطع',
                                                  style: TextStyle(
                                                      fontFamily:
                                                          kTheArabicSansLight,
                                                      fontSize: 14.sp,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: AppColors
                                                          .kPrimaryColor),
                                                )
                                              ])),
                                              Text.rich(TextSpan(children: [
                                                TextSpan(
                                                  text: 'تاريخ الطلب:',
                                                  style: TextStyle(
                                                      fontFamily:
                                                          kTheArabicSansLight,
                                                      fontSize: 14.sp,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: AppColors
                                                          .kTextGrayColor),
                                                ),
                                                TextSpan(
                                                  text:
                                                      '${controller.listOfOrders.value[index]?.createdAt.split('T').first ?? ''}',
                                                  style: TextStyle(
                                                      fontFamily:
                                                          kTheArabicSansLight,
                                                      fontSize: 14.sp,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: AppColors
                                                          .kBlackColor),
                                                )
                                              ])),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 20.h,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              CustomPaint(
                                                  painter: PinkTicket(),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 14.w),
                                                    child: Column(
                                                      children: [
                                                        Text(
                                                          'مجموع الفاتورة',
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  kTheArabicSansLight,
                                                              fontSize: 10.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              color: AppColors
                                                                  .kBlackColor),
                                                        ),
                                                        Text(
                                                          '${controller.listOfOrders.value[index]?.price} د.ل ',
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  kTheArabicSansLight,
                                                              fontSize: 16.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              color: AppColors
                                                                  .kPrimaryColor),
                                                        )
                                                      ],
                                                    ),
                                                  )),

                                              /////////////second container///////////
                                              GestureDetector(
                                                onTap: () {
                                                  controller.getDetailsOfOrder(
                                                      id: "${controller.listOfOrders.value[index]?.id}");
                                                  Get.to(DetailsOfOrder(),
                                                      routeName:
                                                          '/DetailsOfOrder');
                                                },
                                                child: Container(
                                                    height: 41.22.h,
                                                    width: 142.38.w,
                                                    decoration: BoxDecoration(
                                                        color: AppColors
                                                            .kPrimaryColor,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    10.r)),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          '     تفاصيل الطلب',
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  kTheArabicSansLight,
                                                              fontSize: 13.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              color: AppColors
                                                                  .kWhiteColor),
                                                        ),
                                                        Icon(
                                                          Icons
                                                              .arrow_forward_ios,
                                                          color: AppColors
                                                              .kWhiteColor,
                                                          size: 15.r,
                                                        )
                                                      ],
                                                    )),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 12.h,
                                    ),
                                  ],
                                ))
                      ],
              )),
        ),
      ),
    );
  }
}
