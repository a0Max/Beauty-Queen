// ignore_for_file: file_names

import 'package:beauty_queen/View/fav/favourtie_screen.dart';
import 'package:beauty_queen/View/search/search_screen.dart';
import 'package:beauty_queen/const/app_images.dart';
import 'package:beauty_queen/const/extensions.dart';
import 'package:beauty_queen/const/styles.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../View/search/quick_search_screen.dart';
import '../../View/user_profile/mydata_screen.dart';
import '../../View/user_profile/normalprofile.dart';
import '../../View/cart/cart_screen.dart';
import '../../const/app_colors.dart';
import '../../const/vars.dart';
import '../../controller/auth_controller/auth_controler.dart';
import '../../controller/search/search_controller.dart';
import 'error_pop_up.dart';
import 'loading.dart';

class CustomAppBar extends StatelessWidget {
  final bool? isScrolled;
  final double? searchBarWidth;
  final double? searchBarHeight;
  final double? containerHeight;
  final int? countCart;
  final double? searchBarTranslationY;
  final bool? makeSearchBarNotClickable;
  final double? searchBarTranslationX;

  final VoidCallback? onPressed;
  final bool showMenuIcon;
  final bool showFavIcon;
  final bool showPersonIcon;
  final bool showBagIcon;
  // final bool showBagIcon2;
  final bool showarrowIcon;
  final bool showarrowIcon2;

  CustomAppBar(
      {super.key,
      this.searchBarHeight = 0.0,
      this.isScrolled = false,
      this.makeSearchBarNotClickable = false,
      this.countCart = 0,
      this.containerHeight = 0.0,
      this.searchBarWidth = 0.0,
      this.searchBarTranslationY = 0.0,
      this.searchBarTranslationX = 0.0,
      this.onPressed,
      this.showarrowIcon2 = false,
      this.showMenuIcon = true,
      this.showFavIcon = false,
      this.showPersonIcon = false,
      this.showBagIcon = false,
      this.showarrowIcon = false});
  TextEditingController searchController = TextEditingController();

  goToSearchScreen({required BuildContext context}) {
    // var context = Get.context;
    final currentRoute = ModalRoute.of(context);
    final currentScreenName = currentRoute?.settings.name;
    if (searchController.text != '') {
      print('currentScreenName:$currentScreenName');
      if (currentScreenName == "/SearchScreen") {
        final SearchController0 controller = Get.put(SearchController0());
        controller.getSearchDetails(
            currentPage: 1, subKeyWord: searchController.text);
      } else {
        Get.to(() => SearchScreen(subKeyWord: searchController.text));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    AuthController controller = Get.put(AuthController());

    return AppBar(
      elevation: 0,
      iconTheme: const IconThemeData(color: Colors.transparent),
      actions: [
        if (showarrowIcon2)
          IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(
                Icons.arrow_forward_ios,
                color: AppColors.kWhiteColor,
                size: 25,
              )),
      ],
      automaticallyImplyLeading: false,
      backgroundColor: AppColors.kPrimaryColor,
      centerTitle: true,
      title: controller.userData.value.accountType != AccountTypes.queena
          ? GestureDetector(
              onTap: () async {
                try {
                  LoadingScreen.show(context);

                  await controller.upgradeAccount();

                  Navigator.of(context).pop();
                  ErrorPopUp(
                      message: tr('update_success'),
                      title: tr('upgrade_success'),
                      isError: false);
                  Get.to(const MyDataScreen(
                    openToEdit: true,
                  ));
                } on DioException catch (e) {
                  ErrorPopUp(
                      message: (e.response?.data as Map).values.first,
                      title: 'خطا');
                } catch (e) {
                  if (e == 'Check Network connection') {
                    ErrorPopUp(message: tr('network_connection'), title: 'خطا');
                  } else {
                    ErrorPopUp(message: tr('something_wrong'), title: 'خطا');
                  }
                }
              },
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'خصومات و شحن مجاني بترقية حسابك الى كوينا',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12.5.sp,
                        fontFamily: kTheArabicSansLight,
                        fontWeight: FontWeight.w600,
                        // height: 0,
                      ),
                    ),
                    TextSpan(
                      text: 'سجلي الان',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12.5.sp,
                        fontFamily: kTheArabicSansLight,
                        fontWeight: FontWeight.w600,
                        decoration: TextDecoration.underline,
                        decorationColor: AppColors.kWhiteColor,
                      ),
                    ),
                  ],
                ),
              ),
            )
          : const SizedBox(),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(0),
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              SizedBox(
                height: 20.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (onPressed != null) ...{
                    Row(
                      children: [
                        SizedBox(
                          width: 10.w,
                        ),
                        GestureDetector(
                          onTap: onPressed,
                          child: SvgPicture.asset(
                            AppImages.imageMenu,
                            height: 20.h,
                            width: 20.w,
                          ),
                        )
                      ],
                    )
                  } else ...{
                    const SizedBox()
                  },
                  if (isScrolled == true) ...{
                    SizedBox(
                        height: 44.h,
                        width: MediaQuery.of(context).size.width -
                            (30.w +
                                10.w +
                                20.w +
                                16.w +
                                (onPressed != null ? 20.w : 0.w) +
                                (showFavIcon ? 30.w : 0.w) +
                                9.w),
                        child: TextField(
                          readOnly:
                              makeSearchBarNotClickable == false ? true : false,
                          autofocus: makeSearchBarNotClickable ?? false,
                          onTap: () {
                            if (makeSearchBarNotClickable == false) {
                              Get.to(() => const QuickSearchScreen());
                            }
                          },
                          onChanged: (val) {
                            if (makeSearchBarNotClickable == true) {
                              final SearchController0 controller =
                                  Get.put(SearchController0());
                              controller.getTheQuickSearch(keyWord: val);
                            }
                          },
                          controller: searchController,
                          style: const TextStyle(
                            fontFamily: kTheArabicSansLight,
                          ),
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                              onPressed: () {
                                goToSearchScreen(context: context);
                              },
                              icon: SvgPicture.asset(AppImages.imageSearch),
                            ),
                            prefix: SizedBox(width: 20.w),
                            hintText: 'إبحث عن منتج أو ماركة',
                            hintStyle: TextStyle(
                              color: AppColors.kGrayColor,
                              fontSize: 16.59.sp,
                              fontFamily: kTheArabicSansLight,
                              fontWeight: FontWeight.w300,
                            ),
                            contentPadding: EdgeInsets.symmetric(vertical: 7.h),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(39.r),
                              borderSide: const BorderSide(
                                color: AppColors.kWhiteBlueColor,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(39.r),
                              borderSide: const BorderSide(
                                color: AppColors.kWhiteBlueColor,
                              ),
                            ),
                            fillColor: AppColors.kWhiteBlueColor,
                            filled: true,
                          ),
                          onSubmitted: (val) {
                            goToSearchScreen(context: context);
                          },
                          onEditingComplete: () {
                            goToSearchScreen(context: context);
                          },
                          maxLines: 1,
                        )),
                  },
                  Row(
                    children: [
                      if (isScrolled != true && showFavIcon) ...{
                        GestureDetector(
                          onTap: () {
                            Get.to(const FavScreen());
                          },
                          child: SvgPicture.asset(
                            AppImages.imageLoveSvg,
                            height: 30.h,
                            width: 30.w,
                          ),
                        ),
                      },
                      if (showPersonIcon) ...{
                        Row(
                          children: [
                            9.pw,
                            GestureDetector(
                              onTap: () {
                                Get.to(const NormalProfileScreen());
                              },
                              child: SvgPicture.asset(
                                AppImages.imagePerson,
                                height: 30.h,
                                width: 30.w,
                              ),
                            ),
                            9.pw
                          ],
                        )
                      },
                      if (showBagIcon) ...{
                        Row(
                          children: [
                            9.pw,
                            GestureDetector(
                              onTap: () {
                                Get.to(const CartScreen());
                              },
                              child: Badge(
                                label: Text(countCart.toString()),
                                isLabelVisible:
                                    (countCart != null) && (countCart != 0),
                                child: SvgPicture.asset(
                                  AppImages.imageShop,
                                  height: 30.h,
                                  width: 30.w,
                                ),
                              ),
                            ),
                            9.pw
                          ],
                        )
                      },
                      if (showarrowIcon) ...{
                        Row(
                          children: [
                            8.pw,
                            IconButton(
                                onPressed: () {
                                  Get.back();
                                },
                                icon: const Icon(
                                  Icons.arrow_forward_ios,
                                  color: AppColors.kBlackColor,
                                  size: 30,
                                )),
                            8.pw
                          ],
                        )
                      }
                    ],
                  )
                ],
              ),
              if (isScrolled == false) ...{
                AnimatedContainer(
                  height: 44.h,
                  padding: EdgeInsets.only(
                    right: 16.w,
                  ),
                  margin: EdgeInsets.symmetric(horizontal: 0.w, vertical: 10.h),
                  width: Get.width * searchBarWidth!,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  transform: Matrix4.translationValues(
                    isScrolled! ? 20 : 10.0,
                    searchBarTranslationY!,
                    isScrolled! ? -20.0 : 0,
                  ),
                  child: TextField(
                    autofocus: makeSearchBarNotClickable ?? false,
                    onTap: () {
                      if (makeSearchBarNotClickable == false) {
                        Get.to(() => const QuickSearchScreen());
                      }
                    },
                    onChanged: (val) {
                      if (makeSearchBarNotClickable == true) {
                        final SearchController0 controller =
                            Get.put(SearchController0());
                        controller.getTheQuickSearch(keyWord: val);
                      }
                    },
                    controller: searchController,
                    style: const TextStyle(
                      fontFamily: kTheArabicSansLight,
                    ),
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        onPressed: () {
                          goToSearchScreen(context: context);
                        },
                        icon: SvgPicture.asset(AppImages.imageSearch),
                      ),
                      prefix: SizedBox(width: 20.w),
                      hintText: 'إبحث عن منتج أو ماركة',
                      hintStyle: TextStyle(
                        color: AppColors.kGrayColor.withOpacity(.6),
                        fontSize: 14.sp,
                        fontFamily: kTheArabicSansLight,
                        fontWeight: FontWeight.w300,
                      ),
                      contentPadding: EdgeInsets.symmetric(vertical: 7.h),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(39.r),
                        borderSide: const BorderSide(
                          color: AppColors.kWhiteBlueColor,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(39.r),
                        borderSide: const BorderSide(
                          color: AppColors.kWhiteBlueColor,
                        ),
                      ),
                      fillColor: AppColors.kWhiteBlueColor,
                      filled: true,
                    ),
                    onSubmitted: (val) {
                      goToSearchScreen(context: context);
                    },
                    onEditingComplete: () {
                      goToSearchScreen(context: context);
                    },
                    maxLines: 1,
                  ),
                )
              },
              SizedBox(
                height: 10.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
