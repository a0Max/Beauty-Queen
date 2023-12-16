import 'package:beauty_queen/const/colors.dart';
import 'package:beauty_queen/const/images.dart';
import 'package:beauty_queen/const/styles.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:geekyants_flutter_gauges/geekyants_flutter_gauges.dart';
import 'package:get/get.dart';
import '../../const/app_colors.dart';
import '../../const/vars.dart';
import '../../controller/brands_controller/brands_controller.dart';
import '../../models/sales_products_model.dart';
import '../../widgets/based/CustomAppBar.dart';
import '../../widgets/product_profile/CustomCardWidget.dart';
import '../../widgets/drawer/CustomEndDrawer.dart';
import '../../widgets/shimmer/shimmer_item.dart';
import '../../widgets/shimmer/shimmer_slider.dart';
import 'filterby_category_screen.dart';

class BrandDetailScreen extends StatefulWidget {
  final int brandId;
  const BrandDetailScreen({super.key, required this.brandId});

  @override
  State<BrandDetailScreen> createState() => _BrandDetailScreenState();
}

class _BrandDetailScreenState extends State<BrandDetailScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isScrolled = false;
  double searchBarWidth = 1.0;
  double searchBarTranslationX = 0.0;
  double searchBarTranslationY = 0.0;
  final ScrollController _scrollController = ScrollController();
  BrandsController controller = Get.put(BrandsController());

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    controller.getDetailsOfBrand(idOfBrand: widget.brandId, currentPage:1);
  }

  void _scrollListener() {
    if (_scrollController.offset > 0 && !_isScrolled) {
      setState(() {
        _isScrolled = true;
        searchBarWidth = 0.75;
        searchBarTranslationX = 50.0;
        searchBarTranslationY = -52.0;
      });
    } else if (_scrollController.offset <= 0 && _isScrolled) {
      setState(() {
        _isScrolled = false;
        searchBarWidth = 1.0;
        searchBarTranslationX = 0.0;
        searchBarTranslationY = 0.0;
      });
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(_isScrolled?100.h:160.h),
        child: CustomAppBar(
          showBagIcon2: false,
          showarrowIcon: true,
          onPressed: () {
            // Handle the button click here, e.g., open the end drawer.
            scaffoldKey.currentState?.openEndDrawer();
          },
          isScrolled: _isScrolled,
          // Replace with your variable for scroll state
          searchBarWidth: searchBarWidth, // Replace with your desired width
          searchBarTranslationY: searchBarTranslationY,
          searchBarTranslationX: searchBarTranslationX,
          // Replace with your desired translation value
        ),
      ),
      endDrawer: const MyEndDrawer(),
      body: Obx(()=>SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            SizedBox(
              height: 16.h,
            ),
            controller.isLoading.value == true
                ? ShimmerSlider(
              height: 70.h,
            )
                :(controller.generalSearchData.value.brand?.logo!=null)?
            Container(
              height: 70.h,
              width: MediaQuery.of(context).size.width,
              color: Color(int.parse(
                  "ff${controller.generalSearchData.value.brand?.logoBackground?.toUpperCase().replaceAll('#', '') ?? ''}",
                  radix: 16)),
              child: CachedNetworkImage(imageUrl: Connection.urlOfBrands3(image:controller.generalSearchData.value.brand?.logo??'')),
            ):const SizedBox(),
            SizedBox(
              height: 16.h,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 15.w),
              child:             HtmlWidget(controller.generalSearchData.value.brand?.shortDescription??''),
            ),

            SizedBox(
              height: 61.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              child: Row(
                children: [
                  Container(
                    height: 39.76.h,
                    width: 180.w,
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.kPrimaryColor, width: 1.5.w),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: DropdownButton<String>(
                            iconEnabledColor: Colors.transparent,
                            isDense: true,
                            isExpanded: true,
                            alignment: Alignment.center,
                            value: controller.valueSort.value == ''
                                ? null
                                : controller.valueSort.value,
                            items: SortTypes.listOfTTypesOfSort.values
                                .map((value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value,
                                    style: TextStyle(
                                      color: AppColors.kBlackColor,
                                      fontSize: 14.sp,
                                      fontFamily: kTheArabicSansLight,
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
                                      newKeySort: key, newValueSort: value, idOfBrand: widget.brandId);
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
                          child: Image.asset(ksortIconImage),
                        ),
                      ],
                    ),
                  ),
                  //////////////second///////////////
                  Container(
                    height: 39.76.h,
                    width: 180.w,
                    decoration: BoxDecoration(
                      border: Border.all(color: kPrimaryColor, width: 1.5.w),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.to( FilterByBrandsContainer(brandId: widget.brandId,));
                          },
                          child: Text(tr('filter_result'),
                              style: TextStyle(
                                color: kBlackColor,
                                fontSize: 18.sp,
                                fontFamily: kTheArabicSansLight,
                                fontWeight: FontWeight.w400,
                                height: 0,
                              )),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 3.w),
                          child: Image.asset(kfilterIconImage),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 19.h,
            ),
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: EdgeInsets.only(right: 17.h),
                child: Text(
                    '${tr('count_items')}: ${controller.generalSearchData.value.products?.total ?? ''}',
                    style: const TextStyle(
                      fontFamily: kTheArabicSansLight,
                      color: AppColors.kGrayColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                    )),
              ),
            ),
            controller.isLoading.value == true
                ? Wrap(
              runSpacing: 7,
              children:
              List.generate(2, (index) => const ShimmerItem()),
            )
                :
            Wrap(
              runSpacing: 7,
              children: List.generate(
                  controller.generalSearchData.value.products?.data?.length??0,
                      (index) => CustomCardWidget(
                    imageUrl: Connection.urlOfProducts(
                        image: controller
                            .generalSearchData.value.products?.data?[index].mainImage ??
                            ''),
                    newArrival: controller.generalSearchData.value.products?.data?[index] ??
                        SalesProductsModel(),
                        onLikeTap: (){
                          controller.updateToLike(index:index);


                      },
                  )),
            ),

            if (controller.dataProducts.value.isNotEmpty)...{
              Text('${tr('result')}: ${controller.dataProducts.value
                  .length} ${tr('to')} ${controller.generalSearchData.value
                  .products?.total}'),
              const SizedBox(height: 10,),
              SizedBox(
                width: MediaQuery
                    .of(context)
                    .size
                    .width / 2,
                height: 30,
                child: LinearGauge(
                  gaugeOrientation: GaugeOrientation.horizontal,
                  start: 0,
                  end: double.parse(
                      "${controller.generalSearchData.value
                          .products?.total ??
                          1}"),
                  valueBar: [
                    ValueBar(
                        value: double.parse("${controller.dataProducts
                            .value.length}"),
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
                  controller.getDetailsOfBrand(idOfBrand: widget.brandId);
                },
                child: Container(
                  // height: 59.70.h,
                  padding: EdgeInsets.symmetric(vertical: 10.h),
                  width: MediaQuery
                      .of(context)
                      .size
                      .width / 2,
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
            // SizedBox(
            //   height: 50.h,
            // ),
          ],
        ),
      )),
    );
  }
}
