import 'package:beauty_queen/const/app_colors.dart';
import 'package:beauty_queen/const/styles.dart';
import 'package:beauty_queen/widgets/based/CustomAppBar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../const/size.dart';
import '../../const/vars.dart';
import '../../controller/auth_controller/auth_controler.dart';
import '../../controller/gift_controller/gift_controller.dart';
import '../../widgets/drawer/CustomEndDrawer.dart';
import '../../widgets/shimmer/shimmer_beauty_pharmacy.dart';
import '../product_profile/products_screen.dart';

class BeautyPharmacyScreen extends StatefulWidget {
  const BeautyPharmacyScreen({super.key});

  @override
  State<BeautyPharmacyScreen> createState() => _BeautyPharmacyScreenState();
}

class _BeautyPharmacyScreenState extends State<BeautyPharmacyScreen> {
  bool _isScrolled = false;
  double searchBarWidth = 1.0;
  double searchBarTranslationX = 0.0;
  double searchBarTranslationY = 0.0;
  final ScrollController _scrollController = ScrollController();
  final GiftController controller = Get.put(GiftController());

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    controller.getOffersDataController();
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

  final AuthController userController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
        key: scaffoldKey,
        appBar: PreferredSize(
          preferredSize:
              userController.userData.value.accountType == AccountTypes.queena
                  ? Size.fromHeight(_isScrolled ? 80.h : 145.h)
                  : Size.fromHeight(_isScrolled ? 100.h : 160.h),
          child: CustomAppBar(
            showarrowIcon: true,
            showBagIcon: true,
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
        body: SingleChildScrollView(
          controller: _scrollController,
          child: Obx(() => Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                child: Column(
                  children: [
                    SizedBox(
                      height: 20.h,
                    ),
                    (controller.generalSearchData2.value.info?.banner != null)
                        ? SizedBox(
                            height: 139.17.h,
                            width: MediaQuery.of(context).size.width,
                            child: CachedNetworkImage(
                                imageUrl: Connection.urlOfStorage(
                                    image: controller.generalSearchData2.value
                                            .info?.banner ??
                                        '')))
                        : const SizedBox(),
                    Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width / 10),
                      child: Text(
                        tr('offerDes'),
                        style: TextStyle(
                          fontFamily: kTheArabicSansLight,
                          color: AppColors.mainColor,
                          fontSize: 17.83.sp,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    controller.isLoading2.value == true
                        ? const ShimmerBeautyPharmacy()
                        : Column(
                            children: List.generate(
                                controller.generalSearchData2.value.offers?.data
                                        ?.length ??
                                    0,
                                (index) => GestureDetector(
                                      onTap: () {},
                                      child: Stack(
                                        fit: StackFit.loose,
                                        alignment: Alignment.bottomCenter,
                                        children: [
                                          Container(
                                            width: kScreenWidth,
                                            margin: const EdgeInsets.only(
                                                bottom: 170),
                                            height: 200.h,
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image: CachedNetworkImageProvider(
                                                    Connection.urlOfProducts(
                                                        image: controller
                                                                .generalSearchData2
                                                                .value
                                                                .offers
                                                                ?.data?[index]
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
                                                  left: 20,
                                                  right: 20,
                                                  bottom: 20),
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width -
                                                  40,
                                              height: 181.04.h,
                                              padding:
                                                  const EdgeInsets.symmetric(
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
                                                    controller
                                                            .generalSearchData2
                                                            .value
                                                            .offers
                                                            ?.data?[index]
                                                            .title ??
                                                        '',
                                                    style: TextStyle(
                                                      color: AppColors
                                                          .kPrimaryColor,
                                                      fontSize: 18.sp,
                                                      fontFamily:
                                                          kTheArabicSansLight,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                  ),
                                                  Text(
                                                    controller
                                                            .generalSearchData2
                                                            .value
                                                            .offers
                                                            ?.data?[index]
                                                            .offerDescription ??
                                                        '',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      color: AppColors
                                                          .kBlackPinkColor,
                                                      height: 2,
                                                      fontSize: 14.sp,
                                                      fontFamily:
                                                          kTheArabicSansLight,
                                                      fontWeight:
                                                          FontWeight.w400,
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
                                                          itemId: controller
                                                                  .generalSearchData2
                                                                  .value
                                                                  .offers
                                                                  ?.data?[index]
                                                                  .id ??
                                                              0));
                                                    },
                                                    child: Container(
                                                      width: 109.71.w,
                                                      height: 37.93.h,
                                                      decoration:
                                                          ShapeDecoration(
                                                        color: AppColors
                                                            .kPrimaryColor,
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
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
                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    )),
                          )
                  ],
                ),
              )),
        ));
  }
}
