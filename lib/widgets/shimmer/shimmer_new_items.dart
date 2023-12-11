import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../../const/app_colors.dart';

class ShimmerNewItems extends StatelessWidget {
  const ShimmerNewItems({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: SizedBox(
          height: 350.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 3,
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
                        decoration: const BoxDecoration(
                            color: Colors.white
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
                          // child:
                          ),
                        ),

                    ],
                  ),
                ),
              );
            },
          ),
        )

    );
  }
}