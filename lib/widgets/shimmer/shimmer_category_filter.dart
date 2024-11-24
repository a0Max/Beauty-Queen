import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerCategoryFilter extends StatelessWidget {
  const ShimmerCategoryFilter({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Container(
          margin: EdgeInsets.only(right: 8.82.w),
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          height: 34.95.h,
          // width: 92.12.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              9.43.r,
            ),
              color: Colors.white
          ),
          width: 100,
        ));
  }
}
