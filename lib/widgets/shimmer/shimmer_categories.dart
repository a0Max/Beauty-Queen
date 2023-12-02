import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerCategories extends StatelessWidget {
  const ShimmerCategories({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Container(
          height: 140.h,
          color: Colors.transparent,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,

            itemCount: 4,
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.symmetric(horizontal:10.r, vertical: 5.r),
                // color: Colors.black,
                child: Column(
                  children: [
                    Container(
                      width: 92.03.w,
                      height: 92.03.h,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape
                            .circle, // Use BoxShape.circle to make it circular
                      ),
                    ),
                    SizedBox(height: 10,),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      width: 60,
                      height: 20, // Customize the text style
                    ),

                  ],
                ),
              );
            },
          ),
        )

    );
  }
}