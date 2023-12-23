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
import '../../widgets/product_profile/CustomCardWidget.dart';
import '../../widgets/shimmer/shimmer_item.dart';
import '../discount/filterby_screen.dart';
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
                                Container(
                                  height: 39.76.h,
                                  width: 180.w,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: AppColors.kPrimaryColor,
                                        width: 1.5.w),
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: DropdownButton<String>(
                                          iconEnabledColor: Colors.transparent,
                                          isDense: true,
                                          isExpanded: true,
                                          alignment: Alignment.center,
                                          value:
                                              controller.valueSort.value == ''
                                                  ? null
                                                  : controller.valueSort.value,
                                          items: SortTypes
                                              .listOfTTypesOfSort.values
                                              .map((value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(value,
                                                  style: TextStyle(
                                                    color:
                                                        AppColors.kBlackColor,
                                                    fontSize: 14.sp,
                                                    fontFamily:
                                                        kTheArabicSansLight,
                                                    fontWeight: FontWeight.w400,
                                                    height: 0,
                                                  )),
                                            );
                                          }).toList(),
                                          onChanged: (String? newValue) {
                                            SortTypes.listOfTTypesOfSort
                                                .forEach((key, value) {
                                              if (value == newValue) {
                                                controller.updateSortType(
                                                    newKeySort: key,
                                                    newValueSort: value);
                                              }
                                            });
                                          },
                                          hint: Text(tr('classificationBy'),
                                              style: TextStyle(
                                                color: AppColors.kBlackColor,
                                                fontSize: 18.sp,
                                                fontFamily: kTheArabicSansLight,
                                                fontWeight: FontWeight.w400,
                                                height: 0,
                                              )),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 3.w),
                                        child: SvgPicture.asset(
                                            AppImages.sortTypeImage),
                                      ),
                                    ],
                                  ),
                                ),
                                //////////////second///////////////
                                Container(
                                    height: 39.76.h,
                                    width: 180.w,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: AppColors.kPrimaryColor,
                                          width: 1.5.w),
                                    ),
                                    child: GestureDetector(
                                      onTap: () {
                                        Get.to(
                                            const FilterByQuinaItemsContainer());
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Text(tr('filter_result'),
                                              style: TextStyle(
                                                color: AppColors.kBlackColor,
                                                fontSize: 18.sp,
                                                fontFamily: kTheArabicSansLight,
                                                fontWeight: FontWeight.w400,
                                                height: 0,
                                              )),
                                          Padding(
                                            padding: EdgeInsets.only(left: 3.w),
                                            // child: Image.asset(kfilterIconImage),
                                            child: SvgPicture.asset(
                                                AppImages.filterTypeImage),
                                          ),
                                        ],
                                      ),
                                    )),
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
                                      imageUrl: Connection.urlOfProducts(
                                          image: controller.dataProducts
                                                  .value[index].mainImage ??
                                              ''),
                                      newArrival: controller
                                              .dataProducts.value[index] ??
                                          SalesProductsModel(),
                                      favorite: controller.dataProducts
                                              .value[index].isAddedToWishlist ??
                                          false,
                                    )),
                          ),
                          if (controller.dataProducts.value.isNotEmpty) ...{
                            const SizedBox(
                              height: 40,
                            ),
                            Text(
                                '${tr('result')}: ${controller.dataProducts.value.length} ${tr('to')} ${controller.generalSearchData.value.products?.total ?? 0}'),
                            const SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 2,
                              height: 30,
                              child: LinearGauge(
                                gaugeOrientation: GaugeOrientation.horizontal,
                                start: 0,
                                end: double.parse(
                                    "${controller.generalSearchData.value.products?.total ?? 1}"),
                                valueBar: [
                                  ValueBar(
                                      value: double.parse(
                                          "${controller.dataProducts.value.length}"),
                                      color: AppColors.mainColor,
                                      borderRadius: 15,
                                      valueBarThickness: 10)
                                ],
                                linearGaugeBoxDecoration:
                                    const LinearGaugeBoxDecoration(
                                        backgroundColor: AppColors.kShadowColor,
                                        thickness: 10,
                                        borderRadius: 15),
                                rulers: RulerStyle(
                                  rulerPosition: RulerPosition.center,
                                  showLabel: false,
                                  showSecondaryRulers: false,
                                  showPrimaryRulers: false,
                                  secondaryRulersHeight: 0,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                controller.getQueenDataController();
                              },
                              child: Container(
                                // height: 59.70.h,
                                padding: EdgeInsets.symmetric(vertical: 10.h),
                                width: MediaQuery.of(context).size.width / 2,
                                decoration: ShapeDecoration(
                                  color: AppColors.kPrimaryColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.84),
                                  ),
                                ),
                                child: Center(
                                  child: Text(tr('showMore'),
                                      style: TextStyle(
                                          fontSize: 22.11.sp,
                                          fontWeight: FontWeight.w400,
                                          color: AppColors.kWhiteColor,
                                          fontFamily: kTheArabicSansLight)),
                                ),
                              ),
                            )
                          }
                        ],
                      ),
          )),
    );
  }
}
