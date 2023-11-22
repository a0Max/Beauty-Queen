import 'package:beauty_queen/const/colors.dart';
import 'package:beauty_queen/const/images.dart';
import 'package:beauty_queen/const/styles.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          backgroundColor: kWhiteColor,
          title: Text(
            "طلباتي",
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
      key: _scaffoldKey,
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: Column(
            children: [
              SizedBox(
                height: 45.68.h,
              ),

              /////////////////////////////////////////////
              Container(
                height: 163.93.h,
                width: 398.w,
                decoration: BoxDecoration(
                    border: Border.all(width: 1.w, color: kTextGrayColor),
                    borderRadius: BorderRadius.circular(11.r),
                    color: kWhiteColor,
                    boxShadow: [
                      BoxShadow(
                        color: const Color.fromARGB(32, 0, 0, 0),
                        blurRadius: 28.r,
                        offset: const Offset(0, 4),
                        spreadRadius: 0,
                      ),
                    ]),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        height: 47.h,
                        width: 358.w,
                        decoration: BoxDecoration(
                            color: kCDGColor,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(11.r),
                                topRight: Radius.circular(11.r))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              "رقم الطلب: #749",
                              style: TextStyle(
                                  fontFamily: kTheArabicSansLight,
                                  color: kBlackColor,
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w600),
                            ),
                            Text(
                              "تم التسليم",
                              style: TextStyle(
                                  fontFamily: kTheArabicSansLight,
                                  color: const Color(0xff169D00),
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    ///////////////second row/////////////
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text.rich(TextSpan(children: [
                          TextSpan(
                            text: 'عدد العناصر:',
                            style: TextStyle(
                                fontFamily: kTheArabicSansLight,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                                color: kTextGrayColor),
                          ),
                          TextSpan(
                            text: '5 قطع',
                            style: TextStyle(
                                fontFamily: kTheArabicSansLight,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                                color: kPrimaryColor),
                          )
                        ])),
                        Text.rich(TextSpan(children: [
                          TextSpan(
                            text: 'تاريخ الطلب:',
                            style: TextStyle(
                                fontFamily: kTheArabicSansLight,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                                color: kTextGrayColor),
                          ),
                          TextSpan(
                            text: '20/09/2022',
                            style: TextStyle(
                                fontFamily: kTheArabicSansLight,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                                color: kBlackColor),
                          )
                        ])),
                      ],
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          height: 41.22.h,
                          width: 110.07.w,
                          color: klPinkColor,
                          child: Center(
                            child: Text.rich(TextSpan(children: [
                              TextSpan(
                                text: 'مجموع الفاتورة\n',
                                style: TextStyle(
                                    fontFamily: kTheArabicSansLight,
                                    fontSize: 10.sp,
                                    fontWeight: FontWeight.w500,
                                    color: kBlackColor),
                              ),
                              TextSpan(
                                text: '1000 LD',
                                style: TextStyle(
                                    fontFamily: kTheArabicSansLight,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600,
                                    color: kPrimaryColor),
                              )
                            ])),
                          ),
                        ),
                        /////////////second container///////////
                        GestureDetector(
                          onTap: () {
                            _showModalSheet(context);
                          },
                          child: Container(
                              height: 41.22.h,
                              width: 142.38.w,
                              decoration: BoxDecoration(
                                  color: kPrimaryColor,
                                  borderRadius: BorderRadius.circular(10.r)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '     تفاصيل الطلب',
                                    style: TextStyle(
                                        fontFamily: kTheArabicSansLight,
                                        fontSize: 13.sp,
                                        fontWeight: FontWeight.w700,
                                        color: kWhiteColor),
                                  ),
                                  IconButton(
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.arrow_forward_ios,
                                        color: kWhiteColor,
                                        size: 15.r,
                                      ))
                                ],
                              )),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 12.h,
              ),
              ////////////////second contianer//////////////
              Container(
                height: 163.93.h,
                width: 398.w,
                decoration: BoxDecoration(
                    border: Border.all(width: 1.w, color: kTextGrayColor),
                    borderRadius: BorderRadius.circular(11.r),
                    color: kWhiteColor,
                    boxShadow: [
                      BoxShadow(
                        color: const Color.fromARGB(32, 0, 0, 0),
                        blurRadius: 28.r,
                        offset: const Offset(0, 4),
                        spreadRadius: 0,
                      ),
                    ]),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        height: 47.h,
                        width: 358.w,
                        decoration: BoxDecoration(
                            color: kCDGColor,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(11.r),
                                topRight: Radius.circular(11.r))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              "رقم الطلب: #749",
                              style: TextStyle(
                                  fontFamily: kTheArabicSansLight,
                                  color: kBlackColor,
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w600),
                            ),
                            Text(
                              'إلغيت',
                              style: TextStyle(
                                  fontFamily: kTheArabicSansLight,
                                  color: kOrangeColor,
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    ///////////////second row/////////////
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text.rich(TextSpan(children: [
                          TextSpan(
                            text: 'عدد العناصر:',
                            style: TextStyle(
                                fontFamily: kTheArabicSansLight,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                                color: kTextGrayColor),
                          ),
                          TextSpan(
                            text: '5 قطع',
                            style: TextStyle(
                                fontFamily: kTheArabicSansLight,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                                color: kPrimaryColor),
                          )
                        ])),
                        Text.rich(TextSpan(children: [
                          TextSpan(
                            text: 'تاريخ الطلب:',
                            style: TextStyle(
                                fontFamily: kTheArabicSansLight,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                                color: kTextGrayColor),
                          ),
                          TextSpan(
                            text: '20/09/2022',
                            style: TextStyle(
                                fontFamily: kTheArabicSansLight,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                                color: kBlackColor),
                          )
                        ])),
                      ],
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          height: 41.22.h,
                          width: 110.07.w,
                          color: klPinkColor,
                          child: Center(
                            child: Text.rich(TextSpan(children: [
                              TextSpan(
                                text: 'مجموع الفاتورة\n',
                                style: TextStyle(
                                    fontFamily: kTheArabicSansLight,
                                    fontSize: 10.sp,
                                    fontWeight: FontWeight.w500,
                                    color: kBlackColor),
                              ),
                              TextSpan(
                                text: '1000 LD',
                                style: TextStyle(
                                    fontFamily: kTheArabicSansLight,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600,
                                    color: kPrimaryColor),
                              )
                            ])),
                          ),
                        ),
                        /////////////second container///////////
                        GestureDetector(
                          onTap: () {
                            _showModalSheet(context);
                          },
                          child: Container(
                              height: 41.22.h,
                              width: 142.38.w,
                              decoration: BoxDecoration(
                                  color: kPrimaryColor,
                                  borderRadius: BorderRadius.circular(10.r)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '     تفاصيل الطلب',
                                    style: TextStyle(
                                        fontFamily: kTheArabicSansLight,
                                        fontSize: 13.sp,
                                        fontWeight: FontWeight.w700,
                                        color: kWhiteColor),
                                  ),
                                  IconButton(
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.arrow_forward_ios,
                                        color: kWhiteColor,
                                        size: 15.r,
                                      ))
                                ],
                              )),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 12.h,
              ),
              //////////////////////////////third container/////////////////////
              Container(
                height: 163.93.h,
                width: 398.w,
                decoration: BoxDecoration(
                    border: Border.all(width: 1.w, color: kTextGrayColor),
                    borderRadius: BorderRadius.circular(11.r),
                    color: kWhiteColor,
                    boxShadow: [
                      BoxShadow(
                        color: const Color.fromARGB(32, 0, 0, 0),
                        blurRadius: 28.r,
                        offset: const Offset(0, 4),
                        spreadRadius: 0,
                      ),
                    ]),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        height: 47.h,
                        width: 358.w,
                        decoration: BoxDecoration(
                            color: kCDGColor,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(11.r),
                                topRight: Radius.circular(11.r))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              "رقم الطلب: #749",
                              style: TextStyle(
                                  fontFamily: kTheArabicSansLight,
                                  color: kBlackColor,
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w600),
                            ),
                            Text(
                              "تم التسليم",
                              style: TextStyle(
                                  fontFamily: kTheArabicSansLight,
                                  color: const Color(0xff169D00),
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    ///////////////second row/////////////
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text.rich(TextSpan(children: [
                          TextSpan(
                            text: 'عدد العناصر:',
                            style: TextStyle(
                                fontFamily: kTheArabicSansLight,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                                color: kTextGrayColor),
                          ),
                          TextSpan(
                            text: '5 قطع',
                            style: TextStyle(
                                fontFamily: kTheArabicSansLight,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                                color: kPrimaryColor),
                          )
                        ])),
                        Text.rich(TextSpan(children: [
                          TextSpan(
                            text: 'تاريخ الطلب:',
                            style: TextStyle(
                                fontFamily: kTheArabicSansLight,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                                color: kTextGrayColor),
                          ),
                          TextSpan(
                            text: '20/09/2022',
                            style: TextStyle(
                                fontFamily: kTheArabicSansLight,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                                color: kBlackColor),
                          )
                        ])),
                      ],
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          height: 41.22.h,
                          width: 110.07.w,
                          color: klPinkColor,
                          child: Center(
                            child: Text.rich(TextSpan(children: [
                              TextSpan(
                                text: 'مجموع الفاتورة\n',
                                style: TextStyle(
                                    fontFamily: kTheArabicSansLight,
                                    fontSize: 10.sp,
                                    fontWeight: FontWeight.w500,
                                    color: kBlackColor),
                              ),
                              TextSpan(
                                text: '1000 LD',
                                style: TextStyle(
                                    fontFamily: kTheArabicSansLight,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600,
                                    color: kPrimaryColor),
                              )
                            ])),
                          ),
                        ),

                        /////////////second container///////////
                        GestureDetector(
                          onTap: () {
                            _showModalSheet(context);
                          },
                          child: Container(
                              height: 41.22.h,
                              width: 142.38.w,
                              decoration: BoxDecoration(
                                  color: kPrimaryColor,
                                  borderRadius: BorderRadius.circular(10.r)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '     تفاصيل الطلب',
                                    style: TextStyle(
                                        fontFamily: kTheArabicSansLight,
                                        fontSize: 13.sp,
                                        fontWeight: FontWeight.w700,
                                        color: kWhiteColor),
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    color: kWhiteColor,
                                    size: 15.r,
                                  )
                                ],
                              )),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

void _showModalSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return SizedBox(
        height: MediaQuery.of(context).size.height * 0.85,
        child: Scaffold(
            appBar: AppBar(
              surfaceTintColor: kWhiteColor,
              automaticallyImplyLeading: false,
              elevation: 1,
              backgroundColor: kWhiteColor,
              actions: [
                IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: Icon(
                      Icons.close,
                      size: 30.r,
                      color: kPrimaryColor,
                    )),
              ],
              title: Text(
                "سجل الطلبات",
                style: TextStyle(
                    fontFamily: kTheArabicSansLight,
                    color: kBlackColor,
                    fontSize: 23.74.sp,
                    fontWeight: FontWeight.w600),
              ),
              centerTitle: true,
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 33.h,
                  ),
                  Stack(
                    children: [
                      Image.asset(
                        kcardImage,
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(32.w, 24.h, 32.w, 0.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment
                              .spaceBetween, // To place text on the left and right
                          children: [
                            Text.rich(TextSpan(children: [
                              TextSpan(
                                text: 'تاريخ و وقت الطلب:\n',
                                style: TextStyle(
                                  fontFamily: kTheArabicSansLight,
                                  fontSize: 17.sp,
                                  fontWeight: FontWeight.w500,
                                  color: kBlackColor,
                                ),
                              ),
                              TextSpan(
                                text: '08/08/2023 04:00',
                                style: TextStyle(
                                  fontFamily: kTheArabicSansLight,
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w600,
                                  color: kPrimaryColor,
                                ),
                              )
                            ])),
                            Text.rich(TextSpan(children: [
                              TextSpan(
                                text: 'رقم الطلب:\n',
                                style: TextStyle(
                                  fontFamily: kTheArabicSansLight,
                                  fontSize: 17.sp,
                                  fontWeight: FontWeight.w500,
                                  color: kBlackColor,
                                ),
                              ),
                              TextSpan(
                                text: '749#',
                                style: TextStyle(
                                  fontFamily: kTheArabicSansLight,
                                  fontSize: 22.sp,
                                  fontWeight: FontWeight.w600,
                                  color: kPrimaryColor,
                                ),
                              )
                            ])),
                          ],
                        ),
                      ),
                      Positioned(
                        top: 120.h,
                        right: 32.w,
                        child: Row(
                          children: [
                            Text(
                              'منتجات (2)',
                              style: TextStyle(
                                fontFamily: kTheArabicSansLight,
                                fontSize: 22.53.sp,
                                fontWeight: FontWeight.w600,
                                color: kBlackColor,
                              ),
                            ),
                            SizedBox(
                              width: 90.w,
                            ),
                            Container(
                              height: 47.h,
                              width: 140.w,
                              decoration: BoxDecoration(
                                  color: const Color(0xffE0FCDB),
                                  borderRadius: BorderRadius.circular(9.r)),
                              child: Center(
                                child: Text(
                                  'تم التسليم',
                                  style: TextStyle(
                                    fontFamily: kTheArabicSansLight,
                                    fontSize: 17.sp,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xff27AE60),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),

                      //////////////////column//////////////
                      Padding(
                          padding: EdgeInsets.only(
                              top: 190.h, left: 25.w, right: 20.w),
                          child: Column(children: [
                            SizedBox(
                              height: 107.62.h,
                              width: 346.94.w,
                              child: Stack(
                                children: [
                                  Image.asset(
                                    krevitImage,
                                    height: 97.h,
                                    width: 97.w,
                                  ),
                                  Positioned(
                                    right: 110.w,
                                    child: Text(
                                      "L’oreal",
                                      style: TextStyle(
                                          fontFamily: kTheArabicSansLight,
                                          fontSize: 17.44.sp,
                                          fontWeight: FontWeight.w600,
                                          color: kBlackColor),
                                    ),
                                  ),
                                  Positioned(
                                    right: 290.w,
                                    child: Text(
                                      '149LD',
                                      style: TextStyle(
                                          fontFamily: kTheArabicSansLight,
                                          fontSize: 16.57.sp,
                                          fontWeight: FontWeight.w600,
                                          color: kPrimaryColor),
                                    ),
                                  ),
                                  Positioned(
                                    top: 22.h,
                                    right: 110.w,
                                    child: Text(
                                      'كريم لوريال رفيتا ليفت لمحيط \nالعين',
                                      style: TextStyle(
                                          fontFamily: kTheArabicSansLight,
                                          fontSize: 15.7.sp,
                                          fontWeight: FontWeight.w500,
                                          color: kGrayColor),
                                    ),
                                  ),
                                  Positioned(
                                    top: 80.h,
                                    right: 110.w,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "اللون:",
                                          style: TextStyle(
                                              fontFamily: kTheArabicSansLight,
                                              fontSize: 15.sp,
                                              fontWeight: FontWeight.w500,
                                              color: kTextGrayColor),
                                        ),
                                        Text(
                                          ' أزرق غامق',
                                          style: TextStyle(
                                              fontFamily: kTheArabicSansLight,
                                              fontSize: 14.83.sp,
                                              fontWeight: FontWeight.w600,
                                              color: kBlackColor),
                                        ),
                                        SizedBox(
                                          width: 60.w,
                                        ),
                                        Text(
                                          '1x قطعة',
                                          style: TextStyle(
                                              fontFamily: kTheArabicSansLight,
                                              fontSize: 14.83.sp,
                                              fontWeight: FontWeight.w600,
                                              color: kBlackColor),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ])),
                      //////////////second one////////////////

                      Padding(
                          padding: EdgeInsets.only(
                              top: 320.h, left: 25.w, right: 20.w),
                          child: Column(children: [
                            Divider(
                              indent: 20.w,
                              endIndent: 20.w,
                              thickness: 2.w,
                              color: const Color(0xffE9E9E9),
                            ),
                            SizedBox(
                              height: 25.h,
                            ),
                            SizedBox(
                              height: 107.62.h,
                              width: 346.94.w,
                              child: Stack(
                                children: [
                                  Image.asset(
                                    krevitImage,
                                    height: 97.h,
                                    width: 97.w,
                                  ),
                                  Positioned(
                                    right: 110.w,
                                    child: Text(
                                      "L’oreal",
                                      style: TextStyle(
                                          fontFamily: kTheArabicSansLight,
                                          fontSize: 17.44.sp,
                                          fontWeight: FontWeight.w600,
                                          color: kBlackColor),
                                    ),
                                  ),
                                  Positioned(
                                    right: 290.w,
                                    child: Text(
                                      '149LD',
                                      style: TextStyle(
                                          fontFamily: kTheArabicSansLight,
                                          fontSize: 16.57.sp,
                                          fontWeight: FontWeight.w600,
                                          color: kPrimaryColor),
                                    ),
                                  ),
                                  Positioned(
                                    top: 22.h,
                                    right: 110.w,
                                    child: Text(
                                      'كريم لوريال رفيتا ليفت لمحيط \nالعين',
                                      style: TextStyle(
                                          fontFamily: kTheArabicSansLight,
                                          fontSize: 15.7.sp,
                                          fontWeight: FontWeight.w500,
                                          color: kGrayColor),
                                    ),
                                  ),
                                  Positioned(
                                    top: 80.h,
                                    right: 110.w,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "اللون:",
                                          style: TextStyle(
                                              fontFamily: kTheArabicSansLight,
                                              fontSize: 15.sp,
                                              fontWeight: FontWeight.w500,
                                              color: kTextGrayColor),
                                        ),
                                        Text(
                                          ' أزرق غامق',
                                          style: TextStyle(
                                              fontFamily: kTheArabicSansLight,
                                              fontSize: 14.83.sp,
                                              fontWeight: FontWeight.w600,
                                              color: kBlackColor),
                                        ),
                                        SizedBox(
                                          width: 60.w,
                                        ),
                                        Text(
                                          '1x قطعة',
                                          style: TextStyle(
                                              fontFamily: kTheArabicSansLight,
                                              fontSize: 14.83.sp,
                                              fontWeight: FontWeight.w600,
                                              color: kBlackColor),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ])),
                      /////////////end second one/////////////
                    ],
                  ),
                  ///////////divder/////////
                  Row(children: <Widget>[
                    Expanded(
                        child: Divider(
                      endIndent: 10.w,
                      color: kTextGrayColor,
                      thickness: 1.w,
                      indent: 10.w,
                    )),
                    Text(
                      'عدد العناصر',
                      style: TextStyle(
                          fontFamily: kTheArabicSansLight,
                          fontSize: 17.sp,
                          fontWeight: FontWeight.w500,
                          color: kTextGrayColor),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Text(
                      '5 قطع',
                      style: TextStyle(
                          fontFamily: kTheArabicSansLight,
                          fontSize: 19.53.sp,
                          fontWeight: FontWeight.w600,
                          color: kPrimaryColor),
                    ),
                    Expanded(
                        child: Divider(
                      endIndent: 10.w,
                      color: kTextGrayColor,
                      thickness: 1.w,
                      indent: 10.w,
                    )),
                  ]),
                  SizedBox(
                    height: 24.h,
                  ),
                  ////////////////contianer////////
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Column(
                      children: [
                        Container(
                          height: 137.9.h,
                          width: 398.51.w,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14.r),
                              color: kWhiteColor,
                              boxShadow: [BoxShadow(blurRadius: 0.5.r)]),
                          child: Padding(
                            padding: EdgeInsets.only(right: 20.w),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 10.h,
                                ),
                                Align(
                                  alignment: Alignment.topRight,
                                  child: Text(
                                    'طريقة الإستلام',
                                    style: TextStyle(
                                        fontFamily: kTheArabicSansLight,
                                        fontSize: 19.sp,
                                        fontWeight: FontWeight.w600,
                                        color: klPinkColor),
                                  ),
                                ),
                                Row(children: [
                                  Image.asset(kaddressImage),
                                  SizedBox(
                                    width: 10.w,
                                  ),
                                  Text(
                                    'عين زارة - السدرة , طرابلسعين زارة - \nالسدرة , طرابلس',
                                    style: TextStyle(
                                        fontFamily: kTheArabicSansLight,
                                        fontSize: 18.1.sp,
                                        fontWeight: FontWeight.w500,
                                        color: kBlackColor),
                                  ),
                                ]),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 47.h,
                        ),
                        ////////////rows///////////
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'خصم البروموكود',
                                style: TextStyle(
                                    fontFamily: kTheArabicSansLight,
                                    fontSize: 18.1.sp,
                                    fontWeight: FontWeight.w400,
                                    color: kTextGrayColor),
                              ),
                              Text(
                                '00.00',
                                style: TextStyle(
                                    fontFamily: kTheArabicSansLight,
                                    fontSize: 18.1.sp,
                                    fontWeight: FontWeight.w500,
                                    color: kBlackColor),
                              ),
                            ]),
                        ///////////second row////////
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'خصم البروموكود',
                                style: TextStyle(
                                    fontFamily: kTheArabicSansLight,
                                    fontSize: 18.1.sp,
                                    fontWeight: FontWeight.w400,
                                    color: kTextGrayColor),
                              ),
                              Text(
                                '00.00',
                                style: TextStyle(
                                    fontFamily: kTheArabicSansLight,
                                    fontSize: 18.1.sp,
                                    fontWeight: FontWeight.w500,
                                    color: kBlackColor),
                              ),
                            ]),
                        /////////third row//////////////
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'خصم البروموكود',
                                style: TextStyle(
                                    fontFamily: kTheArabicSansLight,
                                    fontSize: 18.1.sp,
                                    fontWeight: FontWeight.w400,
                                    color: kTextGrayColor),
                              ),
                              Text(
                                '00.00',
                                style: TextStyle(
                                    fontFamily: kTheArabicSansLight,
                                    fontSize: 18.1.sp,
                                    fontWeight: FontWeight.w500,
                                    color: kBlackColor),
                              ),
                            ]),
                        Divider(
                          color: kTextGrayColor,
                          thickness: 1.w,
                        ),
                        SizedBox(
                          height: 30.h,
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'الإجمــالي',
                                style: TextStyle(
                                    fontFamily: kTheArabicSansLight,
                                    fontSize: 19.sp,
                                    fontWeight: FontWeight.w600,
                                    color: kBlackColor),
                              ),
                              Text(
                                '900 LYD',
                                style: TextStyle(
                                    fontFamily: kTheArabicSansLight,
                                    fontSize: 22.44.sp,
                                    fontWeight: FontWeight.w600,
                                    color: kPrimaryColor),
                              ),
                            ]),
                        ///////////////////////// fourth container

                        SizedBox(
                          height: 50.h,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )),
      );
    },
  );
}
