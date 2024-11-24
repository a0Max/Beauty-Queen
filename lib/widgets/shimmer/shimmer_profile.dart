import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import 'shimmer_text.dart';

class ShimmerProfile extends StatelessWidget {
  const ShimmerProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 43.h,
            ),
            Row(
              children: List.generate(
                  2,
                  (index) => Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        width: 60,
                        height: 20,
                      )),
            ),
            SizedBox(
              height: 13.h,
            ),
            Container(
              // margin: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey
                        .withOpacity(0.4), // Customize the shadow color
                    spreadRadius: 0.5, // Customize how far the shadow spreads
                    blurRadius: 9, // Customize the blur radius
                    offset: const Offset(0, 5), // Customize the offset
                  ),
                ],
                color: Colors.white,
              ),
              width: MediaQuery.of(context).size.width,
              height: 258.48.h,
            ),
            SizedBox(
              height: 13.h,
            ),
            const ShimmerText(),
            SizedBox(
              height: 13.h,
            ),
            const ShimmerText()
          ],
        ));
  }
}
