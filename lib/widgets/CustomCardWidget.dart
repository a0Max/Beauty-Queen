// ignore_for_file: file_names

import 'package:beauty_queen/const/styles.dart';
import 'package:beauty_queen/widgets/CustomAlertBox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../View/products_screen.dart';

class CustomCardWidget extends StatefulWidget {
  final String imageUrl;
  final String imgtxt;
  final String price;
  final String des;
  final String disprice;
  final String containertxt;

  const CustomCardWidget(
      {super.key,
      required this.imageUrl,
      required this.imgtxt,
      required this.price,
      required this.des,
      required this.disprice,
      required this.containertxt});

  @override
  State<CustomCardWidget> createState() => _CustomCardWidgetState();
}

class _CustomCardWidgetState extends State<CustomCardWidget> {
  bool isFavorite = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 0.0, right: 0.0),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.4), // Customize the shadow color
              spreadRadius: 0.5, // Customize how far the shadow spreads
              blurRadius: 9, // Customize the blur radius
              offset: const Offset(0, 5), // Customize the offset
            ),
          ],
        ),
        child: Card(
          color: const Color(0xFFDE0F7E),
          child: SizedBox(
            width: 175.78.w,
            height: 352.27.h,
            child: Stack(
              children: [
                Positioned(
                  left: 0,
                  top: 0,
                  child: GestureDetector(
                    onTap: () {
                      Get.to(const CarouselSliderPage());
                    },
                    child: SizedBox(
                      width: 191.78.w,
                      height: 352.27.h,
                      child: Stack(
                        children: [
                          Positioned(
                            left: 0,
                            top: 0,
                            child: Container(
                              width: 191.78.w,
                              height: 313.63.h,
                              decoration:
                                  const BoxDecoration(color: Colors.white),
                            ),
                          ),
                          Positioned(
                            left: 0,
                            top: 0,
                            child: Container(
                              width: 191.78.w,
                              height: 200.97.h,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(widget.imageUrl),
                                  fit: BoxFit.fill,
                                ),
                              ),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: IconButton(
                                  icon: Icon(
                                    isFavorite
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    color: isFavorite
                                        ? Colors.red
                                        : const Color(0xff13110C),
                                    size: 30,
                                  ),
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return CustomAlertDialog(
                                          height: 124.95.h,
                                          width: 367.06.w,
                                          buttonOneText:
                                              'متابعــــــة التســــوق',
                                          buttonTwoText: 'الذهاب الي المفضلة',
                                          dilougText:
                                              "لقد قمت بإضافة هذا المنتج بنجاح للمفضلة!",
                                          onButtonOnePressed: () {
                                            setState(() {
                                              isFavorite = true;
                                            });
                                          },
                                        );
                                      },
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            right: 25.w,
                            top: 220.33.h,
                            child: Text(
                              widget.imgtxt,
                              style: TextStyle(
                                color: const Color(0xFFDE0F7E),
                                fontSize: 16.sp,
                                fontFamily: kTheArabicSansLight,
                                fontWeight: FontWeight.w600,
                                height: 0.07,
                              ),
                            ),
                          ),
                          Positioned(
                            left: -5.61.w,
                            top: 240.17.h,
                            child: SizedBox(
                              width: 176.38.w,
                              height: 32.50.h,
                              child: Text(
                                widget.des,
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12.sp,
                                  fontFamily: kTheArabicSansLight,
                                  fontWeight: FontWeight.w700,
                                  height: 1,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            left: 120.14.w,
                            top: 287.01.h,
                            child: Text(
                              widget.disprice,
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
                          ),
                          Positioned(
                            left: 30.98.w,
                            top: 287.01.h,
                            child: Text(
                              widget.price,
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                color: const Color(0xFFDE0F7E),
                                fontSize: 15.16.sp,
                                fontFamily: kTheArabicSansLight,
                                fontWeight: FontWeight.w400,
                                height: 0.08,
                              ),
                            ),
                          ),
                          Positioned(
                            left: 100.81.w,
                            top: 287.14.h,
                            child: SizedBox(
                              width: 17.14.w,
                              height: 18.87.h,
                              child: Text(
                                'د.ل',
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 10.99.sp,
                                  fontFamily: kTheArabicSansLight,
                                  fontWeight: FontWeight.w400,
                                  decoration: TextDecoration.lineThrough,
                                  height: 0.15,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            left: 12.64.w,
                            top: 287.14.h,
                            child: SizedBox(
                              width: 17.14.w,
                              height: 18.87.h,
                              child: Text(
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
                            ),
                          ),
                          Positioned(
                            left: 0,
                            top: 313.63.h,
                            child: Container(
                              width: 191.78.w,
                              height: 38.64.h,
                              decoration:
                                  const BoxDecoration(color: Color(0xFFDE0F7E)),
                            ),
                          ),
                          Positioned(
                            left: 0,
                            top: 313.63.h,
                            child: Container(
                              width: 191.78.w,
                              height: 38.64.h,
                              decoration:
                                  const BoxDecoration(color: Color(0xFFDE0F7E)),
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Text(
                                    widget.containertxt,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14.11.sp,
                                      fontFamily: kTheArabicSansLight,
                                      fontWeight: FontWeight.w700,
                                      height: 0.09,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
