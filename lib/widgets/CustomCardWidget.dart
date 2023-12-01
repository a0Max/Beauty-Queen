// ignore_for_file: file_names

import 'package:beauty_queen/const/styles.dart';
import 'package:beauty_queen/widgets/CustomAlertBox.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../View/products_screen.dart';
import '../const/app_colors.dart';
import '../models/product_options_model.dart';

class CustomCardWidget extends StatefulWidget {
  final String imageUrl;
  final String imgtxt;
  final String? price;
  final String des;
  final String? inStock;
  final String? disprice;
  final List<ProductOptionsModel>? productOptions;
  final String? note;
  final String? containertxt;

  const CustomCardWidget(
      {super.key,
      required this.imageUrl,
      required this.imgtxt,
      this.price,
      required this.des,
      this.disprice,
        this.containertxt,
      this.note, this.inStock,
        this.productOptions});

  @override
  State<CustomCardWidget> createState() => _CustomCardWidgetState();
}

class _CustomCardWidgetState extends State<CustomCardWidget> {
  bool isFavorite = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
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
      width: (MediaQuery.of(context).size.width/2)-20,
      // height: 152.27.h,
      child: InkWell(
        onTap: () {
          Get.to(const CarouselSliderPage());
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 200.h,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: CachedNetworkImageProvider(widget.imageUrl),
                  fit: BoxFit.fill,
                ),
              ),
              child: Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  icon: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: isFavorite ? Colors.red : const Color(0xff13110C),
                    // size: 30,
                  ),
                  onPressed: () {
                    // showDialog(
                    //   context: context,
                    //   builder: (BuildContext context) {
                    //     return CustomAlertDialog(
                    //       height: 124.95.h,
                    //       width: 367.06.w,
                    //       buttonOneText: 'متابعــــــة التســــوق',
                    //       buttonTwoText: 'الذهاب الي المفضلة',
                    //       dilougText:
                    //           "لقد قمت بإضافة هذا المنتج بنجاح للمفضلة!",
                    //       onButtonOnePressed: () {
                    //         setState(() {
                    //           isFavorite = true;
                    //         });
                    //       },
                    //     );
                    //   },
                    // );
                  },
                ),
              ),
            ),
            Container(
              height: 100,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(horizontal: 9),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.imgtxt,
                    style: TextStyle(
                      color: const Color(0xFFDE0F7E),
                      fontSize: 16.sp,
                      fontFamily: kTheArabicSansLight,
                      fontWeight: FontWeight.w600,
                      // height: 0.07,
                    ),
                  ),
                  Text(
                    widget.des,
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12.sp,
                      fontFamily: kTheArabicSansLight,
                      fontWeight: FontWeight.w700,
                      // height: 1,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (widget.disprice != null &&
                          widget.disprice != '' &&
                          widget.disprice != '' &&
                          widget.disprice?.split('').first != '0') ...{
                        Row(
                          children: [
                            Text(
                              widget.disprice ?? '',
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15.16.sp,
                                fontFamily: kTheArabicSansLight,
                                fontWeight: FontWeight.w400,
                                decoration: TextDecoration.lineThrough,
                                height: 0.08,
                              ),
                            ),
                            Text(
                              'د.ل',
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 10.99.sp,
                                fontFamily: kTheArabicSansLight,
                                fontWeight: FontWeight.w400,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                          ],
                        ),
                      },
                      if (widget.price != null &&
                          widget.price != '' &&
                          widget.price != '' &&
                          widget.price?.split('').first != '0') ...{
                        Row(
                          children: [
                            Text(
                              widget.price ?? '',
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                color: const Color(0xFFDE0F7E),
                                fontSize: 15.16.sp,
                                fontFamily: kTheArabicSansLight,
                                fontWeight: FontWeight.w400,
                                height: 0.08,
                              ),
                            ),
                            Text(
                              'د.ل',
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                color: const Color(0xFFDE0F7E),
                                fontSize: 10.99.sp,
                                fontFamily: kTheArabicSansLight,
                                fontWeight: FontWeight.w400,
                                height: 0.15,
                              ),
                            ),
                          ],
                        )
                      }
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
            if(widget.inStock==null||widget.inStock=="0")...{
              Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(vertical: 10),
                alignment: Alignment.center,
                decoration: const BoxDecoration(color: AppColors.kCDGColor),
                child: Text(
                  tr('not_availble_now'),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.11.sp,
                    fontFamily: kTheArabicSansLight,
                    fontWeight: FontWeight.w700,
                    // height: 0.09,
                  ),
                ),
              ),
            }else if((widget.inStock!=null&&widget.inStock!="0") &&(widget.productOptions!=null&& widget.productOptions?.isNotEmpty==true) )...{
              Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(vertical: 10),
                alignment: Alignment.center,
                decoration: const BoxDecoration(color: AppColors.kPrimaryColor),
                child: Text(
                  tr('choose_the_category'),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.11.sp,
                    fontFamily: kTheArabicSansLight,
                    fontWeight: FontWeight.w700,
                    // height: 0.09,
                  ),
                ),
              ),
            } else...{
            Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(vertical: 10),
              alignment: Alignment.center,
              decoration: const BoxDecoration(color: AppColors.kPrimaryColor),
              child: Text(
                tr('add_to_bags'),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.11.sp,
                  fontFamily: kTheArabicSansLight,
                  fontWeight: FontWeight.w700,
                  // height: 0.09,
                ),
              ),
            ),
            }
          ],
        ),
      ),
    );
  }
}
