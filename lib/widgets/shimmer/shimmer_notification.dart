import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerNotification extends StatelessWidget {
  const ShimmerNotification({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Column(
      children: List.generate(
        2,
        (index) => Container(
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          width: MediaQuery.of(context).size.width,
          height: 100.h,

          decoration:  BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(5.r)),
        ),
      ),
    ));
  }
}
