import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerItem extends StatelessWidget {
  const ShimmerItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.4), // Customize the shadow color
                spreadRadius: 0.5, // Customize how far the shadow spreads
                blurRadius: 9, // Customize the blur radius
                offset: const Offset(0, 5), // Customize the offset
              ),
            ],
            color: Colors.white,
          ),
          width:(MediaQuery.of(context).size.width / 2) - 20,
          height: 250,

        ));
  }
}
