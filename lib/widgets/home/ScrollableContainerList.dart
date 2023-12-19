// ignore_for_file: file_names

import 'package:beauty_queen/models/brand_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../View/brands/branddetail_screen.dart';
import '../../const/vars.dart';

class ScrollableContainerList extends StatelessWidget {
  List<BrandModel> listOfBrands;
  ScrollableContainerList({super.key, required this.listOfBrands});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 265.11.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: listOfBrands.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Get.to(BrandDetailScreen(
                brandId: listOfBrands[index].id ?? 0,
              ));
            },
            child: Container(
              width: 265.11.w,
              height: 265.11.h,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(Connection.urlOfBrands(
                      image:
                          listOfBrands[index].homepageBrandImage?.file ?? '')),
                  fit: BoxFit.cover,
                ),
              ),
              margin: EdgeInsets.all(10.r),
            ),
          );
        },
      ),
    );
  }
}
