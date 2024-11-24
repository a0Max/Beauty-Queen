import 'package:beauty_queen/const/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerOrders extends StatelessWidget {
  const ShimmerOrders({super.key});


  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: ListView.separated(
          shrinkWrap: true,
          itemCount: 3,
          itemBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 5),
              width: (MediaQuery.of(context).size.width / 2) - 20,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              height: 163.93.h,
            );
          }, separatorBuilder: (BuildContext context, int index) { return 10.ph; },
        ));
  }
}
