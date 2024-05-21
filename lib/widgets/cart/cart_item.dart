import 'package:beauty_queen/const/extensions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../const/app_colors.dart';
import '../../const/app_images.dart';
import '../../const/styles.dart';
import '../../const/vars.dart';
import '../../controller/cart_controller/productController.dart';
import '../../models/products_model.dart';

class CartItem extends StatelessWidget {
  final ProductsModel product;
  final int index;
  const CartItem({super.key, required this.product, required this.index});
  @override
  Widget build(BuildContext context) {
    ProductController productController = Get.put(ProductController());

    return Column(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if ((product.main_image ?? '').split('_').first == 'product') ...{
                CachedNetworkImage(
                  imageUrl:
                      Connection.urlOfProducts(image: product.main_image ?? ''),
                  height: 97.h,
                  width: 97.w,
                ),
              } else ...{
                CachedNetworkImage(
                  imageUrl:
                      Connection.urlOfOptions(image: product.main_image ?? ''),
                  height: 97.h,
                  width: 97.w,
                ),
              },
              5.pw,
              SizedBox(
                width: MediaQuery.of(context).size.width - (130.w + 110.53.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    if (product.brand != null) ...{
                      Text(
                        product.brand ?? '',
                        style: TextStyle(
                            fontFamily: kTheArabicSansLight,
                            fontSize: 18.39.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.kBlackColor),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      )
                    } else if (product.code == GiftCode.gift100 ||
                        product.code == GiftCode.gift250 ||
                        product.code == GiftCode.gift500) ...{
                      Text(
                        product.code ?? '',
                        style: TextStyle(
                            fontFamily: kTheArabicSansLight,
                            fontSize: 16.55.sp,
                            fontWeight: FontWeight.bold,
                            color: AppColors.blackColor),
                      ),
                    },
                    10.ph,
                    Text(
                      product.title ?? '',
                      style: TextStyle(
                          fontFamily: kTheArabicSansLight,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.kGrayColor.withOpacity(.4)),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    // if (product.opTitle != null) ...{
                    Text(
                      "${product.opTitle ?? ''} - ${product.opCode ?? ''}",
                      style: TextStyle(
                          fontFamily: kTheArabicSansLight,
                          fontSize: 16.55.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.kGrayColor),
                    ),
                    // },
                  ],
                ),
              ),
              Column(
                children: [
                  Text(
                    '${product.price}${tr('Del')}',
                    style: TextStyle(
                        fontFamily: kTheArabicSansLight,
                        fontSize: 17.47.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.kBlackColor),
                  ),
                  10.ph,
                  GestureDetector(
                    onTap: () {
                      productController.removeFromCart(index: index);
                    },
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          AppImages.imageDelete2,
                          height: 20.01.h,
                          width: 13.26.w,
                        ),
                        Text(
                          ' إزالة ',
                          style: TextStyle(
                              color: AppColors.mainColor,
                              fontSize: 19.92.sp,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                  10.ph,
                  SizedBox(
                    width: 100.w,
                    child: DropdownButtonFormField<String>(
                      padding: EdgeInsets.zero,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: AppColors.kTextGrayColor, width: 1.w),
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: AppColors.kTextGrayColor, width: 1.w),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: AppColors.kTextGrayColor, width: 1.w),
                        ),
                      ),
                      value: '${product.qty}',
                      alignment: Alignment.center,
                      onChanged: (String? newValue) {
                        productController.increment(
                            index: index, newValue: newValue ?? '1');
                      },
                      items: List.generate(int.parse("${5}"), (index) {
                        return DropdownMenuItem<String>(
                          value: '${index + 1}',
                          child: Text(
                            '${index + 1}',
                            style: TextStyle(
                                fontFamily: kTheArabicSansLight,
                                fontSize: 17.47.sp,
                                fontWeight: FontWeight.w400,
                                color: AppColors.kBlackColor),
                          ),
                        );
                      }),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(
          height: 10.h,
        ),
        SizedBox(
          height: 21.h,
        ),
        const Divider(
          thickness: 1,
          color: AppColors.kTextGrayColor,
        ),
      ],
    );
  }
}
