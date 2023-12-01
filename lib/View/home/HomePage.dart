// ignore_for_file: file_names, library_private_types_in_public_api, avoid_unnecessary_containers
import 'package:beauty_queen/const/styles.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../const/app_colors.dart';
import '../../const/colors.dart';
import '../../const/images.dart';
import '../../const/size.dart';
import '../../const/vars.dart';
import '../../controller/home_controller/home_controller.dart';
import '../../widgets/CustomAppBar.dart';
import '../../widgets/CustomCardWidget.dart';
import '../../widgets/CustomEndDrawer.dart';
import '../../widgets/CustomProductCard.dart';
import '../../widgets/ScrollableContainerList.dart';
import '../../widgets/custom_horizontal_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final HomeController _controller = Get.put(HomeController());

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

  // bool _isScrolled = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(_isScrolled?100.h:160.h),
        child: CustomAppBar(
          showBagIcon: true,
          showFavIcon: true,
          showPersonIcon: true,
          onPressed: () {
            _scaffoldKey.currentState?.openEndDrawer();
          },
          isScrolled: _isScrolled,
          searchBarWidth: searchBarWidth, // Replace with your desired width
          searchBarTranslationY: searchBarTranslationY,
          searchBarTranslationX: searchBarTranslationX,
          // Replace with your desired translation value
        ),
      ),
      endDrawer: const MyEndDrawer(),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            ///Slider
            Obx(() => Stack(
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
                            _controller.updateCurrentSlider(newSlider: index);
                          },
                          enlargeCenterPage:
                              true, // Make the current page full width
                        ),
                        items: List.generate(
                            _controller.sliders?.length ?? 0,
                            (index) => GestureDetector(
                                  onTap: () {},
                                  child: CachedNetworkImage(
                                    imageUrl: Connection.urlOfSlider(
                                        image: _controller
                                                .sliders?[index].mobile ??
                                            ''),
                                    height: 270.h,
                                    width: MediaQuery.of(context).size.width,
                                    fit: BoxFit.contain,
                                    imageBuilder: (context, imageProvider) =>
                                        Container(
                                      height: 200,
                                      width: MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: imageProvider,
                                          fit: BoxFit.cover,
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
                        bottom: 10,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                              _controller.sliders?.length ?? 0,
                              (index) => Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 6),
                                    height:
                                        _controller.currentSlider.value == index
                                            ? 13
                                            : 10,
                                    width:
                                        _controller.currentSlider.value == index
                                            ? 13
                                            : 10,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color:
                                            _controller.currentSlider.value ==
                                                    index
                                                ? AppColors.kWhiteColor
                                                : AppColors.kDividerColor),
                                  )),
                        ))
                  ],
                )),

            ///categories
            Obx(() => SizedBox(
                  height: 140.h,
                  child: CustomImageList(
                      dataOfItem: _controller.homeData.value.categories ?? []),
                )),

            /// New Items
            Obx(() => SizedBox(
                  height: 350.h,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _controller.homeData.value.newItems?.length ?? 0,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 9.w),
                        child: SizedBox(
                          width: 262.45.w,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Container(
                                width: 262.45.w,
                                height: 262.45.h,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: CachedNetworkImageProvider(
                                        Connection.urlOfSpecial(
                                            image: _controller.homeData.value
                                                    .newItems?[index].image ??
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
                                    color: AppColors.kPrimaryColor),
                                child: Padding(
                                  padding: EdgeInsets.all(9.r),
                                  child: Text(
                                    _controller.homeData.value.newItems?[index]
                                            .description ??
                                        '',
                                    textAlign: TextAlign.right,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 3,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 13.1.sp,
                                      fontFamily: kTheArabicSansLight,
                                      fontWeight: FontWeight.w700,
                                      // height: 1.5,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                )),

            ///newArrivals
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'وصل حديثا',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color:  AppColors.kPrimaryColor,
                      fontSize: 21.sp,
                      fontFamily: kTheArabicSansLight,
                      fontWeight: FontWeight.w700,
                      height: 0,
                    ),
                  ),
                  Text(
                    'عرض الكل',
                    style: TextStyle(
                      color: AppColors.kPrimaryColor,
                      fontSize: 18.sp,
                      fontFamily: kTheArabicSansLight,
                      fontWeight: FontWeight.w400,
                      decoration: TextDecoration.underline,
                      decorationColor: kPrimaryColor,
                      height: 0,
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
                    padding: EdgeInsets.only(top: 30.h),
                    child: Container(
                      color: AppColors.kBorderColor,
                      width: kScreenWidth,
                      height: 300.38.h,
                    ),
                  ),
                  SizedBox(
                    height: 340.h,
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount:
                          _controller.homeData.value.newArrivals?.length ?? 0,
                      itemBuilder: (context, index) {
                        return CustomCardWidget(
                            imageUrl: Connection.urlOfProducts(
                                image: _controller.homeData.value
                                        .newArrivals?[index].mainImage ??
                                    ''),
                            imgtxt: _controller.homeData.value
                                    .newArrivals?[index].brand?.title ??
                                '',
                            price: _controller
                                    .homeData.value.newArrivals?[index].price ??
                                '',
                            des: _controller
                                    .homeData.value.newArrivals?[index].title ??
                                '',
                            disprice: _controller.homeData.value
                                    .newArrivals?[index].offerPrice ??
                                '',
                            note:
                                _controller.homeData.value.newArrivals?[index].note ?? '',
                            containertxt: 'تحديد الخيارات');
                      },
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 15.h,
            ),

            ///offers
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: 16.w,
                  vertical: 16.h), // Adjust the padding as needed
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'العروض والهاديا',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: AppColors.kPrimaryColor,
                      fontSize: 21.sp,
                      fontFamily: kTheArabicSansLight,
                      fontWeight: FontWeight.w700,
                      height: 0,
                    ),
                  ),
                  Text(
                    'عرض الكل',
                    style: TextStyle(
                      color: AppColors.kPrimaryColor,
                      fontSize: 18.sp,
                      fontFamily: kTheArabicSansLight,
                      fontWeight: FontWeight.w400,
                      decoration: TextDecoration.underline,
                      decorationColor: kPrimaryColor,
                      height: 0,
                    ),
                  ),
                ],
              ),
            ),
            CarouselSlider(
              options: CarouselOptions(
                viewportFraction: 1.0,
                aspectRatio: 1.1,
                autoPlay: true,
                onPageChanged: (index, reason) {
                  _controller.updateCurrentOffer(newSlider: index);
                },
                enlargeCenterPage: true, // Make the current page full width
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
                              margin: const EdgeInsets.only(bottom: 170),
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
                                width: MediaQuery.of(context).size.width - 40,
                                height: 181.04.h,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: const Color.fromARGB(32, 0, 0, 0),
                                      blurRadius: 28.r,
                                      offset: const Offset(0, 4),
                                      spreadRadius: 0,
                                    ),
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: 22.h,
                                    ),
                                    Text(
                                      _controller.homeData.value.offers?[index]
                                              .title ??
                                          '',
                                      style: TextStyle(
                                        color: AppColors.kPrimaryColor,
                                        fontSize: 18.sp,
                                        fontFamily: kTheArabicSansLight,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    Text(
                                      _controller.homeData.value.offers?[index]
                                              .offerDescription ??
                                          '',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: AppColors.kBlackPinkColor,
                                        height: 2,
                                        fontSize: 14.sp,
                                        fontFamily: kTheArabicSansLight,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 18.h,
                                    ),
                                    Container(
                                      width: 109.71.w,
                                      height: 37.93.h,
                                      decoration: ShapeDecoration(
                                        color: AppColors.kPrimaryColor,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.69.r),
                                        ),
                                      ),
                                      child: Center(
                                        child: Text(
                                          'تسوقي الأن',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12.83.sp,
                                            fontFamily: kTheArabicSansLight,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ),
                                    ),
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
                            margin: const EdgeInsets.symmetric(horizontal: 6),
                            height: _controller.currentOffer.value == index
                                ? 15
                                : 10,
                            width: _controller.currentOffer.value == index
                                ? 15
                                : 10,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: _controller.currentOffer.value == index
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
              (index) => Container(
                width: MediaQuery.of(context).size.width,
                height: 179.28.h,
                margin: const EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: CachedNetworkImageProvider(Connection.urlOfBanner(
                        image:
                            _controller.homeData.value.banners?[index].banner ??
                                '')),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 40.h,
            ),

            /// salesProducts
            Container(
              width: 430.24.w,
              decoration: const BoxDecoration(color: AppColors.klPinkColor,),
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Column(
                children: [
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'التخفيضات',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            color: AppColors.kPrimaryColor,
                            fontSize: 21.sp,
                            fontFamily: kTheArabicSansLight,
                            fontWeight: FontWeight.w700,
                            height: 0,
                          ),
                        ),
                        Text(
                          'كل التخفيضات',
                          style: TextStyle(
                            color: AppColors.kPrimaryColor,
                            fontSize: 18.sp,
                            fontFamily: kTheArabicSansLight,
                            fontWeight: FontWeight.w400,
                            decorationColor: kPrimaryColor,
                            decoration: TextDecoration.underline,
                            height: 0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                      // height: 340.h,
                      child: CarouselSlider(
                          options: CarouselOptions(
                            viewportFraction:
                                1.0, // Set to 1.0 for full width current page
                            aspectRatio: 1.0,
                            autoPlay: true,
                            onPageChanged: (index, reason) {
                              _controller.updateSalesProducts(newSlider: index);
                            },
                            enlargeCenterPage:
                                true, // Make the current page full width
                          ),
                          items: List.generate(
                                  ((_controller.homeData.value.salesProducts?.length??0)/2).roundToDouble().toInt(),
                              (index) {
                                int value = index * 2;
                                    return Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      CustomCardWidget(
                                          imageUrl: Connection.urlOfProducts(
                                              image: _controller
                                                      .homeData
                                                      .value
                                                      .salesProducts?[value]
                                                      .mainImage ??
                                                  ''),
                                          imgtxt: _controller
                                                  .homeData
                                                  .value
                                                  .salesProducts?[value]
                                                  .brand
                                                  ?.title ??
                                              '',
                                          price: _controller
                                                  .homeData
                                                  .value
                                                  .salesProducts?[value]
                                                  .offerPrice ??
                                              '',
                                          des: _controller
                                                  .homeData
                                                  .value
                                                  .salesProducts?[value]
                                                  .title ??
                                              '',
                                          disprice: _controller
                                                  .homeData
                                                  .value
                                                  .salesProducts?[value]
                                                  .price ??
                                              '',
                                          containertxt: 'تحديد الخيارات'),
                                      if ((_controller.homeData.value
                                                  .salesProducts?.length ??
                                              0) >
                                          value + 1) ...{
                                        CustomCardWidget(
                                            imageUrl: Connection.urlOfProducts(
                                                image: _controller
                                                        .homeData
                                                        .value
                                                        .salesProducts?[
                                                value + 1]
                                                        .mainImage ??
                                                    ''),
                                            imgtxt: _controller
                                                    .homeData
                                                    .value
                                                    .salesProducts?[value + 1]
                                                    .brand
                                                    ?.title ??
                                                '',
                                            price: _controller
                                                    .homeData
                                                    .value
                                                    .salesProducts?[value + 1]
                                                    .offerPrice ??
                                                '',
                                            des: _controller
                                                    .homeData
                                                    .value
                                                    .salesProducts?[value + 1]
                                                    .title ??
                                                '',
                                            disprice:
                                                _controller.homeData.value.salesProducts?[value + 1].price ??
                                                    '',
                                            containertxt: 'تحديد الخيارات'),
                                      }
                                    ],
                                  );}))),
                  Obx(() => Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                            ((_controller.homeData.value.salesProducts?.length??0)/2).roundToDouble().toInt(),
                            (index) => Container(
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 6),
                                  height:
                                      _controller.currentSalesProducts.value ==
                                              index
                                          ? 15
                                          : 10,
                                  width:
                                      _controller.currentSalesProducts.value ==
                                              index
                                          ? 15
                                          : 10,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: _controller
                                                  .currentSalesProducts.value ==
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
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'الماركات المميزة',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: AppColors.kPrimaryColor,
                      fontSize: 21.sp,
                      fontFamily: kTheArabicSansLight,
                      fontWeight: FontWeight.w700,
                      height: 0,
                    ),
                  ),
                  Text(
                    'جميع الماركات',
                    style: TextStyle(
                      color: AppColors.kPrimaryColor,
                      fontSize: 18.sp,
                      fontFamily: kTheArabicSansLight,
                      fontWeight: FontWeight.w400,
                      decorationColor: kPrimaryColor,
                      decoration: TextDecoration.underline,
                      height: 0,
                    ),
                  )
                ],
              ),
            ),
            Obx(() => ScrollableContainerList(
                listOfBrands: _controller.homeData.value.brands ?? [])),

            ///discover
            SizedBox(
              height: 51.h,
            ),
            SizedBox(
              height: 670.h,
              child: Stack(
                children: [
                  Container(
                    // width: 705.83.w,
                    height: 281.30.h,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: CachedNetworkImageProvider(
                            Connection.urlOfDiscover(
                                image: _controller.homeData.value.discover?.info
                                        ?.mobile ??
                                    '')),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                      top: 230.h,
                      // left: 15.w,
                      child: Container(
                        height: 342,
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: _controller
                                  .homeData.value.discover?.products?.length ??
                              0,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return CustomCardWidget(
                                imageUrl: Connection.urlOfProducts(
                                    image: _controller.homeData.value.discover
                                            ?.products?[index].mainImage ??
                                        ''),
                                imgtxt: _controller.homeData.value.discover
                                        ?.products?[index].brand?.title ??
                                    '',
                                price: _controller.homeData.value.discover
                                        ?.products?[index].price ??
                                    '',
                                des: _controller.homeData.value.discover
                                        ?.products?[index].title ??
                                    '',
                                disprice: _controller.homeData.value.discover
                                        ?.products?[index].offerPrice ??
                                    '',
                                containertxt: 'تحديد الخيارات');
                          },
                        ),
                      )),
                ],
              ),
            ),

            ///organicItems
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                    width: Get.width,
                    height: 448.h,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount:
                          _controller.homeData.value.organicItems?.length ?? 0,
                      itemBuilder: (context, index) {
                        return Container(
                          width: 257.0.w,
                          height: 448.0.h,
                          margin: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Container(
                                width: 257.0.w,
                                height: 258.56.h,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: CachedNetworkImageProvider(
                                      Connection.urlOfSpecial(
                                          image: _controller.homeData.value
                                                  .organicItems?[index].image ??
                                              ''),
                                    ),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              // Pink Container
                              Container(
                                width: 257.0.w,
                                height: 189.38.h,
                                color: AppColors.kPrimaryColor,
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 18.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 30.h,
                                      ),
                                      Text(
                                        _controller.homeData.value
                                                .organicItems?[index].title ??
                                            '',
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 19.18.sp,
                                          fontFamily: kTheArabicSansLight,
                                          fontWeight: FontWeight.w700,
                                          height: 0.05,
                                          letterSpacing: -0.19,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 29.h,
                                      ),
                                      SizedBox(
                                        width: 226.11.w,
                                        child: Text(
                                          _controller
                                                  .homeData
                                                  .value
                                                  .organicItems?[index]
                                                  .description ??
                                              '',
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 13.18.sp,
                                            fontFamily: kTheArabicSansLight,
                                            fontWeight: FontWeight.w400,
                                            height: 1.5,
                                            letterSpacing: 0.13,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 30.h,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 20.w),
                                        child: Text(
                                          'تسوقي الأن',
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14.63.sp,
                                            fontFamily: kTheArabicSansLight,
                                            fontWeight: FontWeight.w400,
                                            decoration:
                                                TextDecoration.underline,
                                            height: 0.08,
                                            letterSpacing: -0.15,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ))
              ],
            ),
            SizedBox(
              height: 20.h,
            ),

            ///specials
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: EdgeInsets.only(right: 16.w),
                child: Text(
                  'إكتشفي أيضاً',
                  style: TextStyle(
                    color: AppColors.kPrimaryColor,
                    fontSize: 21.sp,
                    fontFamily: kTheArabicSansLight,
                    fontWeight: FontWeight.w700,
                    height: 0,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 30.h,
            ),
            Wrap(
              spacing: 10,
              children: List.generate(
                  _controller.homeData.value.specials?.length ?? 0,
                  (index) => CustomProductCard(
                        imageUrl: Connection.urlOfSpecial(
                            image: _controller
                                    .homeData.value.specials?[index].image ??
                                ''),
                        description: _controller
                                .homeData.value.specials?[index].description ??
                            '',
                        // 'تخلصي من جفاف وخشونة الوجه والجسم بخلاصة عسل المانوكا الغني الفيتامينات والمرطبات الطبيعية الدسمة',
                        buttonText: 'تسوقي الأن',
                        onPressed: () {
                          // Add your button click logic here
                        },
                      )),
            ),
            SizedBox(
              height: 30.h,
            ),
            Container(
              height: 318.64.h,
              width: 484.14.w,
              color: kPinkColor,
              child: Stack(
                children: [
                  Image(
                    image: const AssetImage(kMagzineImage),
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
                      child: Container(
                        height: 29.83.h,
                        width: 85.59.w,
                        decoration: BoxDecoration(
                            border:
                                Border.all(width: 1.5.w, color: kWhiteColor),
                            borderRadius: BorderRadius.circular(8.r)),
                        child: Center(
                          child: Text('إطــلعي الأن',
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
