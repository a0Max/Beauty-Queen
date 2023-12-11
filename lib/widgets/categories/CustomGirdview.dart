// ignore_for_file: file_names

import 'package:beauty_queen/const/app_images.dart';
import 'package:beauty_queen/const/colors.dart';
import 'package:beauty_queen/const/images.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../View/categories/filter_screen.dart';
import '../../const/strings.dart';
import '../../const/styles.dart';
import '../../const/vars.dart';
import '../../controller/AlKasam_controller/alkasam_controller.dart';
import '../../controller/FilterController.dart';

class CustomGridView extends StatelessWidget {
  final ScrollController? controller;
  final List<GridItemData> gridData = [
    GridItemData(
      imageAsset: AppImages.khandgranateImage, // Replace with your image
      label: tr("kPerfumes"),
      id:44,
    ),
    GridItemData(
      imageAsset: AppImages.kpaintImage, // Replace with your image
      label: tr('kMakeup'),
      id:43,
    ),
    // Add more data for additional grid items
    GridItemData(
      imageAsset: AppImages.kshampooImage, // Replace with your image
      label: tr('kHaircare'),
      id:46,
    ),
    GridItemData(
      imageAsset: AppImages.kSkincare, // Replace with your image
      label: tr('kSkincare'),
      id:45,
    ),
    GridItemData(
      imageAsset: AppImages.khandpumpImage, // Replace with your image
      label: tr('kBodyCareAndRelaxation'),
      id:48,
    ),
    GridItemData(
      imageAsset: AppImages.kPersonalCare, // Replace with your image
      label: tr('kPersonalCare'),
      id:47,
    ),

    GridItemData(
      imageAsset: AppImages.contactLenses, // Replace with your image
      label: tr('contactـlenses'),
      id:50,
    ),
    GridItemData(
      imageAsset: AppImages.shavingAndHairRemoval, // Replace with your image
      label: tr('Shaving_and_hair_removal'),
      id:49,
    ),

    GridItemData(
      imageAsset: AppImages.knailImage, // Replace with your image
      label: tr('kNails'),
      id:52,
    ),
    GridItemData(
      imageAsset: AppImages.eyelashes, // Replace with your image
      label: tr('kLashes'),
      id:51,
    ),
    GridItemData(
      imageAsset: AppImages.kBladeImage, // Replace with your image
      label: tr('kElectricalAppliances'),
      id:53,
    ),
    GridItemData(
      imageAsset: AppImages.kfirstaidImage, // Replace with your image
      label: tr('kPharmacyOfBeauty'),
      id:183,
    ),
  ];

  CustomGridView({super.key, this.controller});

  @override
  Widget build(BuildContext context) {
    // final FilterController filterController = Get.put(FilterController());
    final AlkasamController _controller = Get.put(AlkasamController());
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 13.w),
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        controller: controller,
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisSpacing: 18,
          mainAxisSpacing: 40,
          crossAxisCount: 2, // 2 containers horizontally
          childAspectRatio: 1.3,
        ),
        itemCount: gridData.length, // Number of items in the grid
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              _controller.updateCurrentCategoryId(newId:gridData[index].id, getChild: false);
              Get.to(FliterScreen(categoryId: gridData[index].id,));
            },
            child: CustomGridItem(
              imageAsset: gridData[index].imageAsset,
              label: gridData[index].label,
            ),
          );
        },
      ),
    );
  }
}

class GridItemData {
  final String imageAsset;
  final String label;
  final int id;

  GridItemData({
    required this.imageAsset,
    required this.label,
    required this.id,
  });
}

class CustomGridItem extends StatelessWidget {
  final String imageAsset;
  final String label;

  const CustomGridItem({
    super.key,
    required this.imageAsset,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: kWhiteColor,
        borderRadius: BorderRadius.circular(18.r),
        // boxShadow: [BoxShadow(blurRadius: 0.0.r)]

        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(32, 0, 0, 0),
            blurRadius: 13.r,
            offset: const Offset(0, 4),
            spreadRadius: 0,
          ),
        ],
      ),
      margin: EdgeInsets.all(8.r),
      // You can customize the container color
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            imageAsset,
            height: 44.49.h,
            width: 36.98.w,
          ),
          SizedBox(
            height: 23.h,
          ),
          Text(label,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15.sp,
                fontFamily: kTheArabicSansLight,
                fontWeight: FontWeight.w700,
              ))
        ],
      ),
    );
  }
}
