// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../const/images.dart';

class ScrollableContainerList extends StatelessWidget {
  const ScrollableContainerList({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 265.11.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 10,
        itemBuilder: (context, index) {
          return Container(
            width: 265.11.w,
            height: 265.11.h,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(kNasictaImage),
                fit: BoxFit.cover,
              ),
            ),
            margin: EdgeInsets.all(10.r),
          );
        },
      ),
    );
  }
}
