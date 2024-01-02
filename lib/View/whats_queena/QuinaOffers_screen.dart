// ignore_for_file: file_names

import 'package:beauty_queen/const/styles.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geekyants_flutter_gauges/geekyants_flutter_gauges.dart';
import 'package:get/get.dart';

import '../../const/app_colors.dart';
import '../../const/app_images.dart';
import '../../const/vars.dart';
import '../../controller/queen_controller/queen_offer_controller.dart';
import '../../models/sales_products_model.dart';
import '../../widgets/based/filter_widget.dart';
import '../../widgets/based/see_more.dart';
import '../../widgets/based/sort_drop_down.dart';
import '../../widgets/product_profile/CustomCardWidget.dart';
import '../../widgets/shimmer/shimmer_item.dart';

class QuinaOffersScreen extends StatefulWidget {
  const QuinaOffersScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _QuinaOffersScreen();
  }
}

class _QuinaOffersScreen extends State<QuinaOffersScreen> {
  final QueenOfferController controller = Get.put(QueenOfferController());

  @override
  void initState() {
    super.initState();
    controller.getQueenOfferDataController(currentPage: 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => SingleChildScrollView(
            child: controller.isLoading.value == true
                ? Wrap(
                    runSpacing: 7,
                    children: List.generate(2, (index) => const ShimmerItem()),
                  )
                : controller.dataProducts.isEmpty
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 35.h,
                          ),
                          Center(child: Image.asset(AppImages.bagImage)),
                          SizedBox(
                            height: 35.h,
                          ),
                          Center(
                            child: Text(tr('no_offer_items'),
                                style: TextStyle(
                                  fontFamily: kTheArabicSansLight,
                                  color: AppColors.kBlackColor,
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w400,
                                )),
                          ),
                          SizedBox(
                            height: 16.h,
                          ),
                          Center(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10.w),
                              child: Text(tr('no_offer_items2'),
                                  style: TextStyle(
                                    fontFamily: kTheArabicSansLight,
                                    color: AppColors.kTextGrayColor,
                                    fontSize: 17.sp,
                                    fontWeight: FontWeight.w400,
                                  )),
                            ),
                          ),
                        ],
                      )
                    : Column(
                        children: [
                          SizedBox(
                            height: 30.h,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12.w),
                            child: Row(
                              children: [
                                SortDropDown(
                                    value: controller.valueSort.value == ''
                                        ? null
                                        : controller.valueSort.value,
                                    onChanged: (String? newValue) {
                                      SortTypes.listOfTTypesOfSort
                                          .forEach((key, value) {
                                        if (value == newValue) {
                                          controller.updateSortType(
                                              newKeySort: key,
                                              newValueSort: value);
                                        }
                                      });
                                    }),
                                //////////////second///////////////
                                FilterWidget(
                                  onTap: () {},
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 21.h,
                          ),
                          Align(
                            alignment: Alignment.topRight,
                            child: Padding(
                              padding: EdgeInsets.only(right: 16.w),
                              child: Text(
                                  '${tr('count_items')}: ${controller.generalSearchData.value.products?.total ?? ''}',
                                  style: TextStyle(
                                    color: AppColors.kGrayColor,
                                    fontSize: 17.sp,
                                    fontWeight: FontWeight.w400,
                                  )),
                            ),
                          ),
                          SizedBox(
                            height: 22.h,
                          ),
                          Wrap(
                            runSpacing: 7,
                            children: List.generate(
                                controller.dataProducts.value.length,
                                (index) => CustomCardWidget(
                                      sale: controller.dataProducts
                                                  .value?[index].isDiscount ==
                                              "1"
                                          ? true
                                          : false,
                                      imageUrl: Connection.urlOfProducts(
                                          image: controller.dataProducts
                                                  .value[index].mainImage ??
                                              ''),
                                      newArrival: controller
                                              .dataProducts.value[index] ??
                                          SalesProductsModel(),
                                      favorite: controller
                                              .dataProducts
                                              .value[index]
                                              .wishlist
                                              ?.isNotEmpty ??
                                          false,
                                    )),
                          ),
                          if (controller.dataProducts.value.isNotEmpty) ...{
                            SeeMoreWidget(
                              currentDataProductsLength:
                                  "${controller.dataProducts.value.length}",
                              totalDataProductsLength:
                                  "${controller.generalSearchData.value.products?.total ?? 1}",
                              onTap: () {
                                controller.getQueenOfferDataController();
                              },
                            ),
                          }
                        ],
                      ),
          )),
    );
  }
}
