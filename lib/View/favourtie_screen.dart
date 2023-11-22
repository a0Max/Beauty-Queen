import 'package:beauty_queen/const/colors.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../const/images.dart';
import '../widgets/CustomCardWidget.dart';

class FavScreen extends StatelessWidget {
  const FavScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          backgroundColor: kWhiteColor,
          title: Text(
            "المفضلة",
            style: TextStyle(
                color: kBlackColor,
                fontSize: 27.74.sp,
                fontWeight: FontWeight.w400),
          ),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: const Icon(
                  Icons.arrow_forward_ios,
                  color: kBlackColor,
                  size: 30,
                )),
          ]),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 28.85.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Container(
                height: 52.81.h,
                width: 133.36.w,
                decoration: BoxDecoration(
                    color: klPinkColor,
                    borderRadius: BorderRadius.circular(41.r)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.delete,
                          color: kPrimaryColor,
                          size: 30.r,
                        )),
                    Text(
                      "إزالــة",
                      style: TextStyle(
                          color: kPrimaryColor,
                          fontSize: 18.74.sp,
                          fontWeight: FontWeight.w700),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 34.75.h,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomCardWidget(
                    imageUrl: kBaseImage,
                    imgtxt: 'Makeup Forever',
                    price: '150.00',
                    des: 'كريم اساس الترا اتش دي السائل من ميكب',
                    disprice: '190.00',
                    containertxt: 'تحديد الخيارات'),
                CustomCardWidget(
                    imageUrl: kLispticImage,
                    imgtxt: 'Rare Beauty',
                    price: '94.00',
                    des: 'طقم فريش اند ديوي للشفاه والخدود من رير بيوتي',
                    disprice: '94.00',
                    containertxt: 'إضافة إلي السلة'),
              ],
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomCardWidget(
                    imageUrl: kBaseImage,
                    imgtxt: 'Makeup Forever',
                    price: '150.00',
                    des: 'كريم اساس الترا اتش دي السائل من ميكب',
                    disprice: '190.00',
                    containertxt: 'تحديد الخيارات'),
                CustomCardWidget(
                    imageUrl: kLispticImage,
                    imgtxt: 'Rare Beauty',
                    price: '94.00',
                    des: 'طقم فريش اند ديوي للشفاه والخدود من رير بيوتي',
                    disprice: '94.00',
                    containertxt: 'إضافة إلي السلة'),
              ],
            ),
          ],
        ),
      ),
      // bottomNavigationBar: ReusableBottomNavigationBar(),
    );
  }
}
