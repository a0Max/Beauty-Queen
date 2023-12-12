// ignore_for_file: file_names

import 'package:beauty_queen/View/favourtie_screen.dart';
import 'package:beauty_queen/const/app_images.dart';
import 'package:beauty_queen/const/colors.dart';
import 'package:beauty_queen/const/styles.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../View/user_profile/normalprofile.dart';
import '../View/cart/cart_screen.dart';
import '../const/app_colors.dart';

class CustomAppBar extends StatelessWidget {
  final bool? isScrolled;
  final double? searchBarWidth;
  final double? searchBarHeight;
  final double? containerHeight;
  final int? countCart;
  final double? searchBarTranslationY;
  final double? searchBarTranslationX;

  final VoidCallback? onPressed;
  final bool showMenuIcon;
  final bool showFavIcon;
  final bool showPersonIcon;
  final bool showBagIcon;
  final bool showBagIcon2;
  final bool showarrowIcon;
  final bool showarrowIcon2;
  final bool showimageIcon;

  const CustomAppBar(
      {super.key,
      this.searchBarHeight = 0.0,
      this.isScrolled = false,
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
      this.showarrowIcon = false,
      this.showimageIcon = false,
      this.showBagIcon2 = false});

  @override
  Widget build(BuildContext context) {
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
                color: kWhiteColor,
                size: 25,
              )),
      ],
      automaticallyImplyLeading: false,
      backgroundColor: AppColors.kPrimaryColor,
      centerTitle: true,
      title: Text.rich(
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
                decorationColor: kWhiteColor,
              ),
            ),
          ],
        ),
      ),
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
                children: [
                  if (showMenuIcon)
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
                  ),
                  SizedBox(
                    width: 16.w,
                  ),
                  if (isScrolled != true && showBagIcon2)
                    SvgPicture.asset(
                      AppImages.imageShop,
                      height: 20.h,
                      width: 20.w,
                    ),
                  const Spacer(),
                  if (isScrolled != true && showFavIcon)
                    GestureDetector(
                      onTap: () {
                        Get.to( const FavScreen());
                      },
                      child: SvgPicture.asset(
                        AppImages.imageLoveSvg,
                        height: 30.h,
                        width: 30.w,
                      ),
                    ),

                  if(isScrolled == true)...{
                    SizedBox(
                        height: 44.h,

                        width: MediaQuery.of(context).size.width-(30.w+10.w+20.w+16.w+20.w+30.w+9.w),

                        child:TextField(
                          style: const TextStyle(
                            fontFamily: kTheArabicSansLight,
                          ),
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                              onPressed: onPressed,
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
                          maxLines: 1,
                        )),
                  },
                  SizedBox(
                    width: 9.w,
                  ),
                  if (showPersonIcon)
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
                  SizedBox(
                    width: 9.w,
                  ),
                  if (showBagIcon)
                    GestureDetector(
                      onTap: () {
                        Get.to(const CartScreen());
                      },
                      child: Badge(
                        label: Text(countCart.toString()),
    isLabelVisible:(countCart!=null)&&(countCart!=0),
                        child: SvgPicture.asset(
                          AppImages.imageShop,
                          height: 30.h,
                          width: 30.w,
                        ),
                      ),
                    ),
                  SizedBox(
                    width: 8.w,
                  ),
                  if (showarrowIcon)
                    IconButton(
                        onPressed: () {
                          Get.back();
                        },
                        icon: const Icon(
                          Icons.arrow_forward_ios,
                          color: kBlackColor,
                          size: 30,
                        )),

                ],
              ),

              if(isScrolled==false)...{AnimatedContainer(
                height: 44.h,
                padding: EdgeInsets.symmetric(
                  horizontal: 16.w,
                ),
                margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 10.h),
                width: Get.width * searchBarWidth!,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                transform: Matrix4.translationValues(
                  isScrolled! ? 20 : 10.0,
                  searchBarTranslationY!,
                  isScrolled! ? -20.0 : 0,
                ),
                child: TextField(
                  style: const TextStyle(
                    fontFamily: kTheArabicSansLight,
                  ),
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      onPressed: onPressed,
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
                  maxLines: 1,
                ),
              )},

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
