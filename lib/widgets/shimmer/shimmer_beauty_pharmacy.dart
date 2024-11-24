import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../../const/size.dart';

class ShimmerBeautyPharmacy extends StatelessWidget {
  const ShimmerBeautyPharmacy({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child:Stack(
          fit: StackFit.loose,
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              width: kScreenWidth,
              margin: const EdgeInsets.only(bottom: 170),
              height: 200.h,
              decoration: const BoxDecoration(
                  color: Colors.white
              ),
            ),
            Positioned(
              // bottom: -120,

              child: Container(
                margin: const EdgeInsets.only(
                    left: 20, right: 20, bottom: 20),
                width: MediaQuery.of(context).size.width -
                    40,
                height: 181.04.h,
                padding: const EdgeInsets.symmetric(
                    horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: const Color.fromARGB(
                          32, 0, 0, 0),
                      blurRadius: 28.r,
                      offset: const Offset(0, 4),
                      spreadRadius: 0,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),


    );
  }
}
