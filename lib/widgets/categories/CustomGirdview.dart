// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../View/categories/filter_screen.dart';
import '../../const/app_colors.dart';
import '../../const/styles.dart';
import '../../const/vars.dart';
import '../../controller/AlKasam_controller/alkasam_controller.dart';

class CustomGridView extends StatelessWidget {
  final ScrollController? scrollController;

  const CustomGridView({super.key, this.scrollController});

  @override
  Widget build(BuildContext context) {
    // final FilterController filterController = Get.put(FilterController());
    final AlkasamController controller = Get.put(AlkasamController());
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 13.w),
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        controller: scrollController,
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisSpacing: 18,
          mainAxisSpacing: 40,
          crossAxisCount: 2, // 2 containers horizontally
          childAspectRatio: 1.3,
        ),
        itemCount: Connection.gridData.length, // Number of items in the grid
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              controller.updateCurrentCategoryId(newId:Connection.gridData[index].id, getChild: false);
              Get.to(FliterScreen(categoryId: Connection.gridData[index].id,));
            },
            child: CustomGridItem(
              imageAsset: Connection.gridData[index].imageAsset,
              label: Connection.gridData[index].label,
            ),
          );
        },
      ),
    );
  }
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
        color: AppColors.kWhiteColor,
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
