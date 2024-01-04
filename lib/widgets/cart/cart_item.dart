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
            children: [
              CachedNetworkImage(
                imageUrl:
                    Connection.urlOfProducts(image: product.main_image ?? ''),
                height: 97.h,
                width: 97.w,
              ),
              5.pw,
              SizedBox(
                width: MediaQuery.of(context).size.width - 130.w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
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
                        const Spacer(),
                        Text(
                          '${tr('Del')}${product.price}',
                          style: TextStyle(
                              fontFamily: kTheArabicSansLight,
                              fontSize: 17.47.sp,
                              fontWeight: FontWeight.bold,
                              color: AppColors.kBlackColor),
                        ),
                      ],
                    ),
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
                    if (product.opTitle != null) ...{
                      Text(
                        product.opTitle ?? '',
                        style: TextStyle(
                            fontFamily: kTheArabicSansLight,
                            fontSize: 16.55.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColors.kGrayColor),
                      ),
                    },
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
            height: 40.7.h,
            width: 110.53.w,
            decoration: BoxDecoration(
              border: Border.all(width: 1.w, color: AppColors.kTextGrayColor),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                    onPressed: () {
                      productController.increment(index: index);
                    },
                    icon: const Icon(
                      Icons.add,
                      color: AppColors.kBlackColor,
                      size: 20,
                    )),
                Text(
                  '${product.qty}',
                  style: TextStyle(
                      color: AppColors.kBlackColor,
                      fontSize: 19.92.sp,
                      fontWeight: FontWeight.w600),
                ),
                IconButton(
                    onPressed: () {
                      productController.decrement(index: index);
                    },
                    icon: product.qty == '1' || product.qty == 1
                        ? SvgPicture.asset(
                            AppImages.imageDelete,
                            height: 15.01.h,
                            width: 13.26.w,
                          )
                        : const Icon(
                            CupertinoIcons.minus,
                            color: AppColors.kBlackColor,
                            size: 20,
                          ))
              ],
            ),
          ),
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
