import 'package:beauty_queen/widgets/based/CustomAppBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../const/colors.dart';
import '../const/images.dart';

class MyStickerScreen extends StatelessWidget {
  const MyStickerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(160.h),
          child: CustomAppBar(
            showBagIcon2: true,
            showarrowIcon: true,
            searchBarWidth: 76.w,
          )),
      body: Column(
        children: [
          Image.asset(kbatchImage),
          SizedBox(
            height: 51.h,
          ),
          //////////////contianer/////////////
          Container(
            height: 167.93.h,
            width: 398.w,
            decoration: BoxDecoration(
                color: kWhiteColor, boxShadow: [BoxShadow(blurRadius: 0.5.r)]),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    height: 45.h,
                    width: 358.w,
                    color: kPrimaryColor,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: 20.w),
                        child: Text(
                          'رصيد الملصقات: 32',
                          style: TextStyle(
                              color: kWhiteColor,
                              fontSize: 17.sp,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                ///////////////second row/////////////
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      '1',
                      style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                          color: kBlackColor),
                    ),
                    Text(
                      '26/02/2023',
                      style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                          color: kBlackColor),
                    ),
                    Text(
                      'لقد حصلتي على 28 ملصق من \nالفاتورة #10',
                      style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                          color: kBlackColor),
                    ),
                  ],
                ),
                //////////second row/////////////////
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      '1',
                      style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                          color: kBlackColor),
                    ),
                    Text(
                      '26/02/2023',
                      style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                          color: kBlackColor),
                    ),
                    Text(
                      'لقد حصلتي على 28 ملصق من \nالفاتورة #10',
                      style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                          color: kBlackColor),
                    ),
                  ],
                ),
              ],
            ),
          )

          ///containerend/////////////////////
        ],
      ),
    );
  }
}
