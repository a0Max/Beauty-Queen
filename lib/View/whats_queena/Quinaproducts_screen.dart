import 'package:beauty_queen/const/extensions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geekyants_flutter_gauges/geekyants_flutter_gauges.dart';
import 'package:get/get.dart';

import '../../const/app_colors.dart';
import '../../const/app_images.dart';
// import '../../const/images.dart';
import '../../const/styles.dart';
import '../../const/vars.dart';
import '../../controller/queen_controller/queen_controller.dart';
import '../../models/sales_products_model.dart';
import '../../widgets/based/filter_widget.dart';
import '../../widgets/based/see_more.dart';
import '../../widgets/based/sort_drop_down.dart';
import '../../widgets/product_profile/CustomCardWidget.dart';
import '../../widgets/shimmer/shimmer_item.dart';
import 'filterby_quina_items_screen.dart';

class QuinaproductsScreen extends StatefulWidget {
  const QuinaproductsScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _QuinaproductsScreen();
  }
}

class _QuinaproductsScreen extends State<QuinaproductsScreen> {
  final QueenController controller = Get.put(QueenController());

  @override
  void initState() {
    super.initState();
    controller.getQueenDataController(currentPage: 1);
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
                    ? SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              AppImages.queenaCryingImage,
                              height: MediaQuery.of(context).size.height / 4,
                            ),
                            5.ph,
                            Text(
                              tr('no_items'),
                              style: TextStyle(
                                color: AppColors.kBlackColor,
                                fontSize: 29.78.sp,
                                fontFamily: 'TheSans',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            5.ph,
                            Text(
                              tr('no_items2'),
                              style: TextStyle(
                                color: AppColors.kGreyBlueColor,
                                fontSize: 19.78.sp,
                                fontFamily: 'TheSans',
                                fontWeight: FontWeight.w400,
                              ),
                              textAlign: TextAlign.center,
                            )
                          ],
                        ),
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
                                  onTap: () {
                                    Get.to(const FilterByQuinaItemsContainer());
                                  },
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
                                    fontFamily: kTheArabicSansLight,
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
                                controller.getQueenDataController();
                              },
                            )
                          }
                        ],
                      ),
          )),
    );
  }
}
