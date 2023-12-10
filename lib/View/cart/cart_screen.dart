import 'package:beauty_queen/const/app_images.dart';
import 'package:beauty_queen/const/colors.dart';
import 'package:beauty_queen/const/styles.dart';
import 'package:beauty_queen/controller/productController.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../const/images.dart';
import '../../const/vars.dart';
import '../cart_tab_screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _CartScreen();
  }

}
class _CartScreen extends State<CartScreen>{
  ProductController productController = Get.put(ProductController());

  @override
  void initState() {
    super.initState();
    productController.getCartData();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 17.w,
                          ),
                          SvgPicture.asset(AppImages.imageCarts),
                          SizedBox(
                            width: 9.w,
                          ),
                          Text(
                            tr('cart'),
                            style: TextStyle(
                                fontFamily: kTheArabicSansLight,
                                fontSize: 23.sp,
                                fontWeight: FontWeight.w700,
                                color: kPrimaryColor),
                          ),
                        ],
                      ),
                      // const Spacer(),
                      IconButton(
                          onPressed: () {
                            Get.back();
                          },
                          icon: const Icon(
                            Icons.arrow_forward_ios,
                            color: kBlackColor,
                            size: 25,
                          )),
                    ],
                  ),
                  Container(
                    color: kPrimaryColor,
                    height: 50.83.h,
                    // width: 438.44.w,
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      children: [
                        SizedBox(
                          width: 17.w,
                        ),
                        Text(
                          tr('minItemsPerOrder'),
                          style: TextStyle(
                              fontFamily: kTheArabicSansLight,
                              fontSize: 19.sp,
                              fontWeight: FontWeight.w600,
                              color: kWhiteColor),
                        ),
                        const Spacer(),
                        SvgPicture.asset(AppImages.kqueencrownImage),
                      ],
                    ),
                  ),

                  Obx(()=>Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Column(
                      children: [
                        ...List.generate(productController.cartData.value.products?.length??0, (index) => Column(
                          children: [
                            SizedBox(
                              width:MediaQuery.of(context).size.width,
                              child: Row(
                                children: [
                                  CachedNetworkImage(
                                    imageUrl:Connection.urlOfProducts(image:productController.cartData.value.products?[index].main_image??''),
                                    height: 97.h,
                                    width: 97.w,
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width-130.w,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            SizedBox(
                                              width: 19.w,
                                            ),
                                            Text(
                                              productController.cartData.value.products?[index].brand??'',
                                              style: TextStyle(
                                                  fontFamily: kTheArabicSansLight,
                                                  fontSize: 18.39.sp,
                                                  fontWeight: FontWeight.w600,
                                                  color: kBlackColor),
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                            ),
                                            const Spacer(),
                                            Text(
                                              'د.ل${productController.cartData.value.products?[index].price}',
                                              style: TextStyle(
                                                  fontFamily: kTheArabicSansLight,
                                                  fontSize: 17.47.sp,
                                                  fontWeight: FontWeight.w400,
                                                  color: kBlackColor),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          productController.cartData.value.products?[index].title??'',
                                          style: TextStyle(
                                              fontFamily: kTheArabicSansLight,
                                              fontSize: 16.55.sp,
                                              fontWeight: FontWeight.w400,
                                              color: kGrayColor),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        if (productController.cartData.value.products?[index].opTitle!=null)...{
                                          Text(
                                            productController.cartData.value
                                                .products?[index].opTitle ?? '',
                                            style: TextStyle(
                                                fontFamily: kTheArabicSansLight,
                                                fontSize: 16.55.sp,
                                                fontWeight: FontWeight.w500,
                                                color: kGrayColor),
                                          ),
                                        }
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Container(
                                height: 46.7.h,
                                width: 123.53.w,
                                decoration: BoxDecoration(
                                  border:
                                  Border.all(width: 1.w, color: kTextGrayColor),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          productController.increment(index:index);
                                        },
                                        icon: const Icon(
                                          Icons.add,
                                          color: kBlackColor,
                                          size: 30,
                                        )),
                              Obx(()=>Text(
                                      '${productController.cartData.value.products?[index].qty}',
                                      style: TextStyle(
                                          color: kBlackColor,
                                          fontSize: 21.92.sp,
                                          fontWeight: FontWeight.w600),
                                    )),
                                    IconButton(
                                        onPressed: () {
                                          productController.decrement(index: index);
                                        },
                                        icon: Image.asset(
                                          kdeleteiconImage,
                                          height: 22.01.h,
                                          width: 19.26.w,
                                        ))
                                  ],
                                ),
                              ),
                            ),

                            const Divider(
                              thickness: 1,
                              color: kTextGrayColor,
                            ),
                          ],
                        )),



                        SizedBox(
                          height: 18.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'عدد العناصر(${productController.totalCount.value}) ',
                              style: TextStyle(
                                  fontFamily: kTheArabicSansLight,
                                  fontSize: 21.sp,
                                  fontWeight: FontWeight.w400,
                                  color: kPrimaryColor),
                            ),
                            Text(
                              'الإجمالي: ${productController.totalPrice.value} دل ',
                              style: TextStyle(
                                  fontFamily: kTheArabicSansLight,
                                  fontSize: 21.sp,
                                  fontWeight: FontWeight.w700,
                                  color: kPrimaryColor),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 51.h,
                        ),
                        Container(
                          height: 53.58.h,
                          width: 398.w,
                          decoration: BoxDecoration(
                              border:
                                  Border.all(width: 1.w, color: kPrimaryColor),
                              color: klPinkColor,
                              borderRadius: BorderRadius.circular(13.r)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: 13.3.w,
                              ),
                              Image.asset(kdiscountImage),
                              Text(
                                'أدخــل رمز التخفيض',
                                style: TextStyle(
                                    fontFamily: kTheArabicSansLight,
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w500,
                                    color: kWhiteColor),
                              ),
                              Container(
                                height: 52.7.h,
                                width: 124.28.w,
                                decoration: BoxDecoration(
                                  color: kPrimaryColor,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(13.r),
                                      bottomLeft: Radius.circular(13.r)),
                                ),
                                child: Center(
                                  child: Text(
                                    'إستخدام',
                                    style: TextStyle(
                                        fontFamily: kTheArabicSansLight,
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.w600,
                                        color: kWhiteColor),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  )),
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 20),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(color: kWhiteColor, boxShadow: [
              BoxShadow(
                blurRadius: 10.r,
                offset: const Offset(0, 4),
                spreadRadius: 0,
              ),
            ]),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // SizedBox(width: 30.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                       'المجموع',
                      style: TextStyle(
                          fontFamily: kTheArabicSansLight,
                          fontSize: 15.83.sp,
                          fontWeight: FontWeight.w500,
                          color: klPinkColor),
                    ),
                    Text(
                       '${productController.totalPrice.value}دل',
                      style: TextStyle(
                          fontFamily: kTheArabicSansLight,
                          fontSize: 24.sp,
                          fontWeight: FontWeight.w400,
                          color: kPrimaryColor),
                    )
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    Get.to(() => const TabView());
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    width: MediaQuery.of(context).size.width/2,
                    decoration: BoxDecoration(
                      color: kPrimaryColor,
                      borderRadius: BorderRadius.circular(46.r),
                    ),
                    child: Center(
                      child: Text(
                        'الإستمرار',
                        style: TextStyle(
                            fontFamily: kTheArabicSansLight,
                            fontSize: 24.sp,
                            fontWeight: FontWeight.w500,
                            color: kWhiteColor),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      )),
    );
  }
}
