import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../const/colors.dart';
import '../const/images.dart';
import '../const/styles.dart';
import '../models/sales_products_model.dart';
import '../widgets/CustomCardWidget.dart';
import 'discount/filterby_screen.dart';

class QuinaproductsScreen extends StatelessWidget {
  const QuinaproductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 30.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              child: Row(
                children: [
                  Container(
                    height: 39.76.h,
                    width: 180.w,
                    decoration: BoxDecoration(
                      border: Border.all(color: kPrimaryColor, width: 1.5.w),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: DropdownButton<String>(
                            iconEnabledColor: Colors.transparent,
                            isDense: true,
                            isExpanded: true,

                            alignment: Alignment.center,
                            value: null, // Set the initial value to null
                            items: [
                              DropdownMenuItem<String>(
                                value: 'المضاف حديثاً',
                                child: Text('المضاف حديثاً',
                                    style: TextStyle(
                                      color: kBlackColor,
                                      fontSize: 14.sp,
                                      fontFamily: kTheArabicSansLight,
                                      fontWeight: FontWeight.w400,
                                      height: 0,
                                    )),
                              ),
                              DropdownMenuItem<String>(
                                value: 'الأكثر مبيعاً',
                                child: Text('الأكثر مبيعاً',
                                    style: TextStyle(
                                      color: kBlackColor,
                                      fontSize: 14.sp,
                                      fontFamily: kTheArabicSansLight,
                                      fontWeight: FontWeight.w400,
                                      height: 0,
                                    )),
                              ),
                              DropdownMenuItem<String>(
                                value: 'السعر من أقل الي الأعلي',
                                child: Text('السعر من أقل الي الأعلي',
                                    style: TextStyle(
                                      color: kBlackColor,
                                      fontSize: 14.sp,
                                      fontFamily: kTheArabicSansLight,
                                      fontWeight: FontWeight.w400,
                                      height: 0,
                                    )),
                              ),
                              DropdownMenuItem<String>(
                                value: 'السعر من الأعلي أقل الي',
                                child: Text('السعر من الأعلي أقل الي',
                                    style: TextStyle(
                                      color: kBlackColor,
                                      fontSize: 14.sp,
                                      fontFamily: kTheArabicSansLight,
                                      fontWeight: FontWeight.w400,
                                      height: 0,
                                    )),
                              ),
                            ],
                            onChanged: (String? newValue) {
                              // Handle the selected option if needed
                            },
                            hint: Text('التصنيف حسب',
                                style: TextStyle(
                                  color: kBlackColor,
                                  fontSize: 18.sp,
                                  fontFamily: kTheArabicSansLight,
                                  fontWeight: FontWeight.w400,
                                  height: 0,
                                )),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 3.w),
                          child: Image.asset(ksortIconImage),
                        ),
                      ],
                    ),
                  ),
                  //////////////second///////////////
                  Container(
                    height: 39.76.h,
                    width: 180.w,
                    decoration: BoxDecoration(
                      border: Border.all(color: kPrimaryColor, width: 1.5.w),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.to(const FilterByContainer());
                          },
                          child: Text(tr('filter_result'),
                              style: TextStyle(
                                color: kBlackColor,
                                fontSize: 18.sp,
                                fontFamily: kTheArabicSansLight,
                                fontWeight: FontWeight.w400,
                                height: 0,
                              )),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 3.w),
                          child: Image.asset(kfilterIconImage),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 21.h,
            ),
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: EdgeInsets.only(right: 16.w),
                child: Text('عدد المنتجات: 124',
                    style: TextStyle(
                      color: kGrayColor,
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w400,
                    )),
              ),
            ),
            SizedBox(
              height: 22.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomCardWidget(
                    imageUrl: kBaseImage,
                    imgtxt: 'Makeup Forever',
                    price: '150.00',
                    des: 'كريم اساس الترا اتش دي السائل من ميكب',
                    disprice: '190.00',
                    containertxt: 'تحديد الخيارات', newArrival:SalesProductsModel() ),
                CustomCardWidget(
                    imageUrl: kLispticImage,
                    imgtxt: 'Rare Beauty',
                    price: '94.00',
                    des: 'طقم فريش اند ديوي للشفاه والخدود من رير بيوتي',
                    disprice: '94.00',
                    containertxt: 'إضافة إلي السلة', newArrival:SalesProductsModel() ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomCardWidget(
                    imageUrl: kBaseImage,
                    imgtxt: 'Makeup Forever',
                    price: '150.00',
                    des: 'كريم اساس الترا اتش دي السائل من ميكب',
                    disprice: '190.00',
                    containertxt: 'تحديد الخيارات', newArrival:SalesProductsModel() ),
                CustomCardWidget(
                    imageUrl: kLispticImage,
                    imgtxt: 'Rare Beauty',
                    price: '94.00',
                    des: 'طقم فريش اند ديوي للشفاه والخدود من رير بيوتي',
                    disprice: '94.00',
                    containertxt: 'إضافة إلي السلة', newArrival:SalesProductsModel() ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomCardWidget(
                    imageUrl: kBaseImage,
                    imgtxt: 'Makeup Forever',
                    price: '150.00',
                    des: 'كريم اساس الترا اتش دي السائل من ميكب',
                    disprice: '190.00',
                    containertxt: 'تحديد الخيارات', newArrival:SalesProductsModel() ),
                CustomCardWidget(
                    imageUrl: kLispticImage,
                    imgtxt: 'Rare Beauty',
                    price: '94.00',
                    des: 'طقم فريش اند ديوي للشفاه والخدود من رير بيوتي',
                    disprice: '94.00',
                    containertxt: 'إضافة إلي السلة', newArrival:SalesProductsModel() ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomCardWidget(
                    imageUrl: kBaseImage,
                    imgtxt: 'Makeup Forever',
                    price: '150.00',
                    des: 'كريم اساس الترا اتش دي السائل من ميكب',
                    disprice: '190.00',
                    containertxt: 'تحديد الخيارات', newArrival:SalesProductsModel() ),
                CustomCardWidget(
                    imageUrl: kLispticImage,
                    imgtxt: 'Rare Beauty',
                    price: '94.00',
                    des: 'طقم فريش اند ديوي للشفاه والخدود من رير بيوتي',
                    disprice: '94.00',
                    containertxt: 'إضافة إلي السلة', newArrival:SalesProductsModel() ),
              ],
            ),
            SizedBox(
              height: 50.h,
            ),
          ],
        ),
      ),
    );
  }
}
