import 'package:beauty_queen/const/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerItem extends StatelessWidget {
  final bool? isDelete;
  const ShimmerItem({super.key, this.isDelete});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if(isDelete == true)...{
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.4),
                      // Customize the shadow color
                      spreadRadius: 0.5,
                      // Customize how far the shadow spreads
                      blurRadius: 9,
                      // Customize the blur radius
                      offset: const Offset(0, 5), // Customize the offset
                    ),
                  ],
                  color: Colors.white,
                ),
                width: (MediaQuery
                    .of(context)
                    .size
                    .width / 2) - 20,
                height: 20,
              ),
              10.ph,
            },
            Container(
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

            ),
          ],
        ));
  }
}
