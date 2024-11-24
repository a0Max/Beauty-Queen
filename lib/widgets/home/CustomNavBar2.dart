// ignore_for_file: file_names, unrelated_type_equality_checks

import 'package:beauty_queen/const/extensions.dart';
import 'package:beauty_queen/const/styles.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../View/brands/brands_screen.dart';
import '../../View/categories/alkasam_screen.dart';
import '../../View/discount/discounts_screen.dart';
import '../../View/gifts/GuidanceScreen.dart';
import '../../View/home/HomePage.dart';
import '../../View/home/bottom_nav_screen.dart';
import '../../const/app_colors.dart';
import '../../const/app_images.dart';
import '../../controller/nav_bar_controller/NavBarController.dart';

class ReusableBottomNavigationBar2 extends StatelessWidget {
  const ReusableBottomNavigationBar2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final NavController controller = Get.put(NavController());
    final List<NavigationItem> navigationItems = [
      NavigationItem(
          title: tr('home'),
          unselectedImagePath: AppImages.imageHomeUnSelected,
          selectedImagePath: AppImages.imageHomeSelected),
      NavigationItem(
          title: tr('categories'),
          unselectedImagePath: AppImages.imageCategoriesUnSelectedPng,
          selectedImagePath: AppImages.imageCategoriesSelectedPng),
      NavigationItem(
          title: tr('discounts'),
          unselectedImagePath: AppImages.imageDiscountsUnSelected,
          selectedImagePath: AppImages.imageDiscountsSelected),
      NavigationItem(
          title: tr('Dis'),
          unselectedImagePath: AppImages.imageDisUnSelected,
          selectedImagePath: AppImages.imageDisSelected),
      NavigationItem(
          title: tr('Gifts'),
          unselectedImagePath: AppImages.imageGiftsUnSelected,
          selectedImagePath: AppImages.imageGiftsSelected),
    ];
    final List<Widget> screens = [
      const HomePage(),
      const AlKasamScreen(),
      const DiscountScreen(),
      const BrandScreen(),
      const GuidanceScreen()
    ];
    return Obx(
      () => SizedBox(
        // height: 103.29.h,
        child: BottomNavigationBar(
          backgroundColor: AppColors.kWhiteColor,
          selectedIconTheme: const IconThemeData(
            color: AppColors.kPrimaryColor,
          ),
          unselectedIconTheme:
              const IconThemeData(color: AppColors.kBlackColor),
          elevation: 0,
          selectedItemColor: AppColors.kPrimaryColor,
          unselectedItemColor: AppColors.kTextGrayColor,
          selectedLabelStyle: TextStyle(
              height: 2.h,
              color: AppColors.kBlackColor,
              fontFamily: kTheArabicSansLight,
              fontSize: 12.sp,
              fontWeight: FontWeight.w700),
          unselectedLabelStyle: TextStyle(
              color: AppColors.kBlackColor,
              fontFamily: kTheArabicSansLight,
              fontSize: 12.sp,
              fontWeight: FontWeight.w700),
          currentIndex: controller.currentIndex.value,
          type: BottomNavigationBarType.fixed,
          onTap: (index) {
            Get.to(() => const MainView());
            controller.updateIndex(index);
            // Get.offAll(screens[index]);
          },
          items: navigationItems.map((item) {
            return BottomNavigationBarItem(
              icon: Column(
                children: [
                  5.ph,
                  item.unselectedImagePath.split('.').last != 'png'
                      ? SvgPicture.asset(
                          controller.currentIndex ==
                                  navigationItems.indexOf(item)
                              ? item.selectedImagePath // Use selected image
                              : item
                                  .unselectedImagePath, // Use unselected image
                          height: 25,
                        )
                      : Image.asset(
                          controller.currentIndex ==
                                  navigationItems.indexOf(item)
                              ? item.selectedImagePath // Use selected image
                              : item
                                  .unselectedImagePath, // Use unselected image
                          height: 25,
                        ),
                  5.ph,
                ],
              ),
              label: item.title,
            );
          }).toList(),
        ),
      ),
    );
  }
}

class NavigationItem {
  final String title;
  final String selectedImagePath; // Image path for the selected state
  final String unselectedImagePath; // Image path for the unselected state

  NavigationItem({
    required this.title,
    required this.selectedImagePath,
    required this.unselectedImagePath,
  });
}
