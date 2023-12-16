import 'package:beauty_queen/View/product_profile/tab_screen_one.dart';
import 'package:beauty_queen/const/app_images.dart';
// import 'package:beauty_queen/const/colors.dart';
import 'package:quiver/strings.dart';
import 'package:beauty_queen/const/styles.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../const/app_colors.dart';
import '../../const/vars.dart';
import '../../controller/product_controller/product_profile_controller.dart';
import '../../models/options_model.dart';
import '../../models/sales_products_model.dart';
import '../../widgets/product_profile/CustomCardWidget.dart';
import '../../widgets/product_profile/custom_color_container.dart';
import '../../widgets/product_profile/details_static.dart';
import '../../widgets/shimmer/shimmer_profile.dart';
import 'tab_screen_two.dart';

class ItemProfilePage extends StatefulWidget {
  final int itemId;
  const ItemProfilePage({super.key, required this.itemId});

  @override
  State<ItemProfilePage> createState() => _ItemProfilePageState();
}

class _ItemProfilePageState extends State<ItemProfilePage> {
  final ProductProfileController controller =
      Get.put(ProductProfileController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getDataOfProduct();
    });
  }

  final ScrollController scrollController = ScrollController();

  getDataOfProduct() async {
    await controller.getCurrentProduct(productId: widget.itemId);
  }

  // String? selectedDropdownItem;

  @override
  Widget build(BuildContext context) {
    return PopScope(
        canPop:true,
        onPopInvoked:(val){
          controller.removeLast();
        },
      child: Scaffold(
        body: Obx(() => Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 43.h,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Column(
                            children: [
                              Align(
                                alignment: Alignment.topLeft,
                                child: IconButton(
                                    onPressed: () {
                                      Get.back();
                                    },
                                    icon: Icon(
                                      Icons.arrow_forward_ios_sharp,
                                      size: 25.r,
                                    )),
                              ),

                              controller.isLoading.value == true?
                              const ShimmerProfile()
                                  :(controller.productData.isNotEmpty ??false)?
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                      width: MediaQuery.of(context).size.width,
                                      alignment: Alignment.topRight,
                                      child: Wrap(children: [
                                        Text('${tr('sections')} / ',
                                          style: TextStyle(
                                            fontFamily: kTheArabicSansLight,
                                            color: AppColors.kGrayColor,
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w400,

                                          ),maxLines: 2,overflow: TextOverflow.visible,),
                                        ...List.generate(
                                          controller.productData.value.last.product?.category
                                              ?.length ??
                                              0,
                                              (index) => ((controller
                                              .productData
                                              .value.last
                                              .product
                                              ?.category
                                              ?.length ??
                                              0) -
                                              1) !=
                                              index
                                              ? Text(
                                              '${controller.productData.value.last.product?.category?[index].title ?? ''} / ',
                                              style: TextStyle(
                                                fontFamily: kTheArabicSansLight,
                                                color: AppColors.kGrayColor,
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.w400,
                                              ))
                                              : Text(
                                            '${controller.productData.value.last.product?.category?[index].title ?? ''} ',
                                            style: TextStyle(
                                              fontFamily: kTheArabicSansLight,
                                              color: AppColors.kBlackColor,
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        )
                                      ])),
                                  SizedBox(
                                    height: 43.h,
                                  ),
                                  CarouselSlider(
                                      options: CarouselOptions(
                                        height: 258.48.h,
                                        enableInfiniteScroll: false,
                                        onPageChanged: (index, reason) {
                                          // controller.update();
                                          controller.changeSliderIndex(index);
                                        },
                                      ),
                                      items: List.generate(
                                          controller.productData.value.last.product
                                              ?.getCurrentImages()
                                              .length ??
                                              0,
                                              (index) => CachedNetworkImage(
                                              imageUrl: controller
                                                  .productData.value.last.product
                                                  ?.getCurrentImages()[index] ??
                                                  '',
                                              width: 258.48.w,
                                              height: 258.48.h,
                                              fit: BoxFit.cover))),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: List.generate(
                                        controller.productData.value.last.product
                                            ?.getCurrentImages()
                                            .length ??
                                            0,
                                            (index) => Container(
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 6),
                                          height:
                                          controller.selectedSliderIndex.value ==
                                              index
                                              ? 13
                                              : 10,
                                          width:
                                          controller.selectedSliderIndex.value ==
                                              index
                                              ? 13
                                              : 10,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: controller
                                                  .selectedSliderIndex.value ==
                                                  index
                                                  ? AppColors.kPinkColor
                                                  : AppColors.klPinkColor),
                                        )),
                                  ),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  (controller.productData?.value?.last?.product?.offerPrice!=null ??false)?
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        controller.productData.value.last.product?.brand
                                            ?.title ??
                                            '',
                                        style: TextStyle(
                                            fontFamily: kTheArabicSansLight,
                                            fontSize: 17.sp,
                                            fontWeight: FontWeight.w700,
                                            color: AppColors.kPrimaryColor),
                                      ),
                                      if ((controller.selectedOptions.value.isNotEmpty)&& controller.selectedOptions.value.first!=null)...{
                                        Text(
                                          "${controller.selectedOptions.value.first.price} ${tr('Del')} ",
                                          style: TextStyle(
                                              fontFamily: kTheArabicSansLight,
                                              fontSize: 15.sp,
                                              fontWeight: FontWeight.w400,
                                              color: AppColors.kPrimaryColor),
                                        ),
                                      }else ...{
                                        if (controller.productData.value.last.product.offerPrice != null &&
                                            controller.productData.value.last.product.offerPrice  != '' &&
                                            controller.productData.value.last.product.offerPrice  != '' &&
                                            controller.productData.value.last.product.offerPrice?.split('').first !=
                                                '0') ...{
                                          SizedBox(
                                              width: (MediaQuery.of(context).size.width / 2) - 40,
                                              child:Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [


                                                      Text(
                                                        "${controller.productData.value.last.product.price ?? ''} ${tr('Del')}",
                                                        textAlign: TextAlign.right,
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 15.16.sp,
                                                          fontFamily: kTheArabicSansLight,
                                                          fontWeight: FontWeight.w400,
                                                          decoration: TextDecoration.lineThrough,
                                                          height: 0.08,
                                                        ),
                                                      ),



                                                      Text(
                                                        "${controller.productData.value.last.product.offerPrice ?? ''}${tr('Del')}",
                                                        textAlign: TextAlign.right,
                                                        style: TextStyle(
                                                          color: const Color(0xFFDE0F7E),
                                                          fontSize: 15.16.sp,
                                                          fontFamily: kTheArabicSansLight,
                                                          fontWeight: FontWeight.w400,
                                                          height: 0.08,
                                                        ),
                                                      ),


                                                ],
                                              ))

                                        }
                                        else...{

                                              Text(
                                                "${controller.productData.value.last.product.price ?? ''}${tr('Del')}",
                                                textAlign: TextAlign.right,
                                                style: TextStyle(
                                                  color: const Color(0xFFDE0F7E),
                                                  fontSize: 15.16.sp,
                                                  fontFamily: kTheArabicSansLight,
                                                  fontWeight: FontWeight.w400,
                                                  height: 0.08,
                                                ),
                                              ),


                                        }
                                        // if (isBlank(controller.productData.value.last
                                        //     .getMinMax()
                                        //     .first) && controller.productData.value.last
                                        //     .getMinMax()
                                        //     .first != '')...{
                                        //   Text(
                                        //     "${controller.productData.value.last
                                        //         .getMinMax()
                                        //         .first} ${tr('Del')} ",
                                        //     style: TextStyle(
                                        //         fontFamily: kTheArabicSansLight,
                                        //         decoration: TextDecoration
                                        //             .lineThrough,
                                        //         fontSize: 15.sp,
                                        //         fontWeight: FontWeight.w400,
                                        //         color: AppColors.kBlackColor),
                                        //   ),
                                        // },
                                        // Text(
                                        //   "${controller.productData.value.last
                                        //       .getMinMax()
                                        //       .last} ${tr('Del')} ",
                                        //   style: TextStyle(
                                        //       fontFamily: kTheArabicSansLight,
                                        //       fontSize: 15.sp,
                                        //       fontWeight: FontWeight.w400,
                                        //       color: AppColors.kPrimaryColor),
                                        // ),
                                      }
                                    ],
                                  ):SizedBox(),
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: Text(
                                      controller.productData.value.last.product?.title ?? '',
                                      style: TextStyle(
                                          fontFamily: kTheArabicSansLight,
                                          fontSize: 17.sp,
                                          fontWeight: FontWeight.w700,
                                          color: AppColors.kBlackColor),
                                    ),
                                  ),

                                ],
                              ):SizedBox(),
                              SizedBox(
                                height: 27.h,
                              ),
                              // ///////////container//////////
                              (controller.productData.isNotEmpty ??false)?
                              SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: List.generate(
                                      controller.productData.value.last.productOptions
                                              ?.length ??
                                          0,
                                      (index) => Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              if(controller.productData.value.last.productOptions?[index].title == TypeOfOptions.color)...{
                                                Wrap(
                                                spacing: 10,
                                                runSpacing: 10,
                                                alignment: WrapAlignment.start,
                                                children: List.generate(
                                                    controller
                                                            .productData
                                                            .value.last
                                                            .productOptions?[index]
                                                            .options
                                                            ?.length ??
                                                        0,
                                                    (index2) => ColorContainer(
                                                          height: 50.h,
                                                          width: 50.w,
                                                          currentId: controller.productData.value.last.productOptions?[index].options?[index2].id,
                                                          selectedId: controller.selectedOptions[index]==null?0:controller.selectedOptions[index].id??0,
                                                          color: Color(int.parse(
                                                              "ff${controller.productData.value.last.productOptions?[index].options?[index2].color?.toUpperCase().replaceAll('#', '') ?? ''}",
                                                              radix: 16)),
                                                          onClick: () {
                                                            controller.updateToSelected(index: index, selected: controller.productData.value.last.productOptions?[index].options?[index2]);
                                                          },
                                                        )),
                                              ),
                                                const SizedBox(height: 10,),
                                                DropdownButtonFormField<OptionsModel>(
                                                  isExpanded: true,

                                                  decoration: InputDecoration(
                                                    labelText: controller
                                                        .productData
                                                        .value.last
                                                        .productOptions?[index].title,
                                                    filled: true,
                                                    fillColor: Colors.white,
                                                    border: const OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: Colors.black,

                                                        ),
                                                        borderRadius: BorderRadius.zero
                                                    ),
                                                    focusedBorder: const OutlineInputBorder(
                                                      borderRadius: BorderRadius.zero,
                                                      borderSide: BorderSide(
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ),
                                                  onChanged: (selectedItem) {
                                                    controller.updateToSelected(index: index, selected: selectedItem);

                                                  },
                                                  value: controller.selectedOptions[index],
                                                  items: controller.productData.value.last.productOptions?[index].options?.map<DropdownMenuItem<OptionsModel>>((value) {
                                                    return DropdownMenuItem<OptionsModel>(
                                                      value: value,
                                                      child: Row(
                                                        children: [
                                                          Container(
                                                              width: 20.w,
                                                              height: 20.h,
                                                              decoration:  BoxDecoration(
                                                                shape: BoxShape.circle,
                                                                image: DecorationImage(image: CachedNetworkImageProvider(Connection.urlOfOptions(image: value.mainImage?.file??''))
                                                                ),
                                                              )
                                                          ),
                                                          Padding(
                                                            padding: EdgeInsets.all(8.r),
                                                          ),
                                                          Text("${value.title} "),
                                                        ],
                                                      ),
                                                    );
                                                  }).toList(),
                                                ),
                                              }
                                              else ...{
                                                Wrap(
                                                  spacing: 10,
                                                  runSpacing: 10,
                                                  alignment: WrapAlignment.start,
                                                  children: List.generate(
                                                      controller
                                                          .productData
                                                          .value.last
                                                          .productOptions?[index]
                                                          .options
                                                          ?.length ??
                                                          0,
                                                          (index2) => TextContainer(
                                                        height: 50.h,
                                                        width: 50.w,
                                                            currentId: controller.productData.value.last.productOptions?[index].options?[index2].id,
                                                            selectedId: controller.selectedOptions[index]==null?0:controller.selectedOptions[index].id??0,
                                                            text: controller.productData.value.last.productOptions?[index].options?[index2].size,

                                                        onClick: () {
                                                          controller.updateToSelected(index: index, selected: controller.productData.value.last.productOptions?[index].options?[index2]);
                                                        },
                                                      )),
                                                ),
                                                const SizedBox(height: 10,),
                                                DropdownButtonFormField<OptionsModel>(
                                                  isExpanded: true,

                                                  decoration: InputDecoration(
                                                    labelText: controller
                                                        .productData
                                                        .value.last
                                                        .productOptions?[index].title,
                                                    filled: true,
                                                    fillColor: Colors.white,
                                                    border: const OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: Colors.black,

                                                      ),
                                                      borderRadius: BorderRadius.zero
                                                    ),
                                                    focusedBorder: const OutlineInputBorder(
                                                    borderRadius: BorderRadius.zero,
                                                      borderSide: BorderSide(
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ),
                                                  onChanged: (selectedItem) {
                                                    controller.updateToSelected(index: index, selected: selectedItem);

                                                  },
                                                  value: controller.selectedOptions[index],
                                                  items: controller.productData.last?.productOptions?[index]?.options?.map<DropdownMenuItem<OptionsModel>>((OptionsModel value) {
                                                    return DropdownMenuItem<OptionsModel>(
                                                      value: value,
                                                      child: Row(
                                                        children: [
                                                          Container(
                                                              width: 20.w,
                                                              height: 20.h,
                                                              decoration:  BoxDecoration(
                                                                shape: BoxShape.circle,
                                                                image: DecorationImage(image: CachedNetworkImageProvider(Connection.urlOfOptions(image: value.mainImage?.file??''))
                                                                ),
                                                              )
                                                          ),
                                                          Padding(
                                                            padding: EdgeInsets.all(8.r),
                                                          ),
                                                          Text("${value.title} "),
                                                        ],
                                                      ),
                                                    );
                                                  }).toList(),
                                                ),}
                                            ],
                                          )),
                                ),
                              ):SizedBox(),
                              SizedBox(
                                height: 17.h,
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: Wrap(
                                  alignment:WrapAlignment.start,
                                  spacing: 10.w,
                                  children: [
                                    SizedBox(
                                      width: 60.w,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.all(5),
                                            width: 50.w,
                                            height: 50.h,
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                border: Border.all(color: AppColors.kCDGColor2)

                                            ),
                                            child: SvgPicture.asset(AppImages.imageNewItem),
                                          ),
                                          Text(tr('newْnusedProduct'), style: const TextStyle(fontSize: 12),textAlign: TextAlign.center,)
                                        ],
                                      ),
                                    ),

                                    SizedBox(
                                      width: 60.w,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.all(5),
                                            width: 50.w,
                                            height: 50.h,
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                border: Border.all(color: AppColors.kCDGColor2)

                                            ),
                                            child: SvgPicture.asset(AppImages.imageOriginalItem),
                                          ),
                                          Text(tr('original'), style: const TextStyle(fontSize: 12),textAlign: TextAlign.center,)
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 17.h,
                              ),
                              DetailsStatic(title: tr('Free_delivery_service'), body: tr('Free_delivery_service2'), icon: AppImages.imageFreeDelivery,),
                              DetailsStatic(title: tr('Prompt_same_day_delivery'), body: tr('Prompt_same_day_delivery2'), icon: AppImages.imageDelivery,),
                              DetailsStatic(title: tr('Free_gifts_and_samples_with_your_order'), body: tr('Free_gifts_and_samples_with_your_order2'), icon: AppImages.imageGift,),
                              DetailsStatic(title: tr('customers_service'), body: tr('customers_service2'), icon: AppImages.imageArtboard,isPhone:true),
                              const SizedBox(height: 10,),
                              TabBar(
                                tabs: [
                                  Tab(
                                    icon: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        SvgPicture.asset(AppImages.imageDetails),
                                        SizedBox(
                                          width: 10.w,
                                        ),
                                        Text(
                                          tr('details_product'),
                                          style: TextStyle(
                                              fontFamily: kTheArabicSansLight,
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w400,
                                              color: AppColors.kBlackColor),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Tab(
                                    icon: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        SvgPicture.asset(AppImages.imageRate),
                                        SizedBox(
                                          width: 10.w,
                                        ),
                                        Text(
                                          tr('rate'),
                                          style: TextStyle(
                                              fontFamily: kTheArabicSansLight,
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w400,
                                              color: AppColors.kBlackColor),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                                controller: controller.tabsController,
                                indicatorColor: AppColors.kPrimaryColor,
                              ),
                             controller.index.value == 0
                                  ? (controller.productData.isNotEmpty ??false)?TabScreenOne():SizedBox()
                                  : TabScreenTwo(),
                              //////////////////////////////////
                              SizedBox(
                                height: 10.h,
                              ),
                              Divider(
                                thickness: 1.w,
                                color: AppColors.kTextGrayColor,
                              ),
                              SizedBox(
                                height: 27.h,
                              ),
                              (controller.productData.isNotEmpty ??false)?
                              CachedNetworkImage(imageUrl: Connection.urlOfStorage(image: controller.productData.value.last.product_banner?.file??''),):SizedBox(),
                              SizedBox(
                                height: 32.h,
                              ),

                              ])),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 15),
                              child: Text(
                                tr('related_product'),
                                style: TextStyle(
                                    fontFamily: kTheArabicSansLight,
                                    fontSize: 17.sp,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.kPrimaryColor),
                              ),
                            ),
                            (controller.productData.isNotEmpty ??false)?CarouselSlider(
                                options: CarouselOptions(
                                  viewportFraction:
                                  1.0, // Set to 1.0 for full width current page
                                  aspectRatio: 1.0,
                                  autoPlay: true,
                                  enlargeCenterPage:
                                  true, // Make the current page full width
                                ),
                                items: List.generate(
                                    ((controller
                                        .productData
                                        .value.last
                                        .p
                                        ?.length ??
                                        0) /
                                        2)
                                        .roundToDouble()
                                        .toInt(), (index) {
                                  int value = index * 2;
                                  return Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      CustomCardWidget(
                                        // width: (MediaQuery.of(context).size.width / 2) - 40,
                                        imageUrl: Connection.urlOfProducts(
                                            image: controller
                                                .productData
                                                .value.last
                                                .p?[value]
                                                .mainImage ??
                                                ''),
                                        newArrival:controller
                                            .productData
                                            .value.last
                                            .p?[value]??SalesProductsModel(),
                                        favorite: controller
                                            .productData
                                            .value.last
                                            .p?[value].wishlist?.isNotEmpty??false,
                                      ),
                                      if ((controller
                                          .productData.value.last
                                          .p?.length ??
                                          0) >
                                          value + 1) ...{
                                        CustomCardWidget(
                                          // width: (MediaQuery.of(context).size.width / 2) - 40,
                                          imageUrl:
                                          Connection.urlOfProducts(
                                              image: controller
                                                  .productData
                                                  .value.last
                                                  .p?[
                                              value + 1]
                                                  .mainImage ??
                                                  ''),

                                          newArrival: controller
                                              .productData
                                              .value.last
                                              .p?[value+1]??SalesProductsModel(),
                                          favorite: controller
                                              .productData
                                              .value.last
                                              .p?[value+1].wishlist?.isNotEmpty??false,
                                        )
                                      }
                                    ],
                                  );
                                })):SizedBox()
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 15),
                              child: Text(
                                tr('same_brand'),
                                style: TextStyle(
                                    fontFamily: kTheArabicSansLight,
                                    fontSize: 17.sp,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.kPrimaryColor),
                              ),
                            ),
                            (controller.productData.isNotEmpty ??false)?CarouselSlider(
                                options: CarouselOptions(
                                  viewportFraction:
                                  1.0, // Set to 1.0 for full width current page
                                  aspectRatio: 1.0,
                                  autoPlay: true,
                                  enlargeCenterPage:
                                  true, // Make the current page full width
                                ),
                                items: List.generate(
                                    ((controller
                                        .productData
                                        .value.last
                                        .sameBrandProducts
                                        ?.length ??
                                        0) /
                                        2)
                                        .roundToDouble()
                                        .toInt(), (index) {
                                  int value = index * 2;
                                  return Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      CustomCardWidget(
                                        // width: (MediaQuery.of(context).size.width / 2) - 40,
                                        imageUrl: Connection.urlOfProducts(
                                            image: controller
                                                .productData
                                                .value.last
                                                .sameBrandProducts?[value]
                                                .mainImage ??
                                                ''),
                                        newArrival:controller
                                            .productData
                                            .value.last
                                            .sameBrandProducts?[value]??SalesProductsModel(),
                                        favorite: controller
                                            .productData
                                            .value.last
                                            .sameBrandProducts?[value].wishlist?.isNotEmpty??false,
                                      ),
                                      if ((controller
                                          .productData.value.last
                                          .sameBrandProducts?.length ??
                                          0) >
                                          value + 1) ...{
                                        CustomCardWidget(
                                          // width: (MediaQuery.of(context).size.width / 2) - 40,
                                          imageUrl:
                                          Connection.urlOfProducts(
                                              image: controller
                                                  .productData
                                                  .value.last
                                                  .sameBrandProducts?[
                                              value + 1]
                                                  .mainImage ??
                                                  ''),
                                          newArrival: controller
                                              .productData
                                              .value.last
                                              .sameBrandProducts?[value+1]??SalesProductsModel(),
                                          favorite: controller
                                              .productData
                                              .value.last
                                              .sameBrandProducts?[value+1].wishlist?.isNotEmpty??false,
                                        )
                                      }
                                    ],
                                  );
                                })):SizedBox()
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                      Container(
                        height: 100.h,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(color: AppColors.kWhiteColor, boxShadow: [
                          BoxShadow(
                            color: const Color.fromARGB(32, 0, 0, 0),
                            blurRadius: 28.r,
                            offset: const Offset(0, 4),
                            spreadRadius: 0,
                          ),
                        ]),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                           Row(
                             children: [
                               GestureDetector(
                                 onTap: () {
                                   // for(dynamic selected in controller.selectedOptions){
                                   //   if (selected==null) {
                                   //     showDialog(
                                   //         context: context,
                                   //         builder: (BuildContext context) {
                                   //           return CustomAlertDialog(
                                   //             buttonTwo:false,
                                   //             dilougText:tr('chooseOptionFirst'),
                                   //             buttonOneText: tr('okay'),
                                   //           );
                                   //         });
                                   //     return;
                                   //   }
                                   // }
                                   controller.decrement();
                                 },
                                 child: Container(
                                     height: 47.61.h,
                                     width: 49.08.w,
                                     color: AppColors.kPrimaryColor,
                                     child: Center(
                                       child: Text(
                                         '-',
                                         style: TextStyle(
                                             color: AppColors.kWhiteColor,
                                             fontSize: 30.sp,
                                             fontWeight: FontWeight.w500),
                                       ),
                                     )),
                               ),

                               Container(
                                   height: 47.61.h,
                                   width: 49.08.w,
                                   color: AppColors.kWhiteColor,
                                   child: Center(
                                     child:  Text(
                                       '${controller.count}',
                                       style: TextStyle(
                                         color: AppColors.kBlackColor,
                                         fontSize: 19.sp,
                                         fontWeight: FontWeight.w500,
                                       ),
                                     ),
                                   )),
                               GestureDetector(
                                 onTap: () {
                                   // for(dynamic selected in controller.selectedOptions){
                                   //   if (selected==null) {
                                   //     showDialog(
                                   //         context: context,
                                   //         builder: (BuildContext context) {
                                   //           return CustomAlertDialog(
                                   //             buttonTwo:false,
                                   //             dilougText:tr('chooseOptionFirst'),
                                   //             buttonOneText: tr('okay'),
                                   //           );
                                   //         });
                                   //     return;
                                   //   }
                                   // }
                                   controller.increment();
                                 },
                                 child: Container(
                                     height: 47.61.h,
                                     width: 49.08.w,
                                     color: AppColors.kPrimaryColor,
                                     child: Center(
                                       child: Icon(
                                         Icons.add,
                                         color: AppColors.kWhiteColor,
                                         size: 30.r,
                                       ),
                                     )),
                               ),
                               // SizedBox(width: 17.w),

                             ],
                           ),
                            GestureDetector(
                              onTap: () {
                                controller.addToCart();
                              },
                              child: Container(
                                  height: 47.61.h,
                                  width: MediaQuery.of(context).size.width/2,
                                  color: AppColors.kPrimaryColor,
                                  child: Center(
                                    child: Text(
                                      tr('addToCart'),
                                      style: TextStyle(
                                          fontFamily: kTheArabicSansLight,
                                          color: AppColors.kWhiteColor,
                                          fontSize: 15.89.sp,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  )),
                            ),
                          ],
                        ),
                      ),
              ],
            )),
      ),
    );
  }
}
