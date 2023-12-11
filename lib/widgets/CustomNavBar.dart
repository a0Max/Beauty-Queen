// ignore_for_file: file_names, unrelated_type_equality_checks

import 'package:beauty_queen/const/styles.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../const/app_images.dart';
import '../const/colors.dart';
import '../controller/nav_bar_controller/NavBarController.dart';

class ReusableBottomNavigationBar extends StatelessWidget {
  const ReusableBottomNavigationBar({Key? key}) : super(key: key);

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
          unselectedImagePath: AppImages.imageCategoriesUnSelected,
          selectedImagePath: AppImages.imageCategoriesSelected),
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
    return Obx(
      () => SizedBox(
        // height: 103.29.h,
        child: BottomNavigationBar(
          backgroundColor: kWhiteColor,
          selectedIconTheme: const IconThemeData(
            color: kPrimaryColor,
          ),
          unselectedIconTheme: const IconThemeData(color: kBlackColor),
          elevation: 0,
          selectedItemColor: kPrimaryColor,
          unselectedItemColor: kTextGrayColor,
          selectedLabelStyle: TextStyle(
              height: 2.h,
              color: kBlackColor,
              fontFamily: kTheArabicSansLight,
              fontSize: 12.sp,
              fontWeight: FontWeight.w700),
          unselectedLabelStyle: TextStyle(
              color: kBlackColor,
              fontFamily: kTheArabicSansLight,
              fontSize: 12.sp,
              fontWeight: FontWeight.w700),
          currentIndex: controller.currentIndex.value,
          type: BottomNavigationBarType.fixed,
          onTap: (index) {
            controller.updateIndex(index);
          },
          items: navigationItems.map((item) {
            return BottomNavigationBarItem(
              icon: SvgPicture.asset(
                controller.currentIndex == navigationItems.indexOf(item)
                    ? item.selectedImagePath // Use selected image
                    : item.unselectedImagePath, // Use unselected image
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
