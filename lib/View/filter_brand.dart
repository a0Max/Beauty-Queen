import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../const/colors.dart';
import '../const/styles.dart';
import 'filterby_screen.dart';

class FilterbyBrand extends StatelessWidget {
  const FilterbyBrand({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          Container(
            height: 64.h,
            width: 403.w,
            color: kBlackColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Text(
                    "فلترة النتائج",
                    style: TextStyle(
                        fontFamily: kTheArabicSansLight,
                        fontSize: 21.sp,
                        fontWeight: FontWeight.w500,
                        color: kWhiteColor),
                  ),
                ),
                SizedBox(
                  width: 30.w,
                ),
                IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: Icon(
                      Icons.close,
                      color: kWhiteColor,
                      size: 30.r,
                    )),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                ExpansionTile(
                  title: Text('الماركة',
                      style: TextStyle(
                          fontFamily: kTheArabicSansLight,
                          color: kBlackColor,
                          fontWeight: FontWeight.w700,
                          fontSize: 17.sp)),
                  children: [
                    const FilterOption(text: 'One Brand'),
                    Divider(
                      color: kPrimaryColor,
                      thickness: 1.w,
                    ),
                    const FilterOption(text: 'One Brand'),
                    Divider(
                      color: kPrimaryColor,
                      thickness: 1.w,
                    ),
                    const FilterOption(text: 'One Brand'),
                    Divider(
                      color: kPrimaryColor,
                      thickness: 1.w,
                    ),
                    const FilterOption(text: 'One Brand'),
                    Divider(
                      color: kPrimaryColor,
                      thickness: 1.w,
                    ),
                    const FilterOption(text: 'One Brand'),
                    Divider(
                      color: kPrimaryColor,
                      thickness: 1.w,
                    ),
                    const FilterOption(text: 'One Brand'),
                    Divider(
                      color: kPrimaryColor,
                      thickness: 1.w,
                    ),
                    const FilterOption(text: 'One Brand'),
                    Divider(
                      color: kPrimaryColor,
                      thickness: 1.w,
                    ),
                    const FilterOption(text: 'One Brand'),
                    Divider(
                      color: kPrimaryColor,
                      thickness: 1.w,
                    ),
                    const FilterOption(text: 'One Brand'),
                    Divider(
                      color: kPrimaryColor,
                      thickness: 1.w,
                    ),
                    const FilterOption(text: 'One Brand'),
                    Divider(
                      color: kPrimaryColor,
                      thickness: 1.w,
                    ),
                    const FilterOption(text: 'One Brand'),
                    Divider(
                      color: kPrimaryColor,
                      thickness: 1.w,
                    ),
                    const FilterOption(text: 'One Brand'),
                  ],
                ),
              ],
            ),
          ),
          Container(
            height: 149.97.h,
            width: 429.w,
            decoration: BoxDecoration(
                color: kWhiteColor, boxShadow: [BoxShadow(blurRadius: 0.5.r)]),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 39.55.h,
                  width: 95.w,
                  decoration: BoxDecoration(
                      border: Border.all(color: kPrimaryColor, width: 1.w),
                      borderRadius: BorderRadius.circular(10.r)),
                  child: Center(
                    child: Text(
                      "مسح الكل",
                      style: TextStyle(
                          fontFamily: kTheArabicSansLight,
                          fontSize: 17.sp,
                          fontWeight: FontWeight.w700,
                          color: kPrimaryColor),
                    ),
                  ),
                ),
                SizedBox(
                  width: 20.w,
                ),
                Container(
                  height: 39.55.h,
                  width: 95.w,
                  decoration: BoxDecoration(
                      color: kPrimaryColor,
                      border: Border.all(color: kPrimaryColor, width: 1.w),
                      borderRadius: BorderRadius.circular(10.r)),
                  child: Center(
                    child: Text(
                      'حفظ الخيارات',
                      style: TextStyle(
                          fontFamily: kTheArabicSansLight,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w700,
                          color: kWhiteColor),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
