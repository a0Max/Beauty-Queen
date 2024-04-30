// ignore_for_file: file_names, library_private_types_in_public_api, avoid_unnecessary_containers
import 'package:beauty_queen/const/extensions.dart';
import 'package:beauty_queen/const/styles.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../const/app_colors.dart';
import '../../const/app_images.dart';
import '../../const/size.dart';
import '../../const/vars.dart';
import '../../controller/AlKasam_controller/alkasam_controller.dart';
import '../../controller/AlKasam_controller/flash_discounts_controller.dart';
import '../../controller/auth_controller/auth_controler.dart';
import '../../controller/nav_bar_controller/NavBarController.dart';
import '../../controller/home_controller/home_controller.dart';
import '../../models/sales_products_model.dart';
import '../../widgets/based/CustomAppBar.dart';
import '../../widgets/product_profile/CustomCardWidget.dart';
import '../../widgets/drawer/CustomEndDrawer.dart';
import '../../widgets/home/CustomProductCard.dart';
import '../../widgets/home/ScrollableContainerList.dart';
import '../../widgets/home/custom_horizontal_list.dart';
import '../../widgets/loading/home_loading.dart';
import '../brands/branddetail_screen.dart';
import '../categories/filter_screen.dart';
import '../categories/filter_screen2.dart';
import '../flash-discounts/flash-discounts.dart';
import '../magazine/magazine_screen.dart';
import '../new_arrived/new_arrived_screen.dart';
import '../offers/beautypharmacyscreen.dart';
import '../product_profile/products_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final HomeController _controller = Get.put(HomeController());
  final NavController _controllerNav = Get.put(NavController());
  final AuthController userController = Get.put(AuthController());

  final ScrollController _scrollController = ScrollController();
  bool _isScrolled = false;
  double searchBarWidth = 1.0;
  double searchBarHeight = 1.0;
  double searchBarTranslationX = 0.0;
  double searchBarTranslationY = 10.0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    _controller.getHomeDataController();
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
      key: _scaffoldKey,
      appBar: PreferredSize(
        preferredSize:
            userController.userData.value.accountType == AccountTypes.queena
                ? Size.fromHeight(_isScrolled ? 80.h : 145.h)
                : Size.fromHeight(_isScrolled ? 100.h : 160.h),
        child: Obx(() => CustomAppBar(
              showBagIcon: true,
              showFavIcon: true,
              showPersonIcon: true,
              onPressed: () {
                _scaffoldKey.currentState?.openEndDrawer();
              },
              isScrolled: _isScrolled,
              countCart: _controllerNav.countCart.value,
              searchBarWidth: searchBarWidth, // Replace with your desired width
              searchBarTranslationY: searchBarTranslationY,
              searchBarTranslationX: searchBarTranslationX,
              // Replace with your desired translation value
            )),
      ),
      endDrawer: const MyEndDrawer(),
      body: SingleChildScrollView(
          controller: _scrollController,
          child: Obx(
            () => _controller.isLoading.value == true
                ? homeLoading()
                : Column(
                    children: [
                      ///Slider
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: 270.h,
                            child: CarouselSlider(
                              options: CarouselOptions(
                                viewportFraction:
                                    1.0, // Set to 1.0 for full width current page
                                aspectRatio: 1.0,
                                autoPlay: true,
                                onPageChanged: (index, reason) {
                                  _controller.updateCurrentSlider(
                                      newSlider: index);
                                },
                                enlargeCenterPage:
                                    true, // Make the current page full width
                              ),
                              items: List.generate(
                                  _controller.sliders.length ?? 0,
                                  (index) => GestureDetector(
                                        onTap: () {
                                          if (_controller
                                                  .sliders[index].linkType ==
                                              LinkTypes.brand) {
                                            Get.to(BrandDetailScreen(
                                              brandId: int.parse(_controller
                                                  .sliders[index].linkId),
                                            ));
                                          } else if (_controller
                                                  .sliders[index].linkType ==
                                              LinkTypes.product) {
                                            Get.to(ItemProfilePage(
                                                itemId: int.parse(_controller
                                                    .sliders[index].linkId)));
                                          } else if (_controller
                                                  .sliders[index].linkType ==
                                              LinkTypes.category) {
                                            AlkasamController controller =
                                                Get.put(AlkasamController());
                                            controller.updateCurrentCategoryId(
                                                newId: int.parse(_controller
                                                    .sliders[index].linkId),
                                                getChild: null);
                                            Get.to(FliterScreen2(
                                              categoryId: int.parse(_controller
                                                  .sliders[index].linkId),
                                            ));
                                          }
                                        },
                                        child: CachedNetworkImage(
                                          imageUrl: Connection.urlOfSlider(
                                              image: _controller
                                                      .sliders[index].mobile ??
                                                  ''),
                                          height: 270.h,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          fit: BoxFit.fitWidth,
                                          imageBuilder:
                                              (context, imageProvider) =>
                                                  Container(
                                            height: 200,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image: imageProvider,
                                                fit: BoxFit.fitWidth,
                                              ),
                                            ),
                                          ),
                                          placeholder: (context, url) =>
                                              const SizedBox(),
                                          errorWidget: (context, url, error) =>
                                              const SizedBox(),
                                        ),
                                      )),
                              disableGesture: true,
                            ),
                          ),
                          Positioned(
                              bottom: 20,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: List.generate(
                                    _controller.sliders.length ?? 0,
                                    (index) => Container(
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 6),
                                          height:
                                              _controller.currentSlider.value ==
                                                      index
                                                  ? 13
                                                  : 10,
                                          width:
                                              _controller.currentSlider.value ==
                                                      index
                                                  ? 13
                                                  : 10,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: _controller.currentSlider
                                                          .value ==
                                                      index
                                                  ? AppColors.kWhiteColor
                                                  : AppColors.kDividerColor),
                                        )),
                              ))
                        ],
                      ),

                      ///categories
                      10.ph,
                      SizedBox(
                        height: 150.h,
                        child: CustomImageList(
                            dataOfItem:
                                _controller.homeData.value.categories ?? []),
                      ),
                      15.ph,

                      /// New Items
                      SizedBox(
                        height: 350.h,
                        child: CarouselSlider(
                            options: CarouselOptions(
                              height: 340.h,
                              viewportFraction: 0.7,
                              aspectRatio: 16 / 9,
                              enableInfiniteScroll: true,
                              reverse: false,
                              autoPlay: false,
                              scrollDirection: Axis.horizontal,
                              scrollPhysics: BouncingScrollPhysics(),
                            ),
                            items: List.generate(
                                _controller.homeData.value.newItems?.length ??
                                    0,
                                (index) => GestureDetector(
                                      onTap: () {
                                        if (_controller.homeData.value
                                                .newItems?[index].linkId !=
                                            null) {
                                          Get.to(ItemProfilePage(
                                              itemId: int.parse(_controller
                                                      .homeData
                                                      .value
                                                      .newItems?[index]
                                                      .linkId ??
                                                  '0')));
                                        }
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 9.w),
                                        child: SizedBox(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            children: [
                                              Container(
                                                width: 262.45.w,
                                                height: 262.45.h,
                                                decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                    image: CachedNetworkImageProvider(
                                                        Connection.urlOfSpecial(
                                                            image: _controller
                                                                    .homeData
                                                                    .value
                                                                    .newItems?[
                                                                        index]
                                                                    .image ??
                                                                '')),
                                                    fit: BoxFit.fill,
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                width: 262.45.w,
                                                height: 77.h,
                                                alignment: Alignment.center,
                                                decoration: const BoxDecoration(
                                                    color: AppColors
                                                        .kPrimaryColor),
                                                child: Padding(
                                                  padding: EdgeInsets.all(9.r),
                                                  child: Text(
                                                    _controller
                                                            .homeData
                                                            .value
                                                            .newItems?[index]
                                                            .description ??
                                                        '',
                                                    textAlign: TextAlign.right,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 3,
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 12.1.sp,
                                                      fontFamily:
                                                          kTheArabicSansLight,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      // height: 1.5,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ))
                            // },
                            ),
                      ),

                      ///newArrivals
                      const SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              tr('new_arrived'),
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                color: AppColors.kPrimaryColor,
                                fontSize: 21.sp,
                                fontFamily: kTheArabicSansBold,
                                fontWeight: FontWeight.w600,
                                height: 0,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Get.to(const NewArrivedScreen());
                              },
                              child: Text(
                                tr('see_all'),
                                style: TextStyle(
                                  color: AppColors.kPrimaryColor,
                                  fontFamily: kTheArabicSansLight,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16.sp,
                                  decoration: TextDecoration.underline,
                                  decorationColor: AppColors.kPrimaryColor,
                                  height: 0,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                        child: Stack(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: 0.h),
                              child: Container(
                                color: AppColors.kBorderColor.withOpacity(.2),
                                width: kScreenWidth,
                                height: 340.h < 305 ? 305 : 340.h,
                              ),
                            ),
                            SizedBox(
                              height: 340.h < 305.h ? 309.h : 349.h,
                              child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: _controller
                                        .homeData.value.newArrivals?.length ??
                                    0,
                                itemBuilder: (context, index) {
                                  return CustomCardWidget(
                                    hideTage: true,
                                    imageUrl: Connection.urlOfProducts(
                                        image: _controller
                                                .homeData
                                                .value
                                                .newArrivals?[index]
                                                .mainImage ??
                                            ''),
                                    newArrival: _controller.homeData.value
                                            .newArrivals?[index] ??
                                        SalesProductsModel(),
                                    favorite: _controller
                                            .homeData
                                            .value
                                            .newArrivals?[index]
                                            .wishlist
                                            ?.isNotEmpty ??
                                        false,
                                  );
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 15.h,
                      ),

                      ///flash_discount
                      if (_controller.homeData.value.flash_discount_status ==
                          "1") ...{
                        Container(
                          child: Stack(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  FlashDiscountsController controller =
                                      Get.put(FlashDiscountsController());
                                  controller.getCategoriesDataController(
                                      currentPage: 1);
                                  Get.to(FlashDiscountsScreen());
                                },
                                child: CachedNetworkImage(
                                  imageUrl: Connection.urlOfFlash(
                                      image: _controller.homeData.value
                                              .flash_discount_mobile_image ??
                                          ''),
                                  height: 520.h,
                                  width: MediaQuery.of(context).size.width,
                                  fit: BoxFit.fill,
                                  imageBuilder: (context, imageProvider) =>
                                      Container(
                                    height: 520.h,
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                  placeholder: (context, url) =>
                                      const SizedBox(),
                                  errorWidget: (context, url, error) =>
                                      const SizedBox(),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 420.h),
                                height: 340.h < 305 ? 305 : 350.h,
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: _controller.homeData.value
                                          .flash_discount_products?.length ??
                                      0,
                                  itemBuilder: (context, index) {
                                    return CustomCardWidget(
                                      hideTage: true,
                                      imageUrl: Connection.urlOfProducts(
                                          image: _controller
                                                  .homeData
                                                  .value
                                                  .flash_discount_products?[
                                                      index]
                                                  .mainImage ??
                                              ''),
                                      newArrival: _controller.homeData.value
                                                  .flash_discount_products?[
                                              index] ??
                                          SalesProductsModel(),
                                      favorite: _controller
                                              .homeData
                                              .value
                                              .flash_discount_products?[index]
                                              .wishlist
                                              ?.isNotEmpty ??
                                          false,
                                    );
                                  },
                                ),
                              ),
                              Positioned(
                                  top: 160.h,
                                  left: 30,
                                  child: CountdownTimer(
                                    endTime: DateTime.parse(_controller.homeData
                                                .value.flash_discount_end_at ??
                                            '')
                                        .millisecondsSinceEpoch,
                                    widgetBuilder:
                                        (context, currentRemainingTime) {
                                      return Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'ثانيه:',
                                                style: timerTextStyle.copyWith(
                                                    fontSize: 0.6 * 14),
                                              ),
                                              Text(
                                                "${currentRemainingTime?.sec ?? '00'}",
                                                style: timerTextStyle.copyWith(
                                                    fontSize: 3 * 14),
                                              ),
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              const Text(
                                                ':',
                                                style: timerTextStyle,
                                              ),
                                              10.ph,
                                            ],
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'دقيقه:',
                                                style: timerTextStyle.copyWith(
                                                    fontSize: 0.6 * 14),
                                              ),
                                              Text(
                                                "${currentRemainingTime?.min ?? '00'}",
                                                style: timerTextStyle.copyWith(
                                                    fontSize: 3 * 14),
                                              ),
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              const Text(
                                                ':',
                                                style: timerTextStyle,
                                              ),
                                              10.ph,
                                            ],
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'ساعه:',
                                                style: timerTextStyle.copyWith(
                                                    fontSize: 0.6 * 14),
                                              ),
                                              Text(
                                                "${currentRemainingTime?.hours ?? '00'}",
                                                style: timerTextStyle.copyWith(
                                                    fontSize: 3 * 14),
                                              ),
                                            ],
                                          ),
                                        ],
                                      );
                                    },
                                    onEnd: () {
                                      print('Countdown ended');
                                      // You can do something here when the countdown ends
                                    },
                                  )

                                  // CountdownTimer(
                                  //   endTime: DateTime.parse(_controller.homeData
                                  //               .value.flash_discount_end_at ??
                                  //           '')
                                  //       .millisecondsSinceEpoch,
                                  //   widgetBuilder:
                                  //       (context, currentRemainingTime) {
                                  //     return Row(
                                  //       children: [
                                  //         Column(
                                  //           children: [
                                  //             Text(
                                  //               'ثانيه:',
                                  //               style: timerTextStyle.copyWith(
                                  //                   fontSize: 15),
                                  //             ),
                                  //             Text(
                                  //               currentRemainingTime?.sec
                                  //                       .toString() ??
                                  //                   '',
                                  //               style: timerTextStyle,
                                  //             ),
                                  //           ],
                                  //         ),
                                  //         5.pw,
                                  //         Column(
                                  //           children: [
                                  //             Text(
                                  //               'دقيقه:',
                                  //               style: timerTextStyle.copyWith(
                                  //                   fontSize: 15),
                                  //             ),
                                  //             Text(
                                  //               currentRemainingTime?.min
                                  //                       .toString() ??
                                  //                   '',
                                  //               style: timerTextStyle,
                                  //             ),
                                  //           ],
                                  //         ),
                                  //         5.pw,
                                  //         Column(
                                  //           children: [
                                  //             Text(
                                  //               'ساعه:',
                                  //               style: timerTextStyle.copyWith(
                                  //                   fontSize: 15),
                                  //             ),
                                  //             Text(
                                  //               currentRemainingTime?.hours
                                  //                       .toString() ??
                                  //                   '',
                                  //               style: timerTextStyle,
                                  //             ),
                                  //           ],
                                  //         ),
                                  //       ],
                                  //     );
                                  //   },
                                  //   onEnd: () {
                                  //     print('Countdown ended');
                                  //     // You can do something here when the countdown ends
                                  //   },
                                  // ),
                                  )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                      },

                      ///offers
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                            vertical: 16.h), // Adjust the padding as needed
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              tr('offers_with_gift'),
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                color: AppColors.kPrimaryColor,
                                fontSize: 21.sp,
                                fontFamily: kTheArabicSansBold,
                                fontWeight: FontWeight.w600,
                                height: 0,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Get.to(const BeautyPharmacyScreen());
                              },
                              child: Text(
                                tr('see_all'),
                                style: TextStyle(
                                  color: AppColors.kPrimaryColor,
                                  fontSize: 16.sp,
                                  fontFamily: kTheArabicSansLight,
                                  fontWeight: FontWeight.w600,
                                  decoration: TextDecoration.underline,
                                  decorationColor: AppColors.kPrimaryColor,
                                  height: 0,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      CarouselSlider(
                        options: CarouselOptions(
                          viewportFraction: 1.0,
                          aspectRatio: 1.15,
                          autoPlay: true,
                          onPageChanged: (index, reason) {
                            _controller.updateCurrentOffer(newSlider: index);
                          },
                          enlargeCenterPage:
                              true, // Make the current page full width
                        ),
                        items: List.generate(
                            _controller.homeData.value.offers?.length ?? 0,
                            (index) => GestureDetector(
                                  onTap: () {},
                                  child: Stack(
                                    fit: StackFit.loose,
                                    alignment: Alignment.bottomCenter,
                                    children: [
                                      Container(
                                        width: kScreenWidth,
                                        margin:
                                            const EdgeInsets.only(bottom: 170),
                                        height: 200.h,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: CachedNetworkImageProvider(
                                                Connection.urlOfProducts(
                                                    image: _controller
                                                            .homeData
                                                            .value
                                                            .offers?[index]
                                                            .offerImage
                                                            ?.file ??
                                                        '')),
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        // bottom: -120,

                                        child: Container(
                                          margin: const EdgeInsets.only(
                                              left: 20, right: 20, bottom: 20),
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              40,
                                          height: 181.04.h,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                color: const Color.fromARGB(
                                                    32, 0, 0, 0),
                                                blurRadius: 28.r,
                                                offset: const Offset(0, 4),
                                                spreadRadius: 0,
                                              ),
                                            ],
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              SizedBox(
                                                height: 22.h,
                                              ),
                                              Text(
                                                _controller.homeData.value
                                                        .offers?[index].title ??
                                                    '',
                                                style: TextStyle(
                                                  color:
                                                      AppColors.kPrimaryColor,
                                                  fontSize: 18.sp,
                                                  fontFamily:
                                                      kTheArabicSansBold,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              Text(
                                                _controller
                                                        .homeData
                                                        .value
                                                        .offers?[index]
                                                        .offerDescription ??
                                                    '',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color:
                                                      AppColors.kBlackPinkColor,
                                                  height: 2,
                                                  fontSize: 13.sp,
                                                  fontFamily:
                                                      kTheArabicSansLight,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 18.h,
                                              ),
                                              InkWell(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        10.69.r),
                                                onTap: () {
                                                  Get.to(ItemProfilePage(
                                                      itemId: _controller
                                                              .homeData
                                                              .value
                                                              .offers?[index]
                                                              .id ??
                                                          0));
                                                },
                                                child: Container(
                                                  width: 109.71.w,
                                                  height: 37.93.h,
                                                  decoration: ShapeDecoration(
                                                    color:
                                                        AppColors.kPrimaryColor,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.69.r),
                                                    ),
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      tr('shop_now'),
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 12.83.sp,
                                                        fontFamily:
                                                            kTheArabicSansLight,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              15.ph
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                )),
                        disableGesture: true,
                      ),
                      const SizedBox(
                        height: 13,
                      ),
                      Obx(() => Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(
                                _controller.homeData.value.offers?.length ?? 0,
                                (index) => Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 6),
                                      height: _controller.currentOffer.value ==
                                              index
                                          ? 15
                                          : 10,
                                      width: _controller.currentOffer.value ==
                                              index
                                          ? 15
                                          : 10,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color:
                                              _controller.currentOffer.value ==
                                                      index
                                                  ? AppColors.mainColor
                                                  : AppColors.klPinkColor),
                                    )),
                          )),
                      const SizedBox(
                        height: 30,
                      ),

                      ///banners
                      ...List.generate(
                        _controller.homeData.value.banners?.length ?? 0,
                        (index) => GestureDetector(
                          onTap: () {
                            if (_controller
                                    .homeData.value.banners?[index].linkType ==
                                LinkTypes.brand) {
                              Get.to(BrandDetailScreen(
                                brandId: int.parse(_controller.homeData.value
                                        .banners?[index].linkId ??
                                    '0'),
                              ));
                            } else if (_controller
                                    .homeData.value.banners?[index].linkType ==
                                LinkTypes.product) {
                              Get.to(ItemProfilePage(
                                  itemId: int.parse(_controller.homeData.value
                                          .banners?[index].linkId ??
                                      '0')));
                            } else if (_controller
                                    .homeData.value.banners?[index].linkType ==
                                LinkTypes.category) {
                              AlkasamController controller =
                                  Get.put(AlkasamController());
                              controller.updateCurrentCategoryId(
                                  newId: int.parse(_controller.homeData.value
                                          .banners?[index].linkId ??
                                      '0'),
                                  getChild: null);
                              Get.to(FliterScreen2(
                                categoryId: int.parse(_controller.homeData.value
                                        .banners?[index].linkId ??
                                    '0'),
                              ));
                            }
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 179.28.h,
                            margin: const EdgeInsets.only(bottom: 17),
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: CachedNetworkImageProvider(
                                    Connection.urlOfBanner(
                                        image: _controller.homeData.value
                                                .banners?[index].banner ??
                                            '')),
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 8.h,
                      ),

                      /// salesProducts
                      Container(
                        width: 430.24.w,
                        decoration: const BoxDecoration(
                          color: AppColors.klPinkColor,
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 15.w, vertical: 0.h),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    tr('offers_sale_down'),
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                      color: AppColors.kPrimaryColor,
                                      fontSize: 21.sp,
                                      fontFamily: kTheArabicSansBold,
                                      fontWeight: FontWeight.w600,
                                      height: 0,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      final NavController controller =
                                          Get.put(NavController());
                                      controller.updateIndex(2);
                                    },
                                    child: Text(
                                      tr('all_offers_sale_down'),
                                      style: TextStyle(
                                        color: AppColors.kPrimaryColor,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16.sp,
                                        fontFamily: kTheArabicSansLight,
                                        decorationColor:
                                            AppColors.kPrimaryColor,
                                        decoration: TextDecoration.underline,
                                        height: 0,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Obx(() => SizedBox(
                                // height: 340.h,
                                child: CarouselSlider(
                                    options: CarouselOptions(
                                      viewportFraction:
                                          1.0, // Set to 1.0 for full width current page
                                      aspectRatio: 1.1,
                                      autoPlay: true,
                                      onPageChanged: (index, reason) {
                                        _controller.updateSalesProducts(
                                            newSlider: index);
                                      },
                                      enlargeCenterPage:
                                          true, // Make the current page full width
                                    ),
                                    items: List.generate(
                                        ((_controller
                                                        .homeData
                                                        .value
                                                        .salesProducts
                                                        ?.length ??
                                                    0) /
                                                2)
                                            .roundToDouble()
                                            .toInt(), (index) {
                                      int value = index * 2;
                                      return Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          CustomCardWidget(
                                            hideTage: true,
                                            imageUrl: Connection.urlOfProducts(
                                                image: _controller
                                                        .homeData
                                                        .value
                                                        .salesProducts?[value]
                                                        .mainImage ??
                                                    ''),
                                            newArrival: _controller
                                                    .homeData
                                                    .value
                                                    .salesProducts?[value] ??
                                                SalesProductsModel(),
                                            favorite: _controller
                                                    .homeData
                                                    .value
                                                    .newArrivals?[index]
                                                    .wishlist
                                                    ?.isNotEmpty ??
                                                false,
                                          ),
                                          if ((_controller.homeData.value
                                                      .salesProducts?.length ??
                                                  0) >
                                              value + 1) ...{
                                            CustomCardWidget(
                                              hideTage: true,
                                              imageUrl:
                                                  Connection.urlOfProducts(
                                                      image: _controller
                                                              .homeData
                                                              .value
                                                              .salesProducts?[
                                                                  value + 1]
                                                              .mainImage ??
                                                          ''),
                                              newArrival: _controller.homeData
                                                          .value.salesProducts?[
                                                      value + 1] ??
                                                  SalesProductsModel(),
                                              favorite: _controller
                                                      .homeData
                                                      .value
                                                      .newArrivals?[index + 1]
                                                      .wishlist
                                                      ?.isNotEmpty ??
                                                  false,
                                            )
                                          } else ...{
                                            CustomCardWidget(
                                              hideTage: true,
                                              imageUrl:
                                                  Connection.urlOfProducts(
                                                      image: _controller
                                                              .homeData
                                                              .value
                                                              .salesProducts?[
                                                                  value - 1]
                                                              .mainImage ??
                                                          ''),
                                              newArrival: _controller.homeData
                                                          .value.salesProducts?[
                                                      value - 1] ??
                                                  SalesProductsModel(),
                                              favorite: _controller
                                                      .homeData
                                                      .value
                                                      .newArrivals?[index - 1]
                                                      .wishlist
                                                      ?.isNotEmpty ??
                                                  false,
                                            )
                                          }
                                        ],
                                      );
                                    })))),
                            Obx(() => Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: List.generate(
                                      ((_controller.homeData.value.salesProducts
                                                      ?.length ??
                                                  0) /
                                              2)
                                          .roundToDouble()
                                          .toInt(),
                                      (index) => Container(
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 6),
                                            height: _controller
                                                        .currentSalesProducts
                                                        .value ==
                                                    index
                                                ? 15
                                                : 10,
                                            width: _controller
                                                        .currentSalesProducts
                                                        .value ==
                                                    index
                                                ? 15
                                                : 10,
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: _controller
                                                            .currentSalesProducts
                                                            .value ==
                                                        index
                                                    ? AppColors.mainColor
                                                    : AppColors.kWhiteColor),
                                          )),
                                )),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),

                      ///brands
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              tr('speacail_brands'),
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                color: AppColors.kPrimaryColor,
                                fontSize: 21.sp,
                                fontFamily: kTheArabicSansBold,
                                fontWeight: FontWeight.w600,
                                height: 0,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                final NavController controller =
                                    Get.put(NavController());
                                controller.updateIndex(3);
                              },
                              child: Text(
                                tr('all_brands'),
                                style: TextStyle(
                                  color: AppColors.kPrimaryColor,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16.sp,
                                  fontFamily: kTheArabicSansLight,
                                  decorationColor: AppColors.kPrimaryColor,
                                  decoration: TextDecoration.underline,
                                  height: 0,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Obx(() => ScrollableContainerList(
                          listOfBrands:
                              _controller.homeData.value.brands ?? [])),

                      ///discover
                      SizedBox(
                        height: 51.h,
                      ),
                      SizedBox(
                        height: 575.h,
                        child: Stack(
                          children: [
                            GestureDetector(
                              onTap: () {
                                if (_controller.homeData.value.discover?.info
                                        ?.linkType ==
                                    LinkTypes.brand) {
                                  Get.to(BrandDetailScreen(
                                    brandId: int.parse(_controller.homeData
                                            .value.discover?.info?.linkId ??
                                        '0'),
                                  ));
                                } else if (_controller.homeData.value.discover
                                        ?.info?.linkType ==
                                    LinkTypes.product) {
                                  Get.to(ItemProfilePage(
                                      itemId: int.parse(_controller.homeData
                                              .value.discover?.info?.linkId ??
                                          '0')));
                                } else if (_controller.homeData.value.discover
                                        ?.info?.linkType ==
                                    LinkTypes.category) {
                                  AlkasamController controller =
                                      Get.put(AlkasamController());
                                  controller.updateCurrentCategoryId(
                                      newId: int.parse(_controller.homeData
                                              .value.discover?.info?.linkId ??
                                          '0'),
                                      getChild: null);
                                  Get.to(FliterScreen2(
                                    categoryId: int.parse(_controller.homeData
                                            .value.discover?.info?.linkId ??
                                        '0'),
                                  ));
                                } else {
                                  final AlkasamController controller =
                                      Get.put(AlkasamController());
                                  controller.updateCurrentCategoryId(
                                      newId: 187, getChild: false);
                                  Get.to(const FliterScreen(
                                    categoryId: 187,
                                  ));
                                }
                              },
                              child: Container(
                                // width: 705.83.w,
                                height: 281.30.h,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: CachedNetworkImageProvider(
                                        Connection.urlOfDiscover(
                                            image: _controller.homeData.value
                                                    .discover?.info?.mobile ??
                                                '')),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                                top: 230.h,
                                // left: 15.w,
                                child: SizedBox(
                                  height: 344.h,
                                  width: MediaQuery.of(context).size.width,
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: _controller.homeData.value
                                            .discover?.products?.length ??
                                        0,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      return CustomCardWidget(
                                        hideTage: true,
                                        imageUrl: Connection.urlOfProducts(
                                            image: _controller
                                                    .homeData
                                                    .value
                                                    .discover
                                                    ?.products?[index]
                                                    .mainImage ??
                                                ''),
                                        newArrival: _controller.homeData.value
                                                .discover?.products?[index] ??
                                            SalesProductsModel(),
                                        favorite: _controller
                                                .homeData
                                                .value
                                                .newArrivals?[index]
                                                .wishlist
                                                ?.isNotEmpty ??
                                            false,
                                      );
                                    },
                                  ),
                                )),
                          ],
                        ),
                      ),
                      20.ph,

                      ///organicItems
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                              width: Get.width,
                              height: 408.h,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: _controller
                                        .homeData.value.organicItems?.length ??
                                    0,
                                itemBuilder: (context, index) {
                                  return Container(
                                    width: 245.0.w,
                                    height: 400.0.h,
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 10.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        Get.to(ItemProfilePage(
                                            itemId: int.parse(_controller
                                                    .homeData
                                                    .value
                                                    .organicItems?[index]
                                                    .linkId ??
                                                '0')));
                                      },
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          Container(
                                            width: 240.0.w,
                                            height: 240.0.w,
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image:
                                                    CachedNetworkImageProvider(
                                                  Connection.urlOfSpecial(
                                                      image: _controller
                                                              .homeData
                                                              .value
                                                              .organicItems?[
                                                                  index]
                                                              .image ??
                                                          ''),
                                                ),
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                          ),
                                          // Pink Container
                                          Container(
                                            width: 200.0.w,
                                            height: 159.38.h,
                                            color: AppColors.kPrimaryColor,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 18.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  SizedBox(
                                                    height: 15.h,
                                                  ),
                                                  Text(
                                                    _controller
                                                            .homeData
                                                            .value
                                                            .organicItems?[
                                                                index]
                                                            .title ??
                                                        '',
                                                    textAlign: TextAlign.right,
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 15.18.sp,
                                                      fontFamily:
                                                          kTheArabicSansBold,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      // height: 0.05,
                                                    ),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                  SizedBox(
                                                    height: 15.h,
                                                  ),
                                                  SizedBox(
                                                    width: 196.11.w,
                                                    child: Text(
                                                      _controller
                                                              .homeData
                                                              .value
                                                              .organicItems?[
                                                                  index]
                                                              .description ??
                                                          '',
                                                      textAlign:
                                                          TextAlign.right,
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 11.18.sp,
                                                        fontFamily:
                                                            kTheArabicSansBold,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        // height: 1.5,
                                                        // letterSpacing: 0.13,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 30.h,
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 20.w),
                                                    child: Text(
                                                      tr('shop_now'),
                                                      textAlign:
                                                          TextAlign.right,
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 14.63.sp,
                                                          fontFamily:
                                                              kTheArabicSansLight,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          decoration:
                                                              TextDecoration
                                                                  .underline,
                                                          height: 0.08,
                                                          letterSpacing: -0.15,
                                                          decorationColor:
                                                              Colors.white),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ))
                        ],
                      ),
                      // SizedBox(
                      //   height: 10.h,
                      // ),

                      ///specials

                      SizedBox(
                        height: 30.h,
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: Padding(
                          padding: EdgeInsets.only(right: 16.w),
                          child: Text(
                            tr('get_now_now'),
                            style: TextStyle(
                              color: AppColors.kPrimaryColor,
                              fontSize: 21.sp,
                              fontFamily: kTheArabicSansBold,
                              fontWeight: FontWeight.w600,
                              height: 0,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Wrap(
                        spacing: 10,
                        children: List.generate(
                            _controller.homeData.value.specials?.length ?? 0,
                            (index) => GestureDetector(
                                  onTap: () {
                                    Get.to(ItemProfilePage(
                                        itemId: int.parse(_controller
                                                .homeData
                                                .value
                                                .specials?[index]
                                                .linkId ??
                                            '0')));
                                  },
                                  child: CustomProductCard(
                                    imageUrl: Connection.urlOfSpecial(
                                        image: _controller.homeData.value
                                                .specials?[index].image ??
                                            ''),
                                    description: _controller.homeData.value
                                            .specials?[index].description ??
                                        '',
                                    buttonText: tr('shopNow'),
                                  ),
                                )),
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      Container(
                        height: 318.64.h,
                        width: 484.14.w,
                        color: AppColors.kPinkColor,
                        child: Stack(
                          children: [
                            Image(
                              image: const AssetImage(AppImages.kMagzineImage),
                              height: 300.h,
                              width: 420.w,
                            ),
                            Positioned(
                              top: 180.h,
                              right: 60.w,
                              child: RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text:
                                          'مجلة بيوتي كوين الإلكترونية - العدد الثاني\n',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 13.18.sp,
                                        fontFamily: kTheArabicSansLight,
                                        fontWeight: FontWeight.w700,
                                        height: 1.5,
                                        letterSpacing: 0.13,
                                      ),
                                    ),
                                    TextSpan(
                                      text:
                                          'واكبي آخر صيحات الموسم مع مجلتنا مجلة الجمال\nو الموضة     ',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 13.18.sp,
                                        fontFamily: kTheArabicSansLight,
                                        fontWeight: FontWeight.w400,
                                        // height: 1.5,
                                        // letterSpacing: 0.13,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Padding(
                                padding: EdgeInsets.only(
                                  bottom: 25.h,
                                ),
                                child: GestureDetector(
                                  onTap: () {
                                    Get.to(const MagazineScreen());
                                  },
                                  child: Container(
                                    height: 29.83.h,
                                    width: 85.59.w,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 1.5.w,
                                            color: AppColors.kWhiteColor),
                                        borderRadius:
                                            BorderRadius.circular(8.r)),
                                    child: Center(
                                      child: Text(tr('let_me_know_now'),
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12.03.sp,
                                            fontFamily: kTheArabicSansLight,
                                            fontWeight: FontWeight.w600,
                                            height: 1.5,
                                            letterSpacing: 0.13,
                                          )),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
          )),
    );
  }
}
