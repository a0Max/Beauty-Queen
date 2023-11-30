import 'package:beauty_queen/const/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../const/styles.dart';
import '../const/vars.dart';
import '../models/categories_model.dart';

class CustomImageList extends StatelessWidget {
  final List<CategoryModel> dataOfItem;
  // final List<String> texts;

  const CustomImageList(
      {super.key, required this.dataOfItem, });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: dataOfItem.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.all(10.r),
          child: Column(
            children: [
              Container(
                width: 92.03.w,
                height: 92.03.h,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(Connection.urlOfCategories(image:dataOfItem[index].image??'')),
                    fit: BoxFit.fill,
                  ),
                  shape: BoxShape
                      .circle, // Use BoxShape.circle to make it circular
                ),
              ),
              Text(
                dataOfItem[index].title??'',
                style: TextStyle(
                    fontFamily: kTheArabicSansLight,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w700,
                    color: kBlackColor), // Customize the text style
              ),
            ],
          ),
        );
      },
    );
  }
}
