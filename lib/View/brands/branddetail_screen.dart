import 'package:beauty_queen/const/colors.dart';
import 'package:beauty_queen/const/images.dart';
import 'package:beauty_queen/const/styles.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import '../../const/app_colors.dart';
import '../../const/vars.dart';
import '../../controller/brands_controller/brands_controller.dart';
import '../../models/sales_products_model.dart';
import '../../widgets/CustomAppBar.dart';
import '../../widgets/CustomCardWidget.dart';
import '../../widgets/CustomEndDrawer.dart';
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

            Container(
              height: 70.h,
              width: MediaQuery.of(context).size.width,
              color: Color(int.parse(
                  "ff${controller.generalSearchData.value.brand?.logoBackground?.toUpperCase().replaceAll('#', '') ?? ''}",
                  radix: 16)),
              child: CachedNetworkImage(imageUrl: Connection.urlOfBrands3(image:controller.generalSearchData.value.brand?.logo??'')),
            ),
            CachedNetworkImage(imageUrl: Connection.urlOfBrands3(image:controller.generalSearchData.value.brand?.mobileSlides?.first.file??'')),
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
                          child: Text('فلترة النتائج',
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
                    'عدد المنتجات: ${controller.generalSearchData.value.products?.total ?? ''}',
                    style: const TextStyle(
                      fontFamily: kTheArabicSansLight,
                      color: AppColors.kGrayColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                    )),
              ),
            ),

            Wrap(
              runSpacing: 7,
              children: List.generate(
                  controller.dataProducts.value.length,
                      (index) => CustomCardWidget(
                    imageUrl: Connection.urlOfProducts(
                        image: controller
                            .dataProducts.value[index].mainImage ??
                            ''),
                    newArrival: controller.dataProducts.value[index] ??
                        SalesProductsModel(),
                  )),
            ),
            SizedBox(
              height: 50.h,
            ),
          ],
        ),
      )),
    );
  }
}
